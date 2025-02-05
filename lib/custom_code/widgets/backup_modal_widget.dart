import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_pro_drive/app_state.dart';
import 'package:tracker_pro_drive/custom_code/actions/prepare_app_environment.dart';
import 'package:tracker_pro_drive/custom_code/helpers/backup_helper.dart';
import 'package:tracker_pro_drive/custom_code/helpers/external_db_helper.dart';

class BackupModalWidget extends StatefulWidget {
  const BackupModalWidget({super.key});

  static Future<void> showModalSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(
        top: Radius.circular(16),
      )),
      isDismissible: false,
      builder: (context) => const BackupModalWidget(),
    );
  }

  @override
  State<BackupModalWidget> createState() => _BackupModalWidgetState();
}

class _BackupModalWidgetState extends State<BackupModalWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Loading
          if (isLoading)
            ListView(
              shrinkWrap: true,
              children: const [
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: FittedBox(
                    child: CircularProgressIndicator(),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),

          // Content
          if (!isLoading)
            ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Вы хотите сделать принудительное восстановление данных из локального хранилища?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Нет',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await prepareAppEnvironment(
                              FFAppState().userDataAPI.userID,
                              FFAppState().token);

                          setState(() {
                            isLoading = true;
                          });

                          final locationsJson = await ExtDB.readDataFromFile();

                          if (locationsJson == null) return;

                          List<Map<String, dynamic>> locations = [];

                          // Split the content into lines and deserialize each line
                          for (var line in locationsJson.split('/n')) {
                            if (line.isNotEmpty) {
                              // Assuming the data is stored in a JSON-like format per line.
                              final map =
                                  json.decode(line); // Deserialize JSON string
                              locations.add(
                                {
                                  "latitude": map['latitude'],
                                  "longitude": map['longitude'],
                                  "dateTime": map['timestamp'],
                                },
                              ); // Add to the list
                            }
                          }

                          // Получаем данные из SharedPreferences
                          final prefs = await SharedPreferences.getInstance();
                          String? userID = prefs.getString('userID');
                          String? userToken = prefs.getString('userToken');
                          String? packageName = prefs.getString('packageName');

                          if (userID == null ||
                              userToken == null ||
                              packageName == null) {
                            print(
                                'Не удалось получить userID, userToken или packageName');
                            return;
                          }

                          final success = await BackupHelper.backupLocations(
                            locations: locations,
                            userID: userID,
                          );

                          if (!context.mounted) return;

                          if (!success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Ошибка восстановления, пожалуйста, обратитесь в службу поддержки',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );

                            return;
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Восстановление успешно',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } catch (e) {
                          log('Error - $e');

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Ошибка восстановления, пожалуйста, обратитесь в службу поддержки',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        } finally {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Да',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
