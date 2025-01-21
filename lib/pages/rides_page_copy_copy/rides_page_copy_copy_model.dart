import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/navbar/navbar_widget.dart';
import 'rides_page_copy_copy_widget.dart' show RidesPageCopyCopyWidget;
import 'package:flutter/material.dart';

class RidesPageCopyCopyModel extends FlutterFlowModel<RidesPageCopyCopyWidget> {
  ///  Local state fields for this page.

  double? totalDistance = 0.0;

  double totalAverageSpeed = 0.0;

  double? totalReward = 0.0;

  List<MonthlyDTStruct> monthDataType = [];
  void addToMonthDataType(MonthlyDTStruct item) => monthDataType.add(item);
  void removeFromMonthDataType(MonthlyDTStruct item) =>
      monthDataType.remove(item);
  void removeAtIndexFromMonthDataType(int index) =>
      monthDataType.removeAt(index);
  void insertAtIndexInMonthDataType(int index, MonthlyDTStruct item) =>
      monthDataType.insert(index, item);
  void updateMonthDataTypeAtIndex(
          int index, Function(MonthlyDTStruct) updateFn) =>
      monthDataType[index] = updateFn(monthDataType[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (traksAllMonth)] action in RidesPageCopyCopy widget.
  ApiCallResponse? apiResultAllDataMonth;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    navbarModel.dispose();
  }
}
