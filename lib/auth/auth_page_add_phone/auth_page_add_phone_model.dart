import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/appbar/appbar_widget.dart';
import 'auth_page_add_phone_widget.dart' show AuthPageAddPhoneWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthPageAddPhoneModel extends FlutterFlowModel<AuthPageAddPhoneWidget> {
  ///  Local state fields for this page.

  bool privacy = false;

  bool terms = false;

  bool error = false;

  ///  State fields for stateful widgets in this page.

  // Model for appbar component.
  late AppbarModel appbarModel;
  // State field(s) for belPhone widget.
  FocusNode? belPhoneFocusNode;
  TextEditingController? belPhoneTextController;
  final belPhoneMask = MaskTextInputFormatter(mask: '+375(##)###-##-##');
  String? Function(BuildContext, String?)? belPhoneTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController2;
  final textFieldMask = MaskTextInputFormatter(mask: '+7(###)###-##-##');
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Backend Call - API (AuthOTP)] action in nextButton widget.
  ApiCallResponse? code;

  @override
  void initState(BuildContext context) {
    appbarModel = createModel(context, () => AppbarModel());
  }

  @override
  void dispose() {
    appbarModel.dispose();
    belPhoneFocusNode?.dispose();
    belPhoneTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController2?.dispose();
  }
}
