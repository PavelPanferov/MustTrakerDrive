// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MonthlyDTStruct extends BaseStruct {
  MonthlyDTStruct({
    String? monthAndYear,
    double? reward,
    double? distance,
    double? averageSpeed,
  })  : _monthAndYear = monthAndYear,
        _reward = reward,
        _distance = distance,
        _averageSpeed = averageSpeed;

  // "monthAndYear" field.
  String? _monthAndYear;
  String get monthAndYear => _monthAndYear ?? '';
  set monthAndYear(String? val) => _monthAndYear = val;

  bool hasMonthAndYear() => _monthAndYear != null;

  // "reward" field.
  double? _reward;
  double get reward => _reward ?? 0.0;
  set reward(double? val) => _reward = val;

  void incrementReward(double amount) => reward = reward + amount;

  bool hasReward() => _reward != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  set distance(double? val) => _distance = val;

  void incrementDistance(double amount) => distance = distance + amount;

  bool hasDistance() => _distance != null;

  // "averageSpeed" field.
  double? _averageSpeed;
  double get averageSpeed => _averageSpeed ?? 0.0;
  set averageSpeed(double? val) => _averageSpeed = val;

  void incrementAverageSpeed(double amount) =>
      averageSpeed = averageSpeed + amount;

  bool hasAverageSpeed() => _averageSpeed != null;

  static MonthlyDTStruct fromMap(Map<String, dynamic> data) => MonthlyDTStruct(
        monthAndYear: data['monthAndYear'] as String?,
        reward: castToType<double>(data['reward']),
        distance: castToType<double>(data['distance']),
        averageSpeed: castToType<double>(data['averageSpeed']),
      );

  static MonthlyDTStruct? maybeFromMap(dynamic data) => data is Map
      ? MonthlyDTStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'monthAndYear': _monthAndYear,
        'reward': _reward,
        'distance': _distance,
        'averageSpeed': _averageSpeed,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'monthAndYear': serializeParam(
          _monthAndYear,
          ParamType.String,
        ),
        'reward': serializeParam(
          _reward,
          ParamType.double,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.double,
        ),
        'averageSpeed': serializeParam(
          _averageSpeed,
          ParamType.double,
        ),
      }.withoutNulls;

  static MonthlyDTStruct fromSerializableMap(Map<String, dynamic> data) =>
      MonthlyDTStruct(
        monthAndYear: deserializeParam(
          data['monthAndYear'],
          ParamType.String,
          false,
        ),
        reward: deserializeParam(
          data['reward'],
          ParamType.double,
          false,
        ),
        distance: deserializeParam(
          data['distance'],
          ParamType.double,
          false,
        ),
        averageSpeed: deserializeParam(
          data['averageSpeed'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'MonthlyDTStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MonthlyDTStruct &&
        monthAndYear == other.monthAndYear &&
        reward == other.reward &&
        distance == other.distance &&
        averageSpeed == other.averageSpeed;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([monthAndYear, reward, distance, averageSpeed]);
}

MonthlyDTStruct createMonthlyDTStruct({
  String? monthAndYear,
  double? reward,
  double? distance,
  double? averageSpeed,
}) =>
    MonthlyDTStruct(
      monthAndYear: monthAndYear,
      reward: reward,
      distance: distance,
      averageSpeed: averageSpeed,
    );
