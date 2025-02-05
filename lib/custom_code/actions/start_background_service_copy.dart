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

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  // Храним таймер для возможности отмены
  Timer? notificationUpdateTimer;
  StreamSubscription<geolocator.Position>? _positionStream;
  Timer? dataSendTimer;

  if (Platform.isAndroid) {
    AndroidServiceInstance androidService = service as AndroidServiceInstance;
    await service.setAsForegroundService();

    // Устанавливаем уведомление с иконкой
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'my_foreground',
      'Мой Фоновый Сервис',
      channelDescription: 'Этот канал используется для важных уведомлений.',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      ongoing: true,
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

  // Проверяем, что данные получены
  if (userID == null || userToken == null || packageName == null) {
    print('Не удалось получить userID, userToken или packageName');
    service.stopSelf();
    return;
  }

  // Подписываемся на изменения статуса службы геолокации
  geolocator.Geolocator.getServiceStatusStream()
      .listen((geolocator.ServiceStatus status) async {
    if (status == geolocator.ServiceStatus.disabled) {
      print('Службы геолокации отключены');
    } else if (status == geolocator.ServiceStatus.enabled) {
      print('Службы геолокации включены');
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: 'Сервис активен',
          content: 'Сбор местоположения выполняется',
        );
      }
    }
  });

  // Настройки для получения локации
  final locationSettings = geolocator.LocationSettings(
    accuracy: geolocator.LocationAccuracy.high,
  );

  // Запускаем поток геолокации
  _positionStream = geolocator.Geolocator.getPositionStream(
    locationSettings: locationSettings,
  ).listen(
    (geolocator.Position position) async {
      try {
        // Проверяем доступность геолокации
        bool isLocationServiceEnabled =
            await geolocator.Geolocator.isLocationServiceEnabled();

        if (!isLocationServiceEnabled) {
          print('GPS отключен');
          return;
        }

        // Сохраняем в БД
        DateTime now = DateTime.now();
        String date = DateFormat('yyyy-MM-dd').format(now);

        Map<String, dynamic> locationData = {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'timestamp': now.toIso8601String(),
          'date': date,
        };

        await DatabaseHelper.instance.insert(locationData);
        print(
            'Координаты получены: ${position.latitude}, ${position.longitude}');
      } catch (e) {
        print('Ошибка при получении локации: $e');
      }
    },
    onError: (error) {
      print('Ошибка в потоке локаций: $error');
    },
  );

  // Таймер для отправки данных на сервер - каждые 30 минут
  dataSendTimer = Timer.periodic(const Duration(minutes: 30), (timer) async {
    try {
      await sendDataToServer(userID);
    } catch (e) {
      print('Ошибка в таймере sendDataToServer: $e');
    }
  });

  // Слушаем команды для остановки сервиса
  service.on('stopService').listen((event) async {
    print('Получена команда остановки сервиса. Отправка данных...');
    await sendDataToServer(userID);
    print('Данные отправлены. Остановка сервиса...');

    // Отменяем подписки
    await _positionStream?.cancel();
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

    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);

    // Формируем данные для сохранения
    Map<String, dynamic> locationData = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': now.toIso8601String(),
      'date': date,
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

Future<String> getSystemToken() async {
  int maxRetries = 3;
  int retryCount = 0;

  while (retryCount < maxRetries) {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('systemToken');
      int? expiryTime = prefs.getInt('systemTokenExpiry');

      int now = DateTime.now().millisecondsSinceEpoch;

      if (token == null || expiryTime == null || now >= expiryTime) {
        print('Получение нового SystemToken... Попытка ${retryCount + 1}');
        var response = await http.post(
          Uri.parse('https://api.must.io/api/systems/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "systemName": "ProDriveTrackerApp",
            "password": "jS`2@dc~Nn3~Y3e",
            "daysTimeout": 1
          }),
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          token = data['token'];
          int expiryTimestamp = now + 23 * 3600 * 1000;
          await prefs.setString('systemToken', token!);
          await prefs.setInt('systemTokenExpiry', expiryTimestamp);
          print(
              'Новый SystemToken получен, истекает в ${DateTime.fromMillisecondsSinceEpoch(expiryTimestamp)}');
        } else {
          throw Exception(
              'Не удалось получить SystemToken. Код ответа: ${response.statusCode}');
        }
      } else {
        print('Используется существующий SystemToken');
      }

      return token!;
    } catch (e) {
      print('Ошибка при получении SystemToken: $e');
      retryCount++;
      if (retryCount < maxRetries) {
        await Future.delayed(Duration(seconds: 5));
        continue;
      }
      rethrow;
    }
  }

  throw Exception('Не удалось получить SystemToken после $maxRetries попыток');
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
      systemToken = await getSystemToken();
    } catch (e) {
      print('Не удалось получить SystemToken: $e');
      return;
    }

    int batchSize = 1000; // Максимальный размер пакета данных
    int successfullySent = 0;
    int totalRecords = allLocationData.length;

    // Проверяем минимальный порог записей
    if (totalRecords < 50) {
      print(
          'Недостаточно записей для отправки ($totalRecords < 50). Ожидаем накопления данных.');
      return;
    }

    print('Отправка $totalRecords записей');

    // Разбиваем данные на пакеты и отправляем
    for (var i = 0; i < totalRecords; i += batchSize) {
      var end = (i + batchSize < totalRecords) ? i + batchSize : totalRecords;
      var batch = allLocationData.sublist(i, end);

      List<int> idsToDelete = batch.map((e) => e['id'] as int).toList();

      var coordinates = batch.map((e) {
        return {
          "latitude": e['latitude'],
          "longitude": e['longitude'],
          "dateTime": e['timestamp'],
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

            String retryToken = await getSystemToken();
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
