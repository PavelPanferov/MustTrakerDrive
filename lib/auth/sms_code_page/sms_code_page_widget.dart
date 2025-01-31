import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sms_code_page_model.dart';
export 'sms_code_page_model.dart';

class SmsCodePageWidget extends StatefulWidget {
  const SmsCodePageWidget({
    super.key,
    required this.phone,
  });

  final String? phone;

  @override
  State<SmsCodePageWidget> createState() => _SmsCodePageWidgetState();
}

class _SmsCodePageWidgetState extends State<SmsCodePageWidget>
    with TickerProviderStateMixin {
  late SmsCodePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SmsCodePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      _model.timerController.onStartTimer();

      safeSetState(() {});
      await Future.delayed(const Duration(milliseconds: 30000));
      _model.timerController.onResetTimer();

      safeSetState(() {});
    });

    _model.codeTextController ??= TextEditingController();
    _model.codeFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ShakeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            hz: 5,
            offset: const Offset(0.0, 0.0),
            rotation: 0.087,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
            SizedBox(
              height: 150.0,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 110.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
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
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: 96.0,
                      height: 96.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/avatar_64.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          '— Введи код из СМС для номера ${valueOrDefault<String>(
                            FFAppState().country == 'bel'
                                ? valueOrDefault<String>(
                                    functions.phoneClearBel(widget.phone!),
                                    '-',
                                  )
                                : valueOrDefault<String>(
                                    functions.phoneClearRU(widget.phone!),
                                    '-',
                                  ),
                            '-',
                          )}',
                          '— Введи код из СМС для номера -',
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                              lineHeight: 1.25,
                            ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Stack(
                                alignment: const AlignmentDirectional(1.0, 0.0),
                                children: [
                                  Form(
                                    key: _model.formKey,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _model.codeTextController,
                                        focusNode: _model.codeFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.codeTextController',
                                          const Duration(milliseconds: 300),
                                          () async {
                                            _model.error = false;
                                            _model.checking = false;
                                            safeSetState(() {});
                                            if ((_model.codeTextController.text
                                                    .length) ==
                                                4) {
                                              _model.checking = true;
                                              safeSetState(() {});
                                              _model.loginJWTResponsChange =
                                                  await MUSTProDriveGroup
                                                      .loginJWTCall
                                                      .call(
                                                phone: widget.phone,
                                                otp: _model
                                                    .codeTextController.text,
                                                otpState: FFAppState().OtpState,
                                              );

                                              if ((_model.loginJWTResponsChange
                                                      ?.succeeded ??
                                                  true)) {
                                                FFAppState().token =
                                                    MUSTProDriveGroup
                                                        .loginJWTCall
                                                        .token(
                                                  (_model.loginJWTResponsChange
                                                          ?.jsonBody ??
                                                      ''),
                                                )!;
                                                FFAppState().OtpState = 0;
                                                safeSetState(() {});
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 250));

                                                context.goNamed('splashPage');
                                              } else {
                                                _model.checking = false;
                                                _model.error = true;
                                                safeSetState(() {});
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Произошла ошибка! Неверный код из СМС, пожалуйста повторите попытку',
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
                                                HapticFeedback.lightImpact();
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                        ),
                                        onFieldSubmitted: (_) async {
                                          _model.valid = true;
                                          if (_model.formKey.currentState ==
                                                  null ||
                                              !_model.formKey.currentState!
                                                  .validate()) {
                                            safeSetState(
                                                () => _model.valid = false);
                                            return;
                                          }
                                          if (_model.valid!) {
                                            _model.checking = true;
                                            safeSetState(() {});
                                            _model.loginJWTRespons =
                                                await MUSTProDriveGroup
                                                    .loginJWTCall
                                                    .call(
                                              phone: widget.phone,
                                              otp: _model
                                                  .codeTextController.text,
                                              otpState: FFAppState().OtpState,
                                            );

                                            if ((_model.loginJWTRespons
                                                    ?.succeeded ??
                                                true)) {
                                              FFAppState().token =
                                                  MUSTProDriveGroup.loginJWTCall
                                                      .token(
                                                (_model.loginJWTRespons
                                                        ?.jsonBody ??
                                                    ''),
                                              )!;
                                              FFAppState().OtpState = 0;
                                              FFAppState().update(() {});
                                              await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 200));

                                              context.goNamed('splashPage');
                                            } else {
                                              _model.checking = false;
                                              _model.error = true;
                                              safeSetState(() {});
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Произошла ошибка! Неверный код из СМС, пожалуйста повторите попытку',
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
                                          } else {
                                            _model.error = true;
                                            safeSetState(() {});
                                            HapticFeedback.vibrate();
                                            if (animationsMap[
                                                    'containerOnActionTriggerAnimation'] !=
                                                null) {
                                              await animationsMap[
                                                      'containerOnActionTriggerAnimation']!
                                                  .controller
                                                  .forward(from: 0.0);
                                            }
                                          }

                                          safeSetState(() {});
                                        },
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: false,
                                          hintText: '1234',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryText,
                                                fontSize: 20.0,
                                                letterSpacing: 4.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily),
                                                lineHeight: 1.4,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: valueOrDefault<Color>(
                                                _model.error
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .accent2
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .borderColor,
                                                FlutterFlowTheme.of(context)
                                                    .accent2,
                                              ),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .borderColor,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          filled: true,
                                          fillColor: valueOrDefault<Color>(
                                            _model.error
                                                ? FlutterFlowTheme.of(context)
                                                    .accent2
                                                : FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            FlutterFlowTheme.of(context)
                                                .accent2,
                                          ),
                                          contentPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 20.0, 16.0, 20.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 20.0,
                                              letterSpacing: 4.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                              lineHeight: 1.4,
                                            ),
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        validator: _model
                                            .codeTextControllerValidator
                                            .asValidator(context),
                                        inputFormatters: [_model.codeMask],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(1.0, 0.0),
                                    child: Builder(
                                      builder: (context) {
                                        if (_model.checking) {
                                          return Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 12.0, 0.0),
                                            child: Container(
                                              width: 24.0,
                                              height: 24.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.asset(
                                                    'assets/images/loading_dark.png',
                                                  ).image,
                                                ),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'containerOnPageLoadAnimation']!),
                                          );
                                        } else if (_model.error) {
                                          return Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 12.0, 0.0),
                                            child: Container(
                                              width: 24.0,
                                              height: 24.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Icon(
                                                  FFIcons.ksubtract,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 14.0,
                                                ),
                                              ),
                                            ).animateOnActionTrigger(
                                              animationsMap[
                                                  'containerOnActionTriggerAnimation']!,
                                            ),
                                          );
                                        } else {
                                          return Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 2.0, 0.0),
                                            child: Container(
                                              width: 0.0,
                                              height: 0.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (_model.error)
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 6.0, 0.0, 0.0),
                                child: Text(
                                  'Введен неверный код из СМС',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                        lineHeight: 1.25,
                                      ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            if (!_model.timer) {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Запросить код повторно через',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
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
                                  FlutterFlowTimer(
                                    initialTime: _model.timerInitialTimeMs,
                                    getDisplayTime: (value) =>
                                        StopWatchTimer.getDisplayTime(
                                      value,
                                      hours: false,
                                      milliSecond: false,
                                    ),
                                    controller: _model.timerController,
                                    updateStateInterval:
                                        const Duration(milliseconds: 1000),
                                    onChanged:
                                        (value, displayTime, shouldUpdate) {
                                      _model.timerMilliseconds = value;
                                      _model.timerValue = displayTime;
                                      if (shouldUpdate) safeSetState(() {});
                                    },
                                    onEnded: () async {
                                      _model.timer = true;
                                      safeSetState(() {});
                                      FFAppState().OtpState = 0;
                                      safeSetState(() {});
                                    },
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmallFamily),
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                  Text(
                                    'сек',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
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
                                ].divide(const SizedBox(width: 4.0)),
                              );
                            } else {
                              return FFButtonWidget(
                                onPressed: () async {
                                  if (_model.checking == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Идет проверка...',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  } else {
                                    FFAppState().OtpState = 0;
                                    safeSetState(() {});
                                    _model.authResendCode =
                                        await MUSTProDriveGroup.authOTPCall
                                            .call(
                                      phoneNumber: widget.phone,
                                    );

                                    if ((_model.authResendCode?.succeeded ??
                                        true)) {
                                      await Future.delayed(
                                          const Duration(milliseconds: 400));
                                      safeSetState(() {
                                        _model.codeTextController?.clear();
                                      });
                                      FFAppState().OtpState = MUSTProDriveGroup
                                          .authOTPCall
                                          .otpState(
                                        (_model.authResendCode?.jsonBody ?? ''),
                                      )!;
                                      safeSetState(() {});
                                      _model.timerController.onResetTimer();

                                      safeSetState(() {});
                                      await Future.delayed(
                                          const Duration(milliseconds: 500));
                                      _model.timerController.onStartTimer();
                                      _model.timer = false;
                                      safeSetState(() {});
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Ошибка при отправке кода, пожалуйста повторите действие!',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }
                                  }

                                  safeSetState(() {});
                                },
                                text: 'Запросить новый код',
                                options: FFButtonOptions(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Colors.transparent,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                        lineHeight: 1.5,
                                      ),
                                  elevation: 0.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                  ),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['buttonOnPageLoadAnimation']!);
                            }
                          },
                        ),
                      ),
                    ]
                        .divide(const SizedBox(height: 12.0))
                        .addToStart(const SizedBox(height: 12.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
