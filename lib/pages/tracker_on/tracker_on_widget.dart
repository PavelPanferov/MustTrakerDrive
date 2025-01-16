import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tracker_on_model.dart';
export 'tracker_on_model.dart';

class TrackerOnWidget extends StatefulWidget {
  const TrackerOnWidget({super.key});

  @override
  State<TrackerOnWidget> createState() => _TrackerOnWidgetState();
}

class _TrackerOnWidgetState extends State<TrackerOnWidget> {
  late TrackerOnModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrackerOnModel());
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
            color: FlutterFlowTheme.of(context).success,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'В турнире',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      color: FlutterFlowTheme.of(context).success,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily),
                    ),
              ),
              Container(
                width: 52.0,
                height: 52.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).success,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).success,
                    width: 1.0,
                  ),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Icon(
                    FFIcons.kcup2,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    size: 46.0,
                  ),
                ),
              ),
            ]
                .divide(const SizedBox(width: 24.0))
                .addToStart(const SizedBox(width: 24.0))
                .addToEnd(const SizedBox(width: 4.0)),
          ),
        ),
      ),
    );
  }
}
