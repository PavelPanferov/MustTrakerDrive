// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DayliTraksStruct extends BaseStruct {
  DayliTraksStruct({
    bool? isFraud,
    double? averageSpeed,
    double? distance,
    double? rewardTotal,
    int? rewardCorrection,
    String? startDate,
    String? endDate,
  })  : _isFraud = isFraud,
        _averageSpeed = averageSpeed,
        _distance = distance,
        _rewardTotal = rewardTotal,
        _rewardCorrection = rewardCorrection,
        _startDate = startDate,
        _endDate = endDate;

  // "isFraud" field.
  bool? _isFraud;
  bool get isFraud => _isFraud ?? false;
  set isFraud(bool? val) => _isFraud = val;

  bool hasIsFraud() => _isFraud != null;

  // "averageSpeed" field.
  double? _averageSpeed;
  double get averageSpeed => _averageSpeed ?? 0.0;
  set averageSpeed(double? val) => _averageSpeed = val;

  void incrementAverageSpeed(double amount) =>
      averageSpeed = averageSpeed + amount;

  bool hasAverageSpeed() => _averageSpeed != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  set distance(double? val) => _distance = val;

  void incrementDistance(double amount) => distance = distance + amount;

  bool hasDistance() => _distance != null;

  // "rewardTotal" field.
  double? _rewardTotal;
  double get rewardTotal => _rewardTotal ?? 0.0;
  set rewardTotal(double? val) => _rewardTotal = val;

  void incrementRewardTotal(double amount) =>
      rewardTotal = rewardTotal + amount;

  bool hasRewardTotal() => _rewardTotal != null;

  // "rewardCorrection" field.
  int? _rewardCorrection;
  int get rewardCorrection => _rewardCorrection ?? 0;
  set rewardCorrection(int? val) => _rewardCorrection = val;

  void incrementRewardCorrection(int amount) =>
      rewardCorrection = rewardCorrection + amount;

  bool hasRewardCorrection() => _rewardCorrection != null;

  // "startDate" field.
  String? _startDate;
  String get startDate => _startDate ?? '';
  set startDate(String? val) => _startDate = val;

  bool hasStartDate() => _startDate != null;

  // "endDate" field.
  String? _endDate;
  String get endDate => _endDate ?? '';
  set endDate(String? val) => _endDate = val;

  bool hasEndDate() => _endDate != null;

  static DayliTraksStruct fromMap(Map<String, dynamic> data) =>
      DayliTraksStruct(
        isFraud: data['isFraud'] as bool?,
        averageSpeed: castToType<double>(data['averageSpeed']),
        distance: castToType<double>(data['distance']),
        rewardTotal: castToType<double>(data['rewardTotal']),
        rewardCorrection: castToType<int>(data['rewardCorrection']),
        startDate: data['startDate'] as String?,
        endDate: data['endDate'] as String?,
      );

  static DayliTraksStruct? maybeFromMap(dynamic data) => data is Map
      ? DayliTraksStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'isFraud': _isFraud,
        'averageSpeed': _averageSpeed,
        'distance': _distance,
        'rewardTotal': _rewardTotal,
        'rewardCorrection': _rewardCorrection,
        'startDate': _startDate,
        'endDate': _endDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'isFraud': serializeParam(
          _isFraud,
          ParamType.bool,
        ),
        'averageSpeed': serializeParam(
          _averageSpeed,
          ParamType.double,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.double,
        ),
        'rewardTotal': serializeParam(
          _rewardTotal,
          ParamType.double,
        ),
        'rewardCorrection': serializeParam(
          _rewardCorrection,
          ParamType.int,
        ),
        'startDate': serializeParam(
          _startDate,
          ParamType.String,
        ),
        'endDate': serializeParam(
          _endDate,
          ParamType.String,
        ),
      }.withoutNulls;

  static DayliTraksStruct fromSerializableMap(Map<String, dynamic> data) =>
      DayliTraksStruct(
        isFraud: deserializeParam(
          data['isFraud'],
          ParamType.bool,
          false,
        ),
        averageSpeed: deserializeParam(
          data['averageSpeed'],
          ParamType.double,
          false,
        ),
        distance: deserializeParam(
          data['distance'],
          ParamType.double,
          false,
        ),
        rewardTotal: deserializeParam(
          data['rewardTotal'],
          ParamType.double,
          false,
        ),
        rewardCorrection: deserializeParam(
          data['rewardCorrection'],
          ParamType.int,
          false,
        ),
        startDate: deserializeParam(
          data['startDate'],
          ParamType.String,
          false,
        ),
        endDate: deserializeParam(
          data['endDate'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DayliTraksStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DayliTraksStruct &&
        isFraud == other.isFraud &&
        averageSpeed == other.averageSpeed &&
        distance == other.distance &&
        rewardTotal == other.rewardTotal &&
        rewardCorrection == other.rewardCorrection &&
        startDate == other.startDate &&
        endDate == other.endDate;
  }

  @override
  int get hashCode => const ListEquality().hash([
        isFraud,
        averageSpeed,
        distance,
        rewardTotal,
        rewardCorrection,
        startDate,
        endDate
      ]);
}

DayliTraksStruct createDayliTraksStruct({
  bool? isFraud,
  double? averageSpeed,
  double? distance,
  double? rewardTotal,
  int? rewardCorrection,
  String? startDate,
  String? endDate,
}) =>
    DayliTraksStruct(
      isFraud: isFraud,
      averageSpeed: averageSpeed,
      distance: distance,
      rewardTotal: rewardTotal,
      rewardCorrection: rewardCorrection,
      startDate: startDate,
      endDate: endDate,
    );
