// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

Future checkAndStartService() async {
  // Add your function code here!
  final service = FlutterBackgroundService();
  bool running = await service.isRunning();
  if (!running) {
    // Читаем userID, userToken из SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userID');
    String? userToken = prefs.getString('userToken');

    if (userID != null && userToken != null) {
      await startBackgroundServiceCopy(userToken, userID);
    }
  }
}
