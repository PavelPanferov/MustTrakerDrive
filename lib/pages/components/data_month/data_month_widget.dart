import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_month_model.dart';
export 'data_month_model.dart';

class DataMonthWidget extends StatefulWidget {
  const DataMonthWidget({
    super.key,
    required this.day,
    required this.json,
  });

  final DateTime? day;
  final List<dynamic>? json;

  @override
  State<DataMonthWidget> createState() => _DataMonthWidgetState();
}

class _DataMonthWidgetState extends State<DataMonthWidget> {
  late DataMonthModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataMonthModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).accent1,
              shape: BoxShape.circle,
            ),
            child: Icon(
              FFIcons.kcheckcircle,
              color: FlutterFlowTheme.of(context).success,
              size: 24.0,
            ),
          ),
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).accent2,
              shape: BoxShape.circle,
            ),
            child: Icon(
              FFIcons.kstopCircull,
              color: FlutterFlowTheme.of(context).error,
              size: 24.0,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: valueOrDefault<String>(
                                  formatNumber(
                                    functions.calculateTotalDistanceForDay(
                                        widget.json?.toList(), widget.day!),
                                    formatType: FormatType.custom,
                                    format: '0.0 км',
                                    locale: '',
                                  ),
                                  '0.0 км',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                      lineHeight: 1.4,
                                    ),
                              ),
                              TextSpan(
                                text: ' • ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                      lineHeight: 1.4,
                                    ),
                              ),
                              TextSpan(
                                text: valueOrDefault<String>(
                                  formatNumber(
                                    functions.calculateAverageSpeedForDay(
                                        widget.json?.toList(), widget.day!),
                                    formatType: FormatType.custom,
                                    format: '0.00 км/ч',
                                    locale: '',
                                  ),
                                  '0.00 км/ч',
                                ),
                                style: const TextStyle(),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '+41',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: FlutterFlowTheme.of(context).success,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                        Container(
                          width: 16.0,
                          height: 16.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/coin_1.png',
                              ).image,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ].divide(const SizedBox(width: 4.0)),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Старт',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                            lineHeight: 1.25,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        '${dateTimeFormat(
                          "dd.MM.yyyy",
                          functions.getFirstDateForDay(
                              widget.json?.toList(), widget.day!),
                          locale: FFLocalizations.of(context).languageCode,
                        )} • ${dateTimeFormat(
                          "HH:mm",
                          functions.getFirstDateForDay(
                              widget.json?.toList(), widget.day!),
                          locale: FFLocalizations.of(context).languageCode,
                        )}',
                        '01.01.2024 • 00:00',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                            lineHeight: 1.25,
                          ),
                    ),
                  ].divide(const SizedBox(width: 12.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Финиш',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                            lineHeight: 1.25,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        '${dateTimeFormat(
                          "dd.MM.yyyy",
                          functions.getLastDateForDay(
                              widget.json?.toList(), widget.day!),
                          locale: FFLocalizations.of(context).languageCode,
                        )} • ${dateTimeFormat(
                          "HH:mm",
                          functions.getLastDateForDay(
                              widget.json?.toList(), widget.day!),
                          locale: FFLocalizations.of(context).languageCode,
                        )}',
                        '01.01.2024 • 00:00',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                            lineHeight: 1.25,
                          ),
                    ),
                  ].divide(const SizedBox(width: 12.0)),
                ),
              ],
            ),
          ),
        ].divide(const SizedBox(width: 12.0)),
      ),
    );
  }
}
