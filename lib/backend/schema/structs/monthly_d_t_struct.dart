// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MonthlyDTStruct extends BaseStruct {
  MonthlyDTStruct({
    List<String>? monthAndYear,
    List<double>? distance,
    List<double>? averageSpeed,
    List<double>? reward,
  })  : _monthAndYear = monthAndYear,
        _distance = distance,
        _averageSpeed = averageSpeed,
        _reward = reward;

  // "monthAndYear" field.
  List<String>? _monthAndYear;
  List<String> get monthAndYear => _monthAndYear ?? const [];
  set monthAndYear(List<String>? val) => _monthAndYear = val;

  void updateMonthAndYear(Function(List<String>) updateFn) {
    updateFn(_monthAndYear ??= []);
  }

  bool hasMonthAndYear() => _monthAndYear != null;

  // "distance" field.
  List<double>? _distance;
  List<double> get distance => _distance ?? const [];
  set distance(List<double>? val) => _distance = val;

  void updateDistance(Function(List<double>) updateFn) {
    updateFn(_distance ??= []);
  }

  bool hasDistance() => _distance != null;

  // "averageSpeed" field.
  List<double>? _averageSpeed;
  List<double> get averageSpeed => _averageSpeed ?? const [];
  set averageSpeed(List<double>? val) => _averageSpeed = val;

  void updateAverageSpeed(Function(List<double>) updateFn) {
    updateFn(_averageSpeed ??= []);
  }

  bool hasAverageSpeed() => _averageSpeed != null;

  // "reward" field.
  List<double>? _reward;
  List<double> get reward => _reward ?? const [];
  set reward(List<double>? val) => _reward = val;

  void updateReward(Function(List<double>) updateFn) {
    updateFn(_reward ??= []);
  }

  bool hasReward() => _reward != null;

  static MonthlyDTStruct fromMap(Map<String, dynamic> data) => MonthlyDTStruct(
        monthAndYear: getDataList(data['monthAndYear']),
        distance: getDataList(data['distance']),
        averageSpeed: getDataList(data['averageSpeed']),
        reward: getDataList(data['reward']),
      );

  static MonthlyDTStruct? maybeFromMap(dynamic data) => data is Map
      ? MonthlyDTStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'monthAndYear': _monthAndYear,
        'distance': _distance,
        'averageSpeed': _averageSpeed,
        'reward': _reward,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'monthAndYear': serializeParam(
          _monthAndYear,
          ParamType.String,
          isList: true,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.double,
          isList: true,
        ),
        'averageSpeed': serializeParam(
          _averageSpeed,
          ParamType.double,
          isList: true,
        ),
        'reward': serializeParam(
          _reward,
          ParamType.double,
          isList: true,
        ),
      }.withoutNulls;

  static MonthlyDTStruct fromSerializableMap(Map<String, dynamic> data) =>
      MonthlyDTStruct(
        monthAndYear: deserializeParam<String>(
          data['monthAndYear'],
          ParamType.String,
          true,
        ),
        distance: deserializeParam<double>(
          data['distance'],
          ParamType.double,
          true,
        ),
        averageSpeed: deserializeParam<double>(
          data['averageSpeed'],
          ParamType.double,
          true,
        ),
        reward: deserializeParam<double>(
          data['reward'],
          ParamType.double,
          true,
        ),
      );

  @override
  String toString() => 'MonthlyDTStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MonthlyDTStruct &&
        listEquality.equals(monthAndYear, other.monthAndYear) &&
        listEquality.equals(distance, other.distance) &&
        listEquality.equals(averageSpeed, other.averageSpeed) &&
        listEquality.equals(reward, other.reward);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([monthAndYear, distance, averageSpeed, reward]);
}

MonthlyDTStruct createMonthlyDTStruct() => MonthlyDTStruct();
