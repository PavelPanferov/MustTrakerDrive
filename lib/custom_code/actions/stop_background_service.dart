// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:io';

Future stopBackgroundService() async {
  final service = FlutterBackgroundService();
  final notifications = FlutterLocalNotificationsPlugin();

  try {
    // Проверяем, запущен ли сервис
    bool isRunning = await service.isRunning();
    if (!isRunning) {
      print('Сервис не запущен');
      return true;
    }

    print('Начинаем остановку сервиса...');

    // Отменяем уведомления
    if (Platform.isAndroid) {
      await notifications.cancel(888);
      print('Уведомления отменены');
    }

    // Отправляем команду остановки сервиса
    service.invoke('stopService');
    print('Команда остановки сервиса отправлена');

    // Даем время на корректное завершение работы
    await Future.delayed(const Duration(seconds: 2));

    // Проверяем статус первый раз
    isRunning = await service.isRunning();
    if (isRunning) {
      print('Сервис не остановился, пробуем принудительно');

      // Вторая попытка
      service.invoke('stopService');
      await Future.delayed(const Duration(seconds: 2));

      // Финальная проверка
      isRunning = await service.isRunning();
      if (isRunning) {
        print('Не удалось остановить сервис после всех попыток');
        return false;
      }
    }

    print('Сервис успешно остановлен');
    return true;
  } catch (e) {
    print('Ошибка при остановке сервиса: $e');
    // Пытаемся все равно отменить уведомления
    try {
      if (Platform.isAndroid) {
        await notifications.cancel(888);
      }
    } catch (notificationError) {
      print('Ошибка при отмене уведомлений: $notificationError');
    }
    return false;
  }
}
