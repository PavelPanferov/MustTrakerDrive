import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'splash_page_widget.dart' show SplashPageWidget;
import 'package:flutter/material.dart';

class SplashPageModel extends FlutterFlowModel<SplashPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (ProfileGET)] action in splashPage widget.
  ApiCallResponse? profileGetCheck;
  // Stores action output result for [Backend Call - API (NormalizedHumanData)] action in splashPage widget.
  ApiCallResponse? driverNumberApiResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
