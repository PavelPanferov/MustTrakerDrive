import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

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
