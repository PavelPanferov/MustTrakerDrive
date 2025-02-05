import 'dart:developer';

import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:sentry_flutter/sentry_flutter.dart';

typedef ExtDB = ExternalDatabaseHelper;

class ExternalDatabaseHelper {
  static const _fileName = 'ProDriveGoLocations.txt';

  static Future<void> requestPermissions() async {
    try {
      await Permission.manageExternalStorage.request();

      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    } catch (e) {
      Sentry.captureException(e);
    }
  }

  static Future<String?> readDataFromFile() async {
    try {
      await ExtDB.requestPermissions();

      String experimentalPath =
          await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOCUMENTS);

      File file = File('$experimentalPath/.ProDriveGo/$_fileName');

      if (await file.exists()) {
        // Читаем данные из файла
        String data = await file.readAsString();

        log('Data: $data');

        return data;
      }

      return null;
    } catch (e) {
      Sentry.captureException(e);

      return null;
    }
  }

  static Future<void> saveDataToFile({required String data}) async {
    try {
      await ExtDB.requestPermissions();

      String experimentalPath =
          await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOCUMENTS);

      File file = File('$experimentalPath/.ProDriveGo/$_fileName');

      // Дописываем данные в файл
      await file.writeAsString('$data /n', mode: FileMode.append);
    } catch (e) {
      Sentry.captureException(e);
    }
  }
}
