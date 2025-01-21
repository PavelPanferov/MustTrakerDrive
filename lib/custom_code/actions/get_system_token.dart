// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getSystemToken() async {
  // Add your function code here!

  int maxRetries = 3;
  int retryDelay = 5; // секунды между повторными попытками
  int currentRetry = 0;

  while (currentRetry < maxRetries) {
    try {
      // Принудительно получаем новый токен при каждом вызове
      print('Запрос нового SystemToken... Попытка ${currentRetry + 1}');

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
        String token = data['token'];

        // Сохраняем новый токен
        final prefs = await SharedPreferences.getInstance();
        int expiryTimestamp =
            DateTime.now().millisecondsSinceEpoch + 23 * 3600 * 1000; // 23 часа

        await prefs.setString('systemToken', token);
        await prefs.setInt('systemTokenExpiry', expiryTimestamp);

        print(
            'Новый SystemToken получен и сохранён. Действителен до: ${DateTime.fromMillisecondsSinceEpoch(expiryTimestamp)}');

        return token;
      } else {
        throw Exception(
            'Ошибка получения SystemToken. Код: ${response.statusCode}, Ответ: ${response.body}');
      }
    } catch (e) {
      print('Ошибка при получении SystemToken: $e');
      currentRetry++;

      if (currentRetry < maxRetries) {
        print('Повторная попытка через $retryDelay секунд...');
        await Future.delayed(Duration(seconds: retryDelay));
      } else {
        rethrow;
      }
    }
  }

  throw Exception('Не удалось получить SystemToken после $maxRetries попыток');
}
