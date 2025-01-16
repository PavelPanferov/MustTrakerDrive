import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/navbar/navbar_widget.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (driver complete)] action in ProfilePage widget.
  ApiCallResponse? driverCompleteResultApiProfile;
  // Stores action output result for [Custom Action - prepareAppEnvironment] action in CustomSlider widget.
  bool? outPut2;
  // Stores action output result for [Custom Action - startBackgroundServiceCopy] action in CustomSlider widget.
  dynamic startBGService;
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
