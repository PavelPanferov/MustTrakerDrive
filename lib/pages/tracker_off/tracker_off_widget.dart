import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tracker_off_model.dart';
export 'tracker_off_model.dart';

class TrackerOffWidget extends StatefulWidget {
  const TrackerOffWidget({super.key});

  @override
  State<TrackerOffWidget> createState() => _TrackerOffWidgetState();
}

class _TrackerOffWidgetState extends State<TrackerOffWidget> {
  late TrackerOffModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrackerOffModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999.0),
      ),
      child: Container(
        width: 200.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(999.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).error,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52.0,
                height: 52.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).error,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).error,
                    width: 1.0,
                  ),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Icon(
                    FFIcons.kstopnew,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    size: 46.0,
                  ),
                ),
              ),
              Text(
                'Выключен',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).error,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily),
                    ),
              ),
            ].divide(const SizedBox(width: 24.0)).addToStart(const SizedBox(width: 4.0)),
          ),
        ),
      ),
    );
  }
}
