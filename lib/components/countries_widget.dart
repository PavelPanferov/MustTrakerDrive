import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'countries_model.dart';
export 'countries_model.dart';

class CountriesWidget extends StatefulWidget {
  const CountriesWidget({super.key});

  @override
  State<CountriesWidget> createState() => _CountriesWidgetState();
}

class _CountriesWidgetState extends State<CountriesWidget> {
  late CountriesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CountriesModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 120.0, 16.0, 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).borderColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().country = 'ru';
                  FFAppState().update(() {});
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 20.0,
                      height: 20.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/images.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Россия (+7)',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                    if (FFAppState().country == 'ru')
                      FaIcon(
                        FontAwesomeIcons.check,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 14.0,
                      ),
                  ].divide(const SizedBox(width: 8.0)),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().country = 'bel';
                  FFAppState().update(() {});
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 20.0,
                      height: 20.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/Flag_of_Belarus.svg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Беларусь (+375)',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                    if (FFAppState().country == 'bel')
                      FaIcon(
                        FontAwesomeIcons.check,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 14.0,
                      ),
                  ].divide(const SizedBox(width: 8.0)),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().country = 'kz';
                  FFAppState().update(() {});
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 20.0,
                      height: 20.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/Flag_of_Kazakhstan.svg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Казахстан (+7)',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                    if (FFAppState().country == 'kz')
                      FaIcon(
                        FontAwesomeIcons.check,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 14.0,
                      ),
                  ].divide(const SizedBox(width: 8.0)),
                ),
              ),
            ].divide(const SizedBox(height: 12.0)),
          ),
        ),
      ),
    );
  }
}
