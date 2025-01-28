// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Дополнительные импорты
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:android_intent_plus/android_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/custom_code/actions/get_system_token.dart' as system_token;

Future<dynamic> startBackgroundServiceCopy(
  String userToken,
  String userID,
) async {
  // Инициализируем сервис фоновой работы
  final service = FlutterBackgroundService();

  // Проверяем, запущен ли сервис уже
  bool isRunning = await service.isRunning();
  if (isRunning) {
    print('Сервис уже запущен.');
    return;
  }

  // Конфигурируем фоновый сервис
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'Сервис запущен',
      initialNotificationContent: 'Сбор местоположения активен',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  // Запускаем сервис
  await service.startService();
  print('Foreground Service started.');
}

/// Точка входа фонового сервиса
@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  // Таймеры
  Timer? locationTimer;
  Timer? dataSendTimer;

  // Настраиваем Foreground уведомление (Android)
  if (Platform.isAndroid) {
    AndroidServiceInstance androidService = service as AndroidServiceInstance;
    await service.setAsForegroundService();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'my_foreground',
      'Мой Фоновый Сервис',
      channelDescription: 'Этот канал используется для важных уведомлений.',
      importance: Importance.low,
      priority: Priority.low,
      icon: '@mipmap/pro_driver_ic',
      ongoing: false,
    );

    await flutterLocalNotificationsPlugin.show(
      888,
      'Сервис активен',
      'Сбор местоположения выполняется',
      const NotificationDetails(android: androidPlatformChannelSpecifics),
    );
  }

  // Получаем данные из SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  String? userID = prefs.getString('userID');
  String? userToken = prefs.getString('userToken');
  String? packageName = prefs.getString('packageName');

  if (userID == null || userToken == null || packageName == null) {
    print('Не удалось получить userID, userToken или packageName');
    service.stopSelf();
    return;
  }

  // ---- ВМЕСТО потока geolocator.getPositionStream ----
  // Запускаем таймер каждые 10 секунд, чтобы вызывать recordLocation()
  locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
    try {
      await recordLocation();
    } catch (e) {
      print('Ошибка в Timer.periodic(recordLocation): $e');
    }
  });

  // Настройки для получения локации
  final locationSettings = geolocator.LocationSettings(
    accuracy: geolocator.LocationAccuracy.high,
  );

  // Таймер для отправки данных на сервер - каждые 30 минут
  dataSendTimer = Timer.periodic(const Duration(seconds: 30), (timer) async {
    try {
      await sendDataToServer(userID);
    } catch (e) {
      print('Ошибка в таймере sendDataToServer: $e');
    }
  });

  // Слушаем команду stopService
  service.on('stopService').listen((event) async {
    print('Получена команда остановки сервиса. Отправка данных...');
    await sendDataToServer(userID);
    print('Данные отправлены. Остановка сервиса...');

    // Отменяем таймеры
    locationTimer?.cancel();
    dataSendTimer?.cancel();

    service.stopSelf();
  });
}

Future<bool> onIosBackground(ServiceInstance service) async {
  return true;
}

Future<void> recordLocation() async {
  try {
    // Проверяем разрешения на геолокацию
    geolocator.LocationPermission permission =
        await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied ||
        permission == geolocator.LocationPermission.deniedForever) {
      print('Нет разрешений на доступ к местоположению');
      await showNotification(
        'Геолокация отключена',
        'Сбор местоположения приостановлен из-за отключенных разрешений.',
        () async {
          if (Platform.isAndroid) {
            final packageName = await getPackageName();
            final AndroidIntent intent = AndroidIntent(
              action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
              data: 'package:$packageName',
            );
            await intent.launch();
          }
          return;
        },
      );
      return;
    }

    // Проверяем, включены ли службы геолокации
    bool isLocationServiceEnabled =
        await geolocator.Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      print('Службы местоположения отключены');
      await showNotification(
        'Геолокация отключена',
        'Сбор местоположения приостановлен из-за отключенных служб геолокации.',
        () async {
          if (Platform.isAndroid) {
            final AndroidIntent intent = AndroidIntent(
              action: 'android.settings.LOCATION_SOURCE_SETTINGS',
            );
            await intent.launch();
          }
          return;
        },
      );
      return;
    }

    // Получаем текущее местоположение
    geolocator.Position position =
        await geolocator.Geolocator.getCurrentPosition(
            desiredAccuracy: geolocator.LocationAccuracy.high);

    // ЗАМЕНИТЬ НА:
    DateTime nowUtc = DateTime.now().toUtc();

    Map<String, dynamic> locationData = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': nowUtc.toIso8601String(),
      'date': DateFormat('yyyy-MM-dd').format(nowUtc),
    };

    // Сохраняем данные в локальную базу данных SQLite
    int id = await DatabaseHelper.instance.insert(locationData);
    print('Местоположение сохранено в БД с id $id: $locationData');
  } catch (e) {
    print('Ошибка в функции recordLocation: $e');
    await showNotification(
      'Ошибка',
      'Не удалось записать местоположение. Повторная попытка...',
      null,
    );
  }
}

Future<void> sendDataToServer(String userID) async {
  try {
    // Получаем все накопленные данные местоположения из базы данных
    List<Map<String, dynamic>> allLocationData =
        await DatabaseHelper.instance.queryAllRows();

    if (allLocationData.isEmpty) {
      print('Нет данных для отправки');
      return;
    }

    // Проверяем наличие интернет-соединения
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print('Нет подключения к интернету. Данные будут отправлены позже.');
      return;
    }

    // Получаем SystemToken
    String systemToken;
    try {
      systemToken = await system_token.getSystemToken();
    } catch (e) {
      print('Не удалось получить SystemToken: $e');
      return;
    }

    int batchSize = 1000; // Максимальный размер пакета данных
    int successfullySent = 0;
    int totalRecords = allLocationData.length;

    // Проверяем минимальный порог записей
    if (totalRecords < 10) {
      print(
          'Недостаточно записей для отправки ($totalRecords < 10). Ожидаем накопления данных.');
      return;
    }

    print('Отправка $totalRecords записей');

    // Разбиваем данные на пакеты и отправляем
    for (var i = 0; i < totalRecords; i += batchSize) {
      var end = (i + batchSize < totalRecords) ? i + batchSize : totalRecords;
      var batch = allLocationData.sublist(i, end);

      List<int> idsToDelete = batch.map((e) => e['id'] as int).toList();

      var coordinates = batch.map((e) {
        var dt = DateTime.parse(e['timestamp']).toUtc();
        return {
          "latitude": e['latitude'],
          "longitude": e['longitude'],
          "dateTime": dt.toIso8601String(),
        };
      }).toList();

      var requestBody = {
        "userId": int.parse(userID),
        "coordinates": coordinates,
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
              retryCount++;
              await Future.delayed(Duration(seconds: 5));
              continue;
            }
          }

          if (response.statusCode == 200 || response.statusCode == 201) {
            successfullySent += batch.length;
            print('Успешно отправлен пакет данных (${batch.length} записей)');
            success = true;
            await DatabaseHelper.instance.deleteRows(idsToDelete);
            print('Удалены записи с id: $idsToDelete');
          } else {
            print(
                'Ошибка при отправке пакета данных: ${response.statusCode}, ${response.body}');
            retryCount++;
            await Future.delayed(Duration(seconds: 5));
          }
        } catch (e) {
          print('Ошибка при отправке пакета данных: $e');
          retryCount++;
          await Future.delayed(Duration(seconds: 5));
        }
      } while (!success && retryCount < maxRetries);
      if (!success) {
        print('Не удалось отправить пакет после $maxRetries попыток.');
        print('Запланирована повторная попытка отправки через 5 минут...');
        Timer(Duration(minutes: 5), () async {
          print('Повторная попытка отправки пакета данных...');
          try {
            var retryBatch = batch;
            var retryIds = idsToDelete;
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
              Uri.parse('https://must-games.back.must.io/api/tracker/gps-data'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $retryToken',
              },
              body: jsonEncode(retryBody),
            );

            if (response.statusCode == 200 || response.statusCode == 201) {
              successfullySent += retryBatch.length;
              await DatabaseHelper.instance.deleteRows(retryIds);
              print(
                  'Успешно отправлен отложенный пакет (${retryBatch.length} записей)');
            }
          } catch (e) {
            print('Ошибка при повторной отправке пакета: $e');
          }
        });
        continue;
      }

      await Future.delayed(Duration(seconds: 2));
    }

    print(successfullySent == totalRecords
        ? 'Все данные успешно отправлены на сервер'
        : 'Отправлено $successfullySent из $totalRecords записей');
  } catch (e) {
    print('Общая ошибка в функции sendDataToServer: $e');
    await showNotification(
        'Ошибка отправки данных',
        'Не удалось отправить данные на сервер. Повторная попытка позже.',
        null);
  }
}

class DatabaseHelper {
  static final _databaseName = "location_data.db";
  static final _databaseVersion = 1;

  static final table = 'locations';

  static final columnId = 'id';
  static final columnLatitude = 'latitude';
  static final columnLongitude = 'longitude';
  static final columnTimestamp = 'timestamp';
  static final columnDate = 'date';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // Получаем экземпляр базы данных
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Инициализируем базу данных
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Создаём таблицу при первом запуске
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnLatitude REAL NOT NULL,
        $columnLongitude REAL NOT NULL,
        $columnTimestamp TEXT NOT NULL,
        $columnDate TEXT NOT NULL
      )
    ''');
  }

  // Вставляем новую запись в базу данных
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Получаем все записи из базы данных
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Удаляем записи по списку идентификаторов
  Future<int> deleteRows(List<int> ids) async {
    Database db = await instance.database;
    String idsString = ids.join(',');
    return await db.delete(table, where: '$columnId IN ($idsString)');
  }

  // Удаляем все записи из базы данных
  Future<int> deleteAllRows() async {
    Database db = await instance.database;
    return await db.delete(table);
  }
}
