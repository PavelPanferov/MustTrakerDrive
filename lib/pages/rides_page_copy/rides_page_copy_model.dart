import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/navbar/navbar_widget.dart';
import 'rides_page_copy_widget.dart' show RidesPageCopyWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class RidesPageCopyModel extends FlutterFlowModel<RidesPageCopyWidget> {
  ///  Local state fields for this page.

  int limit = 2;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    expandableExpandableController.dispose();
    navbarModel.dispose();
  }
}
