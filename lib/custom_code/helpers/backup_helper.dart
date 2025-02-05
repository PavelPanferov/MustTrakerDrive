import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_pro_drive/custom_code/actions/get_system_token.dart';

import '/custom_code/actions/get_system_token.dart' as system_token;

class BackupHelper {
  static Future<bool> backupLocations({
    required List<Map<String, dynamic>> locations,
    required String userID,
  }) async {
    try {
      // Получаем все накопленные данные местоположения из базы данных
      if (locations.isEmpty) {
        print('Нет данных для отправки');
        return false;
      }

      // Проверяем наличие интернет-соединения
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.first == ConnectivityResult.none) {
        print('Нет подключения к интернету. Данные будут отправлены позже.');
        return false;
      }

      // Получаем SystemToken
      String systemToken;
      try {
        systemToken = await system_token.getSystemToken();
      } catch (e) {
        print('Не удалось получить SystemToken: $e');
        return false;
      }

      int batchSize = 99999; // Максимальный размер пакета данных
      int successfullySent = 0;
      int totalRecords = locations.length;

      print('Отправка $totalRecords записей');

      // Разбиваем данные на пакеты и отправляем
      for (var i = 0; i < totalRecords; i += batchSize) {
        var end = (i + batchSize < totalRecords) ? i + batchSize : totalRecords;
        var batch = locations.sublist(i, end);

        var requestBody = {
          "userId": int.parse(userID),
          "coordinates": locations,
        };

        bool success = false;
        int retryCount = 0;
        int maxRetries = 3;

        do {
          try {
            var response = await http.put(
              Uri.parse('https://must-games.back.must.io/api/tracker/gps-data'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $systemToken',
              },
              body: jsonEncode(requestBody),
            );

            // Добавляем обработку ошибки авторизации
            if (response.statusCode == 401) {
              print('Токен недействителен, получаем новый...');
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('systemToken');
              await prefs.remove('systemTokenExpiry');

              try {
                systemToken = await getSystemToken();
                continue; // Повторяем запрос с новым токеном
              } catch (e) {
                print('Не удалось обновить токен: $e');
                Sentry.captureException(e, stackTrace: StackTrace.current);

                retryCount++;
                await Future.delayed(Duration(seconds: 5));
                continue;
              }
            }

            if (response.statusCode == 200 || response.statusCode == 201) {
              successfullySent += batch.length;
              print('Успешно отправлен пакет данных (${batch.length} записей)');
              success = true;
            } else {
              print(
                  'Ошибка при отправке пакета данных: ${response.statusCode}, ${response.body}');
              retryCount++;
              await Future.delayed(Duration(seconds: 5));

              Sentry.captureMessage(
                'Ошибка при отправке пакета данных',
                withScope: (scope) {
                  scope.setContexts('Количество пакетов', '${batch.length}');
                },
              );
            }
          } catch (e) {
            print('Ошибка при отправке пакета данных: $e');
            retryCount++;
            await Future.delayed(Duration(seconds: 5));

            Sentry.captureException(e, stackTrace: StackTrace.current);
          }
        } while (!success && retryCount < maxRetries);
        if (!success) {
          print('Не удалось отправить пакет после $maxRetries попыток.');
          print('Запланирована повторная попытка отправки через 5 минут...');
          Timer(Duration(minutes: 5), () async {
            print('Повторная попытка отправки пакета данных...');
            try {
              var retryBatch = batch;
              var retryBody = {
                "userId": int.parse(userID),
                "coordinates": retryBatch.map((e) {
                  return {
                    "latitude": e['latitude'],
                    "longitude": e['longitude'],
                    "dateTime": e['timestamp'],
                  };
                }).toList(),
              };

              String retryToken = await system_token.getSystemToken();
              var response = await http.put(
                Uri.parse(
                    'https://must-games.back.must.io/api/tracker/gps-data'),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $retryToken',
                },
                body: jsonEncode(retryBody),
              );

              if (response.statusCode == 200 || response.statusCode == 201) {
                successfullySent += retryBatch.length;
                print(
                    'Успешно отправлен отложенный пакет (${retryBatch.length} записей)');
              } else {
                Sentry.captureMessage(
                  'Ошибки нет, но статус не 200/201',
                  withScope: (scope) {
                    scope.setContexts('Количество пакетов', '${batch.length}');
                  },
                );
              }
            } catch (e) {
              print('Ошибка при повторной отправке пакета: $e');

              Sentry.captureException(e, stackTrace: StackTrace.current);

              return;
            }
          });
          continue;
        }

        await Future.delayed(Duration(seconds: 2));

        return true;
      }

      print(successfullySent == totalRecords
          ? 'Все данные успешно отправлены на сервер'
          : 'Отправлено $successfullySent из $totalRecords записей');

      Sentry.captureMessage(
        'Все данные успешно отправлены на сервер',
      );

      return true;
    } catch (e) {
      log('$e');

      return false;
    }
  }
}
