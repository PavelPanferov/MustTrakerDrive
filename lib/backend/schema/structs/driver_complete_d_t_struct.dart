// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DriverCompleteDTStruct extends BaseStruct {
  DriverCompleteDTStruct({
    bool? onBoarding,
    bool? registration,
    bool? noBot,
    bool? experience,
    bool? dreamJob,
    bool? employmentStatus,
    bool? myVehicle,
    bool? myFleet,
  })  : _onBoarding = onBoarding,
        _registration = registration,
        _noBot = noBot,
        _experience = experience,
        _dreamJob = dreamJob,
        _employmentStatus = employmentStatus,
        _myVehicle = myVehicle,
        _myFleet = myFleet;

  // "onBoarding" field.
  bool? _onBoarding;
  bool get onBoarding => _onBoarding ?? false;
  set onBoarding(bool? val) => _onBoarding = val;

  bool hasOnBoarding() => _onBoarding != null;

  // "registration" field.
  bool? _registration;
  bool get registration => _registration ?? false;
  set registration(bool? val) => _registration = val;

  bool hasRegistration() => _registration != null;

  // "noBot" field.
  bool? _noBot;
  bool get noBot => _noBot ?? false;
  set noBot(bool? val) => _noBot = val;

  bool hasNoBot() => _noBot != null;

  // "experience" field.
  bool? _experience;
  bool get experience => _experience ?? false;
  set experience(bool? val) => _experience = val;

  bool hasExperience() => _experience != null;

  // "dreamJob" field.
  bool? _dreamJob;
  bool get dreamJob => _dreamJob ?? false;
  set dreamJob(bool? val) => _dreamJob = val;

  bool hasDreamJob() => _dreamJob != null;

  // "employmentStatus" field.
  bool? _employmentStatus;
  bool get employmentStatus => _employmentStatus ?? false;
  set employmentStatus(bool? val) => _employmentStatus = val;

  bool hasEmploymentStatus() => _employmentStatus != null;

  // "myVehicle" field.
  bool? _myVehicle;
  bool get myVehicle => _myVehicle ?? false;
  set myVehicle(bool? val) => _myVehicle = val;

  bool hasMyVehicle() => _myVehicle != null;

  // "myFleet" field.
  bool? _myFleet;
  bool get myFleet => _myFleet ?? false;
  set myFleet(bool? val) => _myFleet = val;

  bool hasMyFleet() => _myFleet != null;

  static DriverCompleteDTStruct fromMap(Map<String, dynamic> data) =>
      DriverCompleteDTStruct(
        onBoarding: data['onBoarding'] as bool?,
        registration: data['registration'] as bool?,
        noBot: data['noBot'] as bool?,
        experience: data['experience'] as bool?,
        dreamJob: data['dreamJob'] as bool?,
        employmentStatus: data['employmentStatus'] as bool?,
        myVehicle: data['myVehicle'] as bool?,
        myFleet: data['myFleet'] as bool?,
      );

  static DriverCompleteDTStruct? maybeFromMap(dynamic data) => data is Map
      ? DriverCompleteDTStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'onBoarding': _onBoarding,
        'registration': _registration,
        'noBot': _noBot,
        'experience': _experience,
        'dreamJob': _dreamJob,
        'employmentStatus': _employmentStatus,
        'myVehicle': _myVehicle,
        'myFleet': _myFleet,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'onBoarding': serializeParam(
          _onBoarding,
          ParamType.bool,
        ),
        'registration': serializeParam(
          _registration,
          ParamType.bool,
        ),
        'noBot': serializeParam(
          _noBot,
          ParamType.bool,
        ),
        'experience': serializeParam(
          _experience,
          ParamType.bool,
        ),
        'dreamJob': serializeParam(
          _dreamJob,
          ParamType.bool,
        ),
        'employmentStatus': serializeParam(
          _employmentStatus,
          ParamType.bool,
        ),
        'myVehicle': serializeParam(
          _myVehicle,
          ParamType.bool,
        ),
        'myFleet': serializeParam(
          _myFleet,
          ParamType.bool,
        ),
      }.withoutNulls;

  static DriverCompleteDTStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      DriverCompleteDTStruct(
        onBoarding: deserializeParam(
          data['onBoarding'],
          ParamType.bool,
          false,
        ),
        registration: deserializeParam(
          data['registration'],
          ParamType.bool,
          false,
        ),
        noBot: deserializeParam(
          data['noBot'],
          ParamType.bool,
          false,
        ),
        experience: deserializeParam(
          data['experience'],
          ParamType.bool,
          false,
        ),
        dreamJob: deserializeParam(
          data['dreamJob'],
          ParamType.bool,
          false,
        ),
        employmentStatus: deserializeParam(
          data['employmentStatus'],
          ParamType.bool,
          false,
        ),
        myVehicle: deserializeParam(
          data['myVehicle'],
          ParamType.bool,
          false,
        ),
        myFleet: deserializeParam(
          data['myFleet'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'DriverCompleteDTStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DriverCompleteDTStruct &&
        onBoarding == other.onBoarding &&
        registration == other.registration &&
        noBot == other.noBot &&
        experience == other.experience &&
        dreamJob == other.dreamJob &&
        employmentStatus == other.employmentStatus &&
        myVehicle == other.myVehicle &&
        myFleet == other.myFleet;
  }

  @override
  int get hashCode => const ListEquality().hash([
        onBoarding,
        registration,
        noBot,
        experience,
        dreamJob,
        employmentStatus,
        myVehicle,
        myFleet
      ]);
}

DriverCompleteDTStruct createDriverCompleteDTStruct({
  bool? onBoarding,
  bool? registration,
  bool? noBot,
  bool? experience,
  bool? dreamJob,
  bool? employmentStatus,
  bool? myVehicle,
  bool? myFleet,
}) =>
    DriverCompleteDTStruct(
      onBoarding: onBoarding,
      registration: registration,
      noBot: noBot,
      experience: experience,
      dreamJob: dreamJob,
      employmentStatus: employmentStatus,
      myVehicle: myVehicle,
      myFleet: myFleet,
    );
