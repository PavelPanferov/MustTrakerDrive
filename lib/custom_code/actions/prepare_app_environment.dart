// Automatic FlutterFlow imports
import 'package:tracker_pro_drive/custom_code/helpers/external_db_helper.dart';

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
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '/custom_code/actions/get_system_token.dart' as system_token;

Future<bool> prepareAppEnvironment(
  String userID,
  String userToken,
) async {
  try {
    print('Начало подготовки окружения...');

    // Проверяем версию Android
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;
      print('Android SDK версия: $sdkInt');
    }

    // Шаг 1: Проверяем включен ли сервис геолокации
    bool serviceEnabled =
        await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await showNotification(
        'Геолокация отключена',
        'Пожалуйста, включите геолокацию в настройках устройства',
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
      return false;
    }

    // Шаг 2: Запрашиваем базовые разрешения через permission_handler
    PermissionStatus locationWhenInUse =
        await Permission.locationWhenInUse.request();
    if (!locationWhenInUse.isGranted) {
      await showNotification(
        'Требуется доступ к геолокации',
        'Для работы приложения необходим доступ к местоположению устройства',
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
      return false;
    }

    // Шаг 3: Запрашиваем фоновую геолокацию
    PermissionStatus locationAlways = await Permission.locationAlways.request();
    if (!locationAlways.isGranted) {
      await showNotification(
        'Требуется фоновая геолокация',
        'Для корректной работы необходим доступ к местоположению в фоновом режиме',
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
      return false;
    }

    // Шаг 4: Дополнительная проверка через Geolocator
    geolocator.LocationPermission geoPermission =
        await geolocator.Geolocator.checkPermission();
    if (geoPermission == geolocator.LocationPermission.denied) {
      geoPermission = await geolocator.Geolocator.requestPermission();
      if (geoPermission == geolocator.LocationPermission.denied) {
        await showNotification(
          'Доступ запрещен',
          'Разрешение на геолокацию необходимо для работы приложения',
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
        return false;
      }
    }

    if (geoPermission == geolocator.LocationPermission.deniedForever) {
      await showNotification(
        'Геолокация отключена',
        'Разрешение на геолокацию отклонено навсегда. Пожалуйста, включите его в настройках.',
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
      return false;
    }

    // Шаг 5: Запрашиваем разрешение на уведомления для Android 13+
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt >= 33) {
        PermissionStatus notificationStatus =
            await Permission.notification.request();
        if (!notificationStatus.isGranted) {
          await showNotification(
            'Требуются уведомления',
            'Пожалуйста, разрешите отправку уведомлений для работы сервиса',
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
          return false;
        }
      }
    }

    // Шаг 6: Запрашиваем игнорирование оптимизации батареи
    await requestIgnoreBatteryOptimizations();

    // Получаем packageName
    String packageName = await getPackageName();

    // Обновляем системный токен
    try {
      await system_token.getSystemToken();
    } catch (e) {
      print('Ошибка при обновлении системного токена: $e');
      await showNotification(
        'Ошибка авторизации',
        'Не удалось обновить системный токен. Повторите попытку позже.',
        null,
      );
      return false;
    }

    // Сохраняем userID, userToken и packageName в SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userID);
    await prefs.setString('userToken', userToken);
    await prefs.setString('packageName', packageName);

    // Инициализируем уведомления
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/pro_driver_ic'),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload == 'open_settings') {
          if (Platform.isAndroid) {
            final AndroidIntent intent = AndroidIntent(
              action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
              data: 'package:$packageName',
            );
            await intent.launch();
          } else if (Platform.isIOS) {
            await geolocator.Geolocator.openAppSettings();
          }
        }
      },
    );

    // Создаём канал уведомлений для Android
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'my_foreground',
        'Мой Фоновый Сервис',
        description: 'Этот канал используется для важных уведомлений.',
        importance: Importance.none,
        enableLights: false,
        enableVibration: false,
        playSound: false,
        showBadge: true,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    print('Окружение подготовлено успешно.');
    return true;
  } catch (e) {
    print('Ошибка при подготовке окружения: $e');
    await showNotification(
      'Ошибка настройки',
      'Не удалось подготовить окружение приложения',
      null,
    );
    return false;
  }
}
