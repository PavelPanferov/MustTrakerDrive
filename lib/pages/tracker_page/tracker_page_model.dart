import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/appbar/appbar_widget.dart';
import '/pages/components/navbar/navbar_widget.dart';
import 'tracker_page_widget.dart' show TrackerPageWidget;
import 'package:flutter/material.dart';

class TrackerPageModel extends FlutterFlowModel<TrackerPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for appbar component.
  late AppbarModel appbarModel;
  // Stores action output result for [Custom Action - prepareAppEnvironment] action in CustomSlider widget.
  bool? prepareOutPut;
  // Stores action output result for [Custom Action - startBackgroundServiceCopy] action in CustomSlider widget.
  dynamic startBGService;
  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    appbarModel = createModel(context, () => AppbarModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    appbarModel.dispose();
    navbarModel.dispose();
  }
}
