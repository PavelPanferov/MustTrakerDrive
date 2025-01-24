import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/appbar/appbar_widget.dart';
import '/pages/components/navbar/navbar_widget.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tracker_page_model.dart';
export 'tracker_page_model.dart';

class TrackerPageWidget extends StatefulWidget {
  const TrackerPageWidget({super.key});

  @override
  State<TrackerPageWidget> createState() => _TrackerPageWidgetState();
}

class _TrackerPageWidgetState extends State<TrackerPageWidget> {
  late TrackerPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrackerPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            wrapWithModel(
              model: _model.appbarModel,
              updateCallback: () => safeSetState(() {}),
              child: const AppbarWidget(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AutoSizeText(
                      '— Включи трекер, чтобы все твои поездки учитывались в Турнире',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                            lineHeight: 1.25,
                          ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondary,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  'Работай! Играй! Побеждай!',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                        lineHeight: 1.3,
                                      ),
                                ),
                                AutoSizeText(
                                  'За каждую поездку с включенным трекером тебе и твоей команде будут начисляться золотые монеты КМТ.\n👇 Включи трекер',
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                        lineHeight: 1.5,
                                      ),
                                ),
                                Stack(
                                  alignment: const AlignmentDirectional(0.0, 1.0),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 0.0),
                                      child: SizedBox(
                                        width: 200.0,
                                        height: 60.0,
                                        child: custom_widgets.CustomSlider(
                                          width: 200.0,
                                          height: 60.0,
                                          tracker: FFAppState().tracker,
                                          iconON: Icon(
                                            FFIcons.kcup2,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 46.0,
                                          ),
                                          iconOFF: Icon(
                                            FFIcons.kstopnew,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 44.0,
                                          ),
                                          colorON: FlutterFlowTheme.of(context)
                                              .success,
                                          colorOFF: FlutterFlowTheme.of(context)
                                              .error,
                                          textON: 'В турнире',
                                          textOFF: 'Выключен',
                                          fontSize: 18.0,
                                          fontWeight: 700.0,
                                          textPadding: 22.0,
                                          iconPaddingRight: 8.0,
                                          iconPaddingLeft: 4.0,
                                          onChanged: () async {
                                            if (FFAppState().tracker) {
                                              FFAppState().tracker = false;
                                              FFAppState().update(() {});
                                              unawaited(
                                                () async {
                                                  await actions
                                                      .stopBackgroundService();
                                                }(),
                                              );
                                            } else {
                                              await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500));
                                              _model.prepareOutPut =
                                                  await actions
                                                      .prepareAppEnvironment(
                                                FFAppState().userDataAPI.userID,
                                                FFAppState().token,
                                              );
                                              await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 1000));
                                              if (_model.prepareOutPut!) {
                                                FFAppState().tracker = true;
                                                FFAppState().update(() {});
                                                unawaited(
                                                  () async {
                                                    _model.startBGService =
                                                        await actions
                                                            .startBackgroundServiceCopy(
                                                      FFAppState().token,
                                                      FFAppState()
                                                          .userDataAPI
                                                          .userID,
                                                    );
                                                  }(),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Необходимо предоставить разрешения для работы приложения!',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ].divide(const SizedBox(height: 8.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                      .divide(const SizedBox(height: 16.0))
                      .addToStart(const SizedBox(height: 12.0))
                      .addToEnd(const SizedBox(height: 16.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
              child: FFButtonWidget(
                onPressed: !FFAppState().tracker
                    ? null
                    : () async {
                        HapticFeedback.selectionClick();
                        await launchURL('https://clck.ru/3Dfzwn');
                      },
                text: 'Перейти в Турнир',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 52.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: valueOrDefault<Color>(
                    FFAppState().tracker
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).primaryBackground,
                    FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleSmallFamily,
                        color: valueOrDefault<Color>(
                          FFAppState().tracker
                              ? FlutterFlowTheme.of(context).info
                              : FlutterFlowTheme.of(context).primaryText,
                          FlutterFlowTheme.of(context).primaryText,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).titleSmallFamily),
                        lineHeight: 1.25,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: valueOrDefault<Color>(
                      FFAppState().tracker
                          ? FlutterFlowTheme.of(context).primary
                          : FlutterFlowTheme.of(context).borderColor,
                      FlutterFlowTheme.of(context).borderColor,
                    ),
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            wrapWithModel(
              model: _model.navbarModel,
              updateCallback: () => safeSetState(() {}),
              child: const NavbarWidget(
                pageNumber: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
