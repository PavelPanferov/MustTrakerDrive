import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/empty/empty_widget.dart';
import '/pages/components/navbar/navbar_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:styled_divider/styled_divider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rides_page_copy_model.dart';
export 'rides_page_copy_model.dart';

class RidesPageCopyWidget extends StatefulWidget {
  const RidesPageCopyWidget({super.key});

  @override
  State<RidesPageCopyWidget> createState() => _RidesPageCopyWidgetState();
}

class _RidesPageCopyWidgetState extends State<RidesPageCopyWidget>
    with TickerProviderStateMixin {
  late RidesPageCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RidesPageCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultAllDataMonth =
          await MustGamesAPIGroup.traksAllMonthCall.call(
        userToken: FFAppState().token,
        offset: _model.offset,
        limit: _model.limit,
      );

      if ((_model.apiResultAllDataMonth?.succeeded ?? true)) {
        _model.totalDistance =
            MustGamesAPIGroup.traksAllMonthCall.totalDistance(
          (_model.apiResultAllDataMonth?.jsonBody ?? ''),
        );
        _model.totalAverageSpeed =
            MustGamesAPIGroup.traksAllMonthCall.totalAverageSpeed(
          (_model.apiResultAllDataMonth?.jsonBody ?? ''),
        )!;
        _model.totalReward = MustGamesAPIGroup.traksAllMonthCall.totalReward(
          (_model.apiResultAllDataMonth?.jsonBody ?? ''),
        );
        _model.monthDataType = functions
            .convertMonthlyJSON(MustGamesAPIGroup.traksAllMonthCall.monthlyJSON(
              (_model.apiResultAllDataMonth?.jsonBody ?? ''),
            ))
            .toList()
            .cast<MonthlyDTStruct>();
        safeSetState(() {});
      }
      await Future.delayed(const Duration(milliseconds: 1000));

      FFAppState().update(() {});
    });

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 2000.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 100.0,
                      buttonSize: 32.0,
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
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 8.0, 0.0),
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/Gold_Coin_from_Tracker_App.png',
                                ).image,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            formatNumber(
                              _model.totalReward,
                              formatType: FormatType.custom,
                              format: '####.##',
                              locale: '',
                            ),
                            '0',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: FlutterFlowTheme.of(context).info,
                                fontSize: 40.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 28.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 8.0, 0.0, 6.0),
                              child: Container(
                                width: 14.0,
                                height: 16.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: Image.asset(
                                      'assets/images/Tracker_App_Union.png',
                                    ).image,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                              child: Text(
                                '${valueOrDefault<String>(
                                  formatNumber(
                                    _model.totalDistance,
                                    formatType: FormatType.custom,
                                    format: '####.##',
                                    locale: '',
                                  ),
                                  '0',
                                )} км',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                      lineHeight: 1.25,
                                    ),
                              ),
                            ),
                          ].divide(const SizedBox(width: 6.0)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                        child: Container(
                          height: 28.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8.0, 6.0, 10.0, 6.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 16.0,
                                  height: 16.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: Image.asset(
                                        'assets/images/Union_from_Tracker_App.png',
                                      ).image,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    '${valueOrDefault<String>(
                                      formatNumber(
                                        _model.totalAverageSpeed,
                                        formatType: FormatType.custom,
                                        format: '####.##',
                                        locale: '',
                                      ),
                                      '0',
                                    )} км/ч',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLargeFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLargeFamily),
                                          lineHeight: 1.25,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 34.0),
                    child: Text(
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
                  ),
                ].addToStart(const SizedBox(height: 50.0)),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final month = _model.monthDataType.toList();
                                    if (month.isEmpty) {
                                      return Center(
                                        child: SizedBox(
                                          height: valueOrDefault<double>(
                                            () {
                                              if (MediaQuery.sizeOf(context)
                                                      .width <
                                                  kBreakpointSmall) {
                                                return 300.0;
                                              } else if (MediaQuery.sizeOf(
                                                          context)
                                                      .width <
                                                  kBreakpointMedium) {
                                                return 400.0;
                                              } else if (MediaQuery.sizeOf(
                                                          context)
                                                      .width <
                                                  kBreakpointLarge) {
                                                return 500.0;
                                              } else {
                                                return 350.0;
                                              }
                                            }(),
                                            350.0,
                                          ),
                                          child: const EmptyWidget(),
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: month.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 8.0),
                                      itemBuilder: (context, monthIndex) {
                                        final monthItem = month[monthIndex];
                                        return ListView(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                functions.monthAndYearConvert(
                                                                    monthItem
                                                                        .monthAndYear),
                                                                'Месяц',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyLargeFamily,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyLargeFamily),
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      0.0,
                                                                      12.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                '${valueOrDefault<String>(
                                                                  formatNumber(
                                                                    monthItem
                                                                        .distance,
                                                                    formatType:
                                                                        FormatType
                                                                            .custom,
                                                                    format:
                                                                        '####.##',
                                                                    locale: '',
                                                                  ),
                                                                  '0',
                                                                )} км',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    ),
                                                              ),
                                                              Text(
                                                                ' • ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
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
                                                                    ),
                                                              ),
                                                              Text(
                                                                '${valueOrDefault<String>(
                                                                  formatNumber(
                                                                    monthItem
                                                                        .averageSpeed,
                                                                    formatType:
                                                                        FormatType
                                                                            .custom,
                                                                    format:
                                                                        '####.##',
                                                                    locale: '',
                                                                  ),
                                                                  '0',
                                                                )} км/ч',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                2.0, 0.0),
                                                    child: Text(
                                                      '+${valueOrDefault<String>(
                                                        formatNumber(
                                                          monthItem.reward,
                                                          formatType:
                                                              FormatType.custom,
                                                          format: '####.##',
                                                          locale: '',
                                                        ),
                                                        '0',
                                                      )}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Container(
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                            FutureBuilder<ApiCallResponse>(
                                              future: MustGamesAPIGroup
                                                  .traksByMonthDataCall
                                                  .call(
                                                userToken: FFAppState().token,
                                                isoMonth:
                                                    monthItem.monthAndYear,
                                                offset: 0,
                                                limit: 31,
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 30.0,
                                                      height: 30.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final containerTraksByMonthDataResponse =
                                                    snapshot.data!;

                                                return Container(
                                                  decoration: const BoxDecoration(),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final daily = functions
                                                          .convertDailyJSON(
                                                              MustGamesAPIGroup
                                                                  .traksByMonthDataCall
                                                                  .daily(
                                                            containerTraksByMonthDataResponse
                                                                .jsonBody,
                                                          ))
                                                          .toList();
                                                      if (daily.isEmpty) {
                                                        return const EmptyWidget();
                                                      }

                                                      return ListView.separated(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount: daily.length,
                                                        separatorBuilder:
                                                            (_, __) => const SizedBox(
                                                                height: 8.0),
                                                        itemBuilder: (context,
                                                            dailyIndex) {
                                                          final dailyItem =
                                                              daily[dailyIndex];
                                                          return FutureBuilder<
                                                              ApiCallResponse>(
                                                            future:
                                                                MustGamesAPIGroup
                                                                    .traksByDayCall
                                                                    .call(
                                                              userToken:
                                                                  FFAppState()
                                                                      .token,
                                                              isoDate:
                                                                  dailyItem.day,
                                                              offset: 0,
                                                              limit: 50,
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 30.0,
                                                                    height:
                                                                        30.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              final containerTraksByDayResponse =
                                                                  snapshot
                                                                      .data!;

                                                              return Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          12.0,
                                                                          12.0,
                                                                          12.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    child:
                                                                        ExpandableNotifier(
                                                                      initialExpanded:
                                                                          false,
                                                                      child:
                                                                          ExpandablePanel(
                                                                        header:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              valueOrDefault<String>(
                                                                                functions.convertDateFormat(dailyItem.day),
                                                                                'error',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                                    color: Colors.black,
                                                                                    fontSize: 16.0,
                                                                                    letterSpacing: 0.0,
                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleLargeFamily),
                                                                                  ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  if (random_data.randomDouble(0.0, 0.0) > functions.dayJSONrewardCorrection(containerTraksByDayResponse.jsonBody)!)
                                                                                    Text(
                                                                                      '+${functions.dayJSONrewardCorrection(containerTraksByDayResponse.jsonBody).toString()}',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                            color: FlutterFlowTheme.of(context).tertiary,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w500,
                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                          ),
                                                                                    ),
                                                                                  if (random_data.randomDouble(0.0, 0.0) > functions.dayJSONrewardCorrection(containerTraksByDayResponse.jsonBody)!)
                                                                                    Container(
                                                                                      width: 16.0,
                                                                                      height: 16.0,
                                                                                      decoration: BoxDecoration(
                                                                                        image: DecorationImage(
                                                                                          fit: BoxFit.cover,
                                                                                          image: Image.asset(
                                                                                            'assets/images/Tracker_App_Warning_Icon.png',
                                                                                          ).image,
                                                                                        ),
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                    ),
                                                                                  if (monthItem.reward > 0.0)
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        '+${formatNumber(
                                                                                          dailyItem.reward,
                                                                                          formatType: FormatType.custom,
                                                                                          format: '####.##',
                                                                                          locale: '',
                                                                                        )}',
                                                                                        'error',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                            color: FlutterFlowTheme.of(context).success,
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w500,
                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                          ),
                                                                                    ),
                                                                                  if (monthItem.reward > 0.0)
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
                                                                                  if (functions.dayJSONtracksCount(containerTraksByDayResponse.jsonBody).toString() != '0')
                                                                                    Container(
                                                                                      width: 16.0,
                                                                                      height: 16.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Align(
                                                                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                        child: Text(
                                                                                          functions.dayJSONtracksCount(containerTraksByDayResponse.jsonBody).toString(),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                fontSize: 10.0,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                lineHeight: 1.2,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                ].divide(const SizedBox(width: 4.0)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        collapsed:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              8.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Flexible(
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Text(
                                                                                      '${valueOrDefault<String>(
                                                                                        formatNumber(
                                                                                          dailyItem.distance,
                                                                                          formatType: FormatType.custom,
                                                                                          format: '####.##',
                                                                                          locale: '',
                                                                                        ),
                                                                                        '0',
                                                                                      )} км',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            letterSpacing: 0.0,
                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      ' • ',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            letterSpacing: 0.0,
                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      '${valueOrDefault<String>(
                                                                                        formatNumber(
                                                                                          dailyItem.averageSpeed,
                                                                                          formatType: FormatType.custom,
                                                                                          format: '####.##',
                                                                                          locale: '',
                                                                                        ),
                                                                                        '0',
                                                                                      )} км/ч',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            letterSpacing: 0.0,
                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: const AlignmentDirectional(1.0, 0.0),
                                                                                child: Icon(
                                                                                  Icons.keyboard_arrow_down,
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  size: 24.0,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        expanded:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Flexible(
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        Text(
                                                                                          valueOrDefault<String>(
                                                                                            '${valueOrDefault<String>(
                                                                                              formatNumber(
                                                                                                dailyItem.distance,
                                                                                                formatType: FormatType.custom,
                                                                                                format: '####.##',
                                                                                                locale: '',
                                                                                              ),
                                                                                              '0',
                                                                                            )} км',
                                                                                            'error',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          ' • ',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          valueOrDefault<String>(
                                                                                            '${valueOrDefault<String>(
                                                                                              formatNumber(
                                                                                                dailyItem.averageSpeed,
                                                                                                formatType: FormatType.custom,
                                                                                                format: '####.##',
                                                                                                locale: '',
                                                                                              ),
                                                                                              '0',
                                                                                            )} км/ч',
                                                                                            'error',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                              ),
                                                                                        ),
                                                                                        Flexible(
                                                                                          child: Align(
                                                                                            alignment: const AlignmentDirectional(1.0, 0.0),
                                                                                            child: Icon(
                                                                                              Icons.keyboard_arrow_up,
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              size: 24.0,
                                                                                            ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation']!),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            StyledDivider(
                                                                              height: 30.0,
                                                                              thickness: 2.0,
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                              lineStyle: DividerLineStyle.dashed,
                                                                            ),
                                                                            Builder(
                                                                              builder: (context) {
                                                                                final dailyListView = MustGamesAPIGroup.traksByDayCall
                                                                                        .traks(
                                                                                          containerTraksByDayResponse.jsonBody,
                                                                                        )
                                                                                        ?.toList() ??
                                                                                    [];

                                                                                return ListView.separated(
                                                                                  padding: EdgeInsets.zero,
                                                                                  primary: false,
                                                                                  shrinkWrap: true,
                                                                                  scrollDirection: Axis.vertical,
                                                                                  itemCount: dailyListView.length,
                                                                                  separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                                                                                  itemBuilder: (context, dailyListViewIndex) {
                                                                                    final dailyListViewItem = dailyListView[dailyListViewIndex];
                                                                                    return Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Flexible(
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                children: [
                                                                                                  Row(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    children: [
                                                                                                      if (!dailyListViewItem.isFraud)
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                                          child: Container(
                                                                                                            width: 16.0,
                                                                                                            height: 16.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              image: DecorationImage(
                                                                                                                fit: BoxFit.cover,
                                                                                                                image: Image.asset(
                                                                                                                  'assets/images/Tracker_App_Status_OK.png',
                                                                                                                ).image,
                                                                                                              ),
                                                                                                              shape: BoxShape.circle,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      if (dailyListViewItem.isFraud)
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                                          child: Container(
                                                                                                            width: 16.0,
                                                                                                            height: 16.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              image: DecorationImage(
                                                                                                                fit: BoxFit.cover,
                                                                                                                image: Image.asset(
                                                                                                                  'assets/images/Tracker_App_Status_Empty.png',
                                                                                                                ).image,
                                                                                                              ),
                                                                                                              shape: BoxShape.circle,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      Text(
                                                                                                        '${valueOrDefault<String>(
                                                                                                          formatNumber(
                                                                                                            dailyListViewItem.averageSpeed,
                                                                                                            formatType: FormatType.custom,
                                                                                                            format: '####.##',
                                                                                                            locale: '',
                                                                                                          ),
                                                                                                          '0',
                                                                                                        )} км/ч',
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                            ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            ' • ',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                                ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            '${valueOrDefault<String>(
                                                                                                              formatNumber(
                                                                                                                dailyListViewItem.distance,
                                                                                                                formatType: FormatType.custom,
                                                                                                                format: '####.##',
                                                                                                                locale: '',
                                                                                                              ),
                                                                                                              '0',
                                                                                                            )} км',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                                ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  Flexible(
                                                                                                    child: Align(
                                                                                                      alignment: const AlignmentDirectional(1.0, 0.0),
                                                                                                      child: Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                                        children: [
                                                                                                          if (dailyListViewItem.rewardCorrection != 0)
                                                                                                            Text(
                                                                                                              '+${valueOrDefault<String>(
                                                                                                                formatNumber(
                                                                                                                  dailyListViewItem.rewardCorrection,
                                                                                                                  formatType: FormatType.custom,
                                                                                                                  format: '####.##',
                                                                                                                  locale: '',
                                                                                                                ),
                                                                                                                '0',
                                                                                                              )} ',
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                                  ),
                                                                                                            ),
                                                                                                          if (dailyListViewItem.rewardCorrection != 0)
                                                                                                            Container(
                                                                                                              width: 16.0,
                                                                                                              height: 16.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                image: DecorationImage(
                                                                                                                  fit: BoxFit.cover,
                                                                                                                  image: Image.asset(
                                                                                                                    'assets/images/Tracker_App_Warning_Icon.png',
                                                                                                                  ).image,
                                                                                                                ),
                                                                                                                shape: BoxShape.circle,
                                                                                                              ),
                                                                                                            ),
                                                                                                          if (dailyListViewItem.rewardTotal > 0.0)
                                                                                                            Text(
                                                                                                              ' +${valueOrDefault<String>(
                                                                                                                formatNumber(
                                                                                                                  dailyListViewItem.rewardTotal,
                                                                                                                  formatType: FormatType.custom,
                                                                                                                  format: '####.##',
                                                                                                                  locale: '',
                                                                                                                ),
                                                                                                                '0',
                                                                                                              )}',
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                                    color: FlutterFlowTheme.of(context).success,
                                                                                                                    fontSize: 14.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                                  ),
                                                                                                            ),
                                                                                                          if (dailyListViewItem.rewardTotal > 0.0)
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                                                                              child: Container(
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
                                                                                                            ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                                  children: [
                                                                                                    if (dailyListViewItem.isFraud)
                                                                                                      Text(
                                                                                                        'Корректировка:',
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                              letterSpacing: 0.0,
                                                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                            ),
                                                                                                      ),
                                                                                                    Text(
                                                                                                      ' старт ${valueOrDefault<String>(
                                                                                                        dateTimeFormat(
                                                                                                          "Hm",
                                                                                                          functions.stringToDateTime(dailyListViewItem.startDate),
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        ),
                                                                                                        '0',
                                                                                                      )}',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                            letterSpacing: 0.0,
                                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                          ),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      ' - ',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                            letterSpacing: 0.0,
                                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                          ),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      ' финиш ${valueOrDefault<String>(
                                                                                                        dateTimeFormat(
                                                                                                          "Hm",
                                                                                                          functions.stringToDateTime(dailyListViewItem.endDate),
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        ),
                                                                                                        '0',
                                                                                                      )}',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                            letterSpacing: 0.0,
                                                                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                                          ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ].divide(const SizedBox(height: 4.0)),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        theme:
                                                                            const ExpandableThemeData(
                                                                          tapHeaderToExpand:
                                                                              true,
                                                                          tapBodyToExpand:
                                                                              true,
                                                                          tapBodyToCollapse:
                                                                              true,
                                                                          headerAlignment:
                                                                              ExpandablePanelHeaderAlignment.center,
                                                                          hasIcon:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.0, 1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 16.0, 16.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.limit = _model.limit! + 10;
                                      _model.apiResultAllDataMonthCopy =
                                          await MustGamesAPIGroup
                                              .traksAllMonthCall
                                              .call(
                                        userToken: FFAppState().token,
                                        offset: _model.offset,
                                        limit: _model.limit,
                                      );

                                      if ((_model.apiResultAllDataMonthCopy
                                              ?.succeeded ??
                                          true)) {
                                        _model.monthDataType = functions
                                            .convertMonthlyJSON((_model
                                                    .apiResultAllDataMonthCopy
                                                    ?.jsonBody ??
                                                ''))
                                            .toList()
                                            .cast<MonthlyDTStruct>();
                                        safeSetState(() {});
                                      }
                                      await Future.delayed(
                                          const Duration(milliseconds: 1000));

                                      FFAppState().update(() {});

                                      safeSetState(() {});
                                    },
                                    text: 'Показать предыдущие',
                                    icon: Icon(
                                      FFIcons.karrowCircle,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 52.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'buttonOnPageLoadAnimation']!),
                                ),
                              ),
                            ].addToEnd(const SizedBox(height: 180.0)),
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
