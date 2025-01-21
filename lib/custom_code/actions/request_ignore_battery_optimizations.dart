// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future requestIgnoreBatteryOptimizations() async {
  if (Platform.isAndroid) {
    try {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      // Получаем имя пакета
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String packageName = packageInfo.packageName;

      if (sdkInt >= 23) {
        // Android 6.0+ (включая Android 8)
        try {
          // Сначала проверяем, не включено ли уже игнорирование
          final isIgnoringBatteryOptimizations = await AndroidIntent(
            action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
            data: 'package:$packageName',
          ).canResolveActivity();

          if (isIgnoringBatteryOptimizations != true) {
            // Изменено здесь
            // Для Android 8 используем более мягкий подход
            if (sdkInt <= 27) {
              // Android 8.1 и ниже
              final intent = AndroidIntent(
                action: 'android.settings.BATTERY_SAVER_SETTINGS',
              );
              await intent.launch();
              print('Открыты настройки энергосбережения');
            } else {
              // Для более новых версий используем прямой запрос
              final intent = AndroidIntent(
                action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
                data: 'package:$packageName',
              );
              await intent.launch();
              print('Запрос на игнорирование оптимизации батареи отправлен');
            }
          } else {
            print('Оптимизация батареи уже отключена для приложения');
          }
        } catch (e) {
          print('Ошибка при запросе оптимизации батареи: $e');
          // Пробуем открыть общие настройки батареи как запасной вариант
          try {
            final fallbackIntent = AndroidIntent(
              action: 'android.settings.BATTERY_SAVER_SETTINGS',
            );
            await fallbackIntent.launch();
            print('Открыты общие настройки батареи');
          } catch (e) {
            print('Не удалось открыть настройки батареи: $e');
          }
        }
      }
    } catch (e) {
      print('Общая ошибка в requestIgnoreBatteryOptimizations: $e');
    }
  }
}
