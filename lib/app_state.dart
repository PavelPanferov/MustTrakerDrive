import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _list = prefs.getStringList('ff_list')?.map(int.parse).toList() ?? _list;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_JSONLocationUser')) {
        try {
          _JSONLocationUser =
              jsonDecode(prefs.getString('ff_JSONLocationUser') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _tracker = prefs.getBool('ff_tracker') ?? _tracker;
    });
    _safeInit(() {
      _token = prefs.getString('ff_token') ?? _token;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_userDataAPI')) {
        try {
          final serializedData = prefs.getString('ff_userDataAPI') ?? '{}';
          _userDataAPI = UserInformationStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_completeDriverDT')) {
        try {
          final serializedData = prefs.getString('ff_completeDriverDT') ?? '{}';
          _completeDriverDT = DriverCompleteDTStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _startingStatusBool =
          prefs.getBool('ff_startingStatusBool') ?? _startingStatusBool;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<int> _list = [0, 1, 2, 3, 4, 5];
  List<int> get list => _list;
  set list(List<int> value) {
    _list = value;
    prefs.setStringList('ff_list', value.map((x) => x.toString()).toList());
  }

  void addToList(int value) {
    list.add(value);
    prefs.setStringList('ff_list', _list.map((x) => x.toString()).toList());
  }

  void removeFromList(int value) {
    list.remove(value);
    prefs.setStringList('ff_list', _list.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromList(int index) {
    list.removeAt(index);
    prefs.setStringList('ff_list', _list.map((x) => x.toString()).toList());
  }

  void updateListAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    list[index] = updateFn(_list[index]);
    prefs.setStringList('ff_list', _list.map((x) => x.toString()).toList());
  }

  void insertAtIndexInList(int index, int value) {
    list.insert(index, value);
    prefs.setStringList('ff_list', _list.map((x) => x.toString()).toList());
  }

  dynamic _JSONLocationUser;
  dynamic get JSONLocationUser => _JSONLocationUser;
  set JSONLocationUser(dynamic value) {
    _JSONLocationUser = value;
    prefs.setString('ff_JSONLocationUser', jsonEncode(value));
  }

  int _OtpState = 0;
  int get OtpState => _OtpState;
  set OtpState(int value) {
    _OtpState = value;
  }

  bool _tracker = false;
  bool get tracker => _tracker;
  set tracker(bool value) {
    _tracker = value;
    prefs.setBool('ff_tracker', value);
  }

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
    prefs.setString('ff_token', value);
  }

  UserInformationStruct _userDataAPI = UserInformationStruct();
  UserInformationStruct get userDataAPI => _userDataAPI;
  set userDataAPI(UserInformationStruct value) {
    _userDataAPI = value;
    prefs.setString('ff_userDataAPI', value.serialize());
  }

  void updateUserDataAPIStruct(Function(UserInformationStruct) updateFn) {
    updateFn(_userDataAPI);
    prefs.setString('ff_userDataAPI', _userDataAPI.serialize());
  }

  String _country = 'ru';
  String get country => _country;
  set country(String value) {
    _country = value;
  }

  DriverCompleteDTStruct _completeDriverDT = DriverCompleteDTStruct();
  DriverCompleteDTStruct get completeDriverDT => _completeDriverDT;
  set completeDriverDT(DriverCompleteDTStruct value) {
    _completeDriverDT = value;
    prefs.setString('ff_completeDriverDT', value.serialize());
  }

  void updateCompleteDriverDTStruct(Function(DriverCompleteDTStruct) updateFn) {
    updateFn(_completeDriverDT);
    prefs.setString('ff_completeDriverDT', _completeDriverDT.serialize());
  }

  bool _startingStatusBool = false;
  bool get startingStatusBool => _startingStatusBool;
  set startingStatusBool(bool value) {
    _startingStatusBool = value;
    prefs.setBool('ff_startingStatusBool', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
