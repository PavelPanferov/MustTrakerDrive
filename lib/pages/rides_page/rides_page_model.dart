import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/navbar/navbar_widget.dart';
import 'rides_page_widget.dart' show RidesPageWidget;
import 'package:flutter/material.dart';

class RidesPageModel extends FlutterFlowModel<RidesPageWidget> {
  ///  Local state fields for this page.

  int limit = 2;

  ///  State fields for stateful widgets in this page.

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
