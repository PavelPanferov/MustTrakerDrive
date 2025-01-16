import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/data_month/data_month_widget.dart';
import '/pages/components/empty/empty_widget.dart';
import '/pages/components/navbar/navbar_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rides_page_model.dart';
export 'rides_page_model.dart';

class RidesPageWidget extends StatefulWidget {
  const RidesPageWidget({super.key});

  @override
  State<RidesPageWidget> createState() => _RidesPageWidgetState();
}

class _RidesPageWidgetState extends State<RidesPageWidget> {
  late RidesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RidesPageModel());
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
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 100.0,
                      buttonSize: 54.0,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: Icon(
                        FFIcons.kleftnew,
                        color: FlutterFlowTheme.of(context).info,
                        size: 14.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    child: Text(
                      valueOrDefault<String>(
                        formatNumber(
                          functions.calculateTotalDistance(
                              FFAppState().JSONLocationUser),
                          formatType: FormatType.custom,
                          format: '0 км',
                          locale: '',
                        ),
                        '0 км',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 34.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                            lineHeight: 1.3,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    child: Container(
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8.0, 6.0, 12.0, 6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FFIcons.kspeednew,
                              color: FlutterFlowTheme.of(context).info,
                              size: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  formatNumber(
                                    functions.calculateAverageSpeed(
                                        FFAppState().JSONLocationUser),
                                    formatType: FormatType.custom,
                                    format: '0.00 км/ч',
                                    locale: '',
                                  ),
                                  '0.00 км/ч',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context).info,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                      lineHeight: 1.25,
                                    ),
                              ),
                            ),
                          ].divide(const SizedBox(width: 8.0)),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Общий результат',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                          lineHeight: 1.25,
                        ),
                  ),
                ]
                    .addToStart(const SizedBox(height: 50.0))
                    .addToEnd(const SizedBox(height: 44.0)),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 0.8,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0),
                          ),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    final month = functions
                                            .listMonth(
                                                FFAppState().JSONLocationUser,
                                                _model.limit)
                                            ?.toList() ??
                                        [];
                                    if (month.isEmpty) {
                                      return const EmptyWidget();
                                    }

                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(month.length,
                                                (monthIndex) {
                                          final monthItem = month[monthIndex];
                                          return Container(
                                            decoration: const BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            999.0),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  6.0,
                                                                  0.0,
                                                                  6.0),
                                                      child: RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  dateTimeFormat(
                                                                "MMMM yyyy",
                                                                monthItem,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    lineHeight:
                                                                        1.4,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text: ' • ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    lineHeight:
                                                                        1.4,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                formatNumber(
                                                                  functions.differenceBetween2month(
                                                                      FFAppState()
                                                                          .JSONLocationUser,
                                                                      monthItem),
                                                                  formatType:
                                                                      FormatType
                                                                          .custom,
                                                                  format:
                                                                      '+# кмт',
                                                                  locale: '',
                                                                ),
                                                                '+ 0 кмт',
                                                              ),
                                                              style:
                                                                  const TextStyle(),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    final listDays = functions
                                                            .listDaysInMonth(
                                                                FFAppState()
                                                                    .JSONLocationUser,
                                                                monthItem)
                                                            ?.toList() ??
                                                        [];
                                                    if (listDays.isEmpty) {
                                                      return const EmptyWidget();
                                                    }

                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: List.generate(
                                                          listDays.length,
                                                          (listDaysIndex) {
                                                        final listDaysItem =
                                                            listDays[
                                                                listDaysIndex];
                                                        return DataMonthWidget(
                                                          key: Key(
                                                              'Keya1f_${listDaysIndex}_of_${listDays.length}'),
                                                          day: listDaysItem,
                                                          json: FFAppState()
                                                              .JSONLocationUser,
                                                        );
                                                      }).divide(const SizedBox(
                                                          height: 16.0)),
                                                    );
                                                  },
                                                ),
                                              ].divide(const SizedBox(height: 12.0)),
                                            ),
                                          );
                                        })
                                            .divide(const SizedBox(height: 24.0))
                                            .addToEnd(const SizedBox(height: 36.0)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  _model.limit = _model.limit + 2;
                                  safeSetState(() {});
                                },
                                text: 'Показать предыдущие',
                                icon: Icon(
                                  FFIcons.karrowCircle,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 52.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                        lineHeight: 1.25,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ]
                                .addToStart(const SizedBox(height: 20.0))
                                .addToEnd(const SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            wrapWithModel(
              model: _model.navbarModel,
              updateCallback: () => safeSetState(() {}),
              child: const NavbarWidget(
                pageNumber: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
