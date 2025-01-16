import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'sms_code_page_widget.dart' show SmsCodePageWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SmsCodePageModel extends FlutterFlowModel<SmsCodePageWidget> {
  ///  Local state fields for this page.

  bool timer = false;

  bool checking = false;

  bool error = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for code widget.
  FocusNode? codeFocusNode;
  TextEditingController? codeTextController;
  final codeMask = MaskTextInputFormatter(mask: '####');
  String? Function(BuildContext, String?)? codeTextControllerValidator;
  String? _codeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Неверый формат кода';
    }

    if (val.length < 4) {
      return 'Неверый формат кода';
    }
    if (val.length > 4) {
      return 'Неверый формат кода';
    }

    return null;
  }

  // Stores action output result for [Validate Form] action in code widget.
  bool? valid;
  // Stores action output result for [Backend Call - API (Login JWT)] action in code widget.
  ApiCallResponse? loginJWTRespons;
  // Stores action output result for [Backend Call - API (Login JWT)] action in code widget.
  ApiCallResponse? loginJWTResponsChange;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 30000;
  int timerMilliseconds = 30000;
  String timerValue = StopWatchTimer.getDisplayTime(
    30000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Backend Call - API (AuthOTP)] action in Button widget.
  ApiCallResponse? authResendCode;

  @override
  void initState(BuildContext context) {
    codeTextControllerValidator = _codeTextControllerValidator;
  }

  @override
  void dispose() {
    codeFocusNode?.dispose();
    codeTextController?.dispose();

    timerController.dispose();
  }
}
