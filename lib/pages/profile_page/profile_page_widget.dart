import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/navbar/navbar_widget.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget>
    with TickerProviderStateMixin {
  late ProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.driverCompleteResultApiProfile =
          await MUSTProDriveGroup.driverCompleteCall.call(
        token: FFAppState().token,
      );

      if ((_model.driverCompleteResultApiProfile?.succeeded ?? true)) {
        FFAppState().completeDriverDT = DriverCompleteDTStruct(
          onBoarding: MUSTProDriveGroup.driverCompleteCall.onBoarding(
            (_model.driverCompleteResultApiProfile?.jsonBody ?? ''),
          ),
          registration: MUSTProDriveGroup.driverCompleteCall.registration(
            (_model.driverCompleteResultApiProfile?.jsonBody ?? ''),
          ),
          noBot: MUSTProDriveGroup.driverCompleteCall.noBot(
            (_model.driverCompleteResultApiProfile?.jsonBody ?? ''),
          ),
          experience: MUSTProDriveGroup.driverCompleteCall.experience(
            (_model.driverCompleteResultApiProfile?.jsonBody ?? ''),
          ),
          dreamJob: MUSTProDriveGroup.driverCompleteCall.dreamJob(
            (_model.driverCompleteResultApiProfile?.jsonBody ?? ''),
          ),
          employmentStatus:
              MUSTProDriveGroup.driverCompleteCall.employmentStatus(
            (_model.driverCompleteResultApiProfile?.jsonBody ?? ''),
          ),
          myVehicle: MUSTProDriveGroup.driverCompleteCall.myVehicle(
            (_model.driverCompleteResultApiProfile?.jsonBody ?? ''),
          ),
          myFleet: MUSTProDriveGroup.driverCompleteCall.myFleet(
            (_model.driverCompleteResultApiProfile?.jsonBody ?? ''),
          ),
        );
        safeSetState(() {});
      }

      safeSetState(() {});
    });

    animationsMap.addAll({
      'circleImageOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
              child: SizedBox(
                width: 136.0,
                height: 44.0,
                child: custom_widgets.CustomSlider(
                  width: 136.0,
                  height: 44.0,
                  tracker: FFAppState().tracker,
                  iconON: Icon(
                    FFIcons.kcup2,
                    color: FlutterFlowTheme.of(context).info,
                    size: 36.0,
                  ),
                  iconOFF: Icon(
                    FFIcons.kstopnew,
                    color: FlutterFlowTheme.of(context).info,
                    size: 32.0,
                  ),
                  colorON: FlutterFlowTheme.of(context).success,
                  colorOFF: FlutterFlowTheme.of(context).error,
                  textON: 'В турнире',
                  textOFF: 'Выключен',
                  fontSize: 14.0,
                  fontWeight: 600.0,
                  textPadding: 10.0,
                  iconPaddingRight: 6.0,
                  iconPaddingLeft: 2.0,
                  onChanged: () async {
                    if (FFAppState().tracker) {
                      FFAppState().tracker = false;
                      FFAppState().update(() {});
                      unawaited(
                        () async {
                          await actions.stopBackgroundService();
                        }(),
                      );
                    } else {
                      _model.outPut2 = await actions.prepareAppEnvironment(
                        FFAppState().userDataAPI.userID,
                        FFAppState().token,
                      );
                      if (_model.outPut2!) {
                        FFAppState().tracker = true;
                        FFAppState().update(() {});
                        unawaited(
                          () async {
                            _model.startBGService =
                                await actions.startBackgroundServiceCopy(
                              FFAppState().userDataAPI.userID,
                              FFAppState().token,
                            );
                          }(),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Необходимо предоставить разрешения для работы приложения!',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      }
                    }

                    safeSetState(() {});
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.0, -1.0),
                      child: Container(
                        width: 132.0,
                        height: 132.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: 112.0,
                                height: 112.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  functions.createURLfromID(
                                      FFAppState().userDataAPI.avatarBlobId)!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/images/error_image.webp',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'circleImageOnPageLoadAnimation']!),
                            ),
                            CircularPercentIndicator(
                              percent: valueOrDefault<double>(
                                valueOrDefault<double>(
                                      functions.completeDriverCounter(
                                          FFAppState().completeDriverDT),
                                      0.0,
                                    ) *
                                    0.01,
                                0.0,
                              ),
                              radius: 66.0,
                              lineWidth: 4.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor:
                                  FlutterFlowTheme.of(context).primary,
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                              startAngle: 180.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: valueOrDefault<String>(
                              '${valueOrDefault<String>(
                                formatNumber(
                                  functions.completeDriverCounter(
                                      FFAppState().completeDriverDT),
                                  formatType: FormatType.custom,
                                  format: '',
                                  locale: '',
                                ),
                                '0',
                              )}% заполнения • ',
                              '0 % заполнения • ',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                  lineHeight: 1.4,
                                ),
                          ),
                          TextSpan(
                            text: valueOrDefault<String>(
                              '${functions.timeToAge(FFAppState().userDataAPI.bornOn, getCurrentTimestamp).toString()} ${valueOrDefault<String>(
                                functions.ageConvertString(functions.timeToAge(
                                    FFAppState().userDataAPI.bornOn,
                                    getCurrentTimestamp)!),
                                '0',
                              )}',
                              ' лет',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                  lineHeight: 1.4,
                                ),
                          )
                        ],
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Text(
                        valueOrDefault<String>(
                          '${FFAppState().userDataAPI.firstName} ${FFAppState().userDataAPI.lastName}',
                          'Ваше Имя',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 20.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                              lineHeight: 1.4,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 12.0, 16.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                FFIcons.kphonenew,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      valueOrDefault<String>(
                                        FFAppState().userDataAPI.phoneFormatted,
                                        '+7(999)999-99-99',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                            lineHeight: 1.25,
                                          ),
                                    ),
                                    Text(
                                      'Основной',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                            lineHeight: 1.25,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 6.0)),
                                ),
                              ),
                            ].divide(const SizedBox(width: 12.0)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Text(
                              'Мои документы',
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
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 16.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    FFIcons.kdrivingLicent,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            functions.convertDriverNumber(
                                                valueOrDefault<String>(
                                              FFAppState()
                                                  .userDataAPI
                                                  .legalEntityNumber,
                                              '123456789',
                                            )),
                                            '12 34 567890',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                                lineHeight: 1.25,
                                              ),
                                        ),
                                        Text(
                                          'Водительское удостоверение',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                                lineHeight: 1.25,
                                              ),
                                        ),
                                      ].divide(const SizedBox(height: 6.0)),
                                    ),
                                  ),
                                ].divide(const SizedBox(width: 12.0)),
                              ),
                            ),
                          ),
                        ]
                            .divide(const SizedBox(height: 10.0))
                            .addToStart(const SizedBox(height: 4.0)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          HapticFeedback.selectionClick();
                          await launchURL('https://clck.ru/3Dfzwn');
                        },
                        text: 'Перейти в Турнир',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 52.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                                lineHeight: 1.25,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Выйти из учетной записи?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: const Text('Нет'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: const Text('Да'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            FFAppState().userDataAPI = UserInformationStruct();
                            FFAppState().token = '';
                            FFAppState().OtpState = 0;
                            FFAppState().completeDriverDT =
                                DriverCompleteDTStruct();
                            FFAppState().startingStatusBool = false;
                            if (FFAppState().tracker) {
                              unawaited(
                                () async {
                                  await actions.stopBackgroundService();
                                }(),
                              );
                              HapticFeedback.lightImpact();

                              context.goNamed('splashPage');
                            } else {
                              HapticFeedback.lightImpact();

                              context.goNamed('splashPage');
                            }
                          }
                        },
                        text: 'Выйти',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 52.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                                lineHeight: 1.25,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).borderColor,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ]
                      .divide(const SizedBox(height: 16.0))
                      .addToStart(const SizedBox(height: 24.0))
                      .addToEnd(const SizedBox(height: 32.0)),
                ),
              ),
            ),
            wrapWithModel(
              model: _model.navbarModel,
              updateCallback: () => safeSetState(() {}),
              child: const NavbarWidget(
                pageNumber: 3,
              ),
            ),
          ].divide(const SizedBox(height: 12.0)).addToStart(const SizedBox(height: 48.0)),
        ),
      ),
    );
  }
}
