// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:io';

Future<bool> showNotification(
  String title,
  String? body,
  Future Function()? action,
) async {
  try {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Инициализация с правильной иконкой
    if (!Platform.isAndroid) return false;

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'my_foreground', // id
      'Мой Фоновый Сервис', // name
      channelDescription: 'Этот канал используется для важных уведомлений.',
      importance: Importance.low,
      priority: Priority.low,
      icon: '@mipmap/pro_driver_ic',
      playSound: false,
      enableVibration: false,
      ongoing: true,
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Показываем уведомление
    await flutterLocalNotificationsPlugin.show(
      888,
      title,
      body ?? '',
      platformChannelSpecifics,
      payload: action != null ? 'action_required' : null,
    );

    // Выполняем действие если оно предоставлено
    if (action != null) {
      await action();
    }

    return true;
  } catch (e) {
    print('Ошибка при отправке уведомления: $e');
    return false;
  }
}
