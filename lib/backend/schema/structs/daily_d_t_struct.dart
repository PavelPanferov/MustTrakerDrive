// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DailyDTStruct extends BaseStruct {
  DailyDTStruct({
    String? day,
    double? reward,
    double? distance,
    double? averageSpeed,
  })  : _day = day,
        _reward = reward,
        _distance = distance,
        _averageSpeed = averageSpeed;

  // "day" field.
  String? _day;
  String get day => _day ?? '';
  set day(String? val) => _day = val;

  bool hasDay() => _day != null;

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

  static DailyDTStruct fromMap(Map<String, dynamic> data) => DailyDTStruct(
        day: data['day'] as String?,
        reward: castToType<double>(data['reward']),
        distance: castToType<double>(data['distance']),
        averageSpeed: castToType<double>(data['averageSpeed']),
      );

  static DailyDTStruct? maybeFromMap(dynamic data) =>
      data is Map ? DailyDTStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'day': _day,
        'reward': _reward,
        'distance': _distance,
        'averageSpeed': _averageSpeed,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'day': serializeParam(
          _day,
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

  static DailyDTStruct fromSerializableMap(Map<String, dynamic> data) =>
      DailyDTStruct(
        day: deserializeParam(
          data['day'],
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
  String toString() => 'DailyDTStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DailyDTStruct &&
        day == other.day &&
        reward == other.reward &&
        distance == other.distance &&
        averageSpeed == other.averageSpeed;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([day, reward, distance, averageSpeed]);
}

DailyDTStruct createDailyDTStruct({
  String? day,
  double? reward,
  double? distance,
  double? averageSpeed,
}) =>
    DailyDTStruct(
      day: day,
      reward: reward,
      distance: distance,
      averageSpeed: averageSpeed,
    );
