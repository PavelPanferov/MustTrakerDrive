import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/countries_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/appbar/appbar_widget.dart';
import 'dart:async';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'auth_page_add_phone_model.dart';
export 'auth_page_add_phone_model.dart';

class AuthPageAddPhoneWidget extends StatefulWidget {
  const AuthPageAddPhoneWidget({super.key});

  @override
  State<AuthPageAddPhoneWidget> createState() => _AuthPageAddPhoneWidgetState();
}

class _AuthPageAddPhoneWidgetState extends State<AuthPageAddPhoneWidget>
    with TickerProviderStateMixin {
  late AuthPageAddPhoneModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthPageAddPhoneModel());

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.textFieldBELTextController ??= TextEditingController();
    _model.textFieldBELFocusNode ??= FocusNode();
    _model.textFieldBELFocusNode!.addListener(() => safeSetState(() {}));
    _model.textFieldRUKZTextController ??= TextEditingController();
    _model.textFieldRUKZFocusNode ??= FocusNode();
    _model.textFieldRUKZFocusNode!.addListener(() => safeSetState(() {}));
    animationsMap.addAll({
      'containerOnActionTriggerAnimation1': AnimationInfo(
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
      'containerOnActionTriggerAnimation2': AnimationInfo(
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
            delay: 300.0.ms,
            duration: 300.0.ms,
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
  }

  @override
  void dispose() {
    _model.dispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
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
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '— Введи телефон, чтобы войти в свой личный кабинет ProDrive',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                                lineHeight: 1.25,
                              ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 20.0, 0.0, 0.0),
                          child: SizedBox(
                            height: 60.0,
                            child: Stack(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (FFAppState().country == 'bel') {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller: _model
                                                  .textFieldBELTextController,
                                              focusNode:
                                                  _model.textFieldBELFocusNode,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.textFieldBELTextController',
                                                const Duration(milliseconds: 0),
                                                () async {
                                                  _model.error = false;
                                                  safeSetState(() {});
                                                },
                                              ),
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily),
                                                          lineHeight: 1.4,
                                                        ),
                                                hintText: '+375(12)345-67-67',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily),
                                                          lineHeight: 1.4,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                        valueOrDefault<Color>(
                                                      _model.error
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .error
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .borderColor,
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .borderColor,
                                                    ),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .borderColor,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                contentPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(88.0, 20.0,
                                                            16.0, 20.0),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                        lineHeight: 1.4,
                                                      ),
                                              keyboardType: TextInputType.phone,
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              validator: _model
                                                  .textFieldBELTextControllerValidator
                                                  .asValidator(context),
                                              inputFormatters: [
                                                _model.textFieldBELMask
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller: _model
                                                  .textFieldRUKZTextController,
                                              focusNode:
                                                  _model.textFieldRUKZFocusNode,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.textFieldRUKZTextController',
                                                const Duration(milliseconds: 0),
                                                () async {
                                                  _model.error = false;
                                                  safeSetState(() {});
                                                },
                                              ),
                                              onFieldSubmitted: (_) async {
                                                if (_model.textFieldRUKZTextController
                                                            .text ==
                                                        '') {
                                                  safeSetState(() {
                                                    _model
                                                        .textFieldRUKZTextController
                                                        ?.text = '+7';
                                                    _model.textFieldRUKZMask
                                                        .updateMask(
                                                      newValue:
                                                          TextEditingValue(
                                                        text: _model
                                                            .textFieldRUKZTextController!
                                                            .text,
                                                      ),
                                                    );
                                                  });
                                                }
                                              },
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: false,
                                                hintText: '+7(123)345-67-67',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          fontSize: 16.0,
                                                          letterSpacing: 1.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily),
                                                          lineHeight: 1.4,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: _model.error
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .error
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .borderColor,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .borderColor,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                contentPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(88.0, 20.0,
                                                            16.0, 20.0),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                        lineHeight: 1.4,
                                                      ),
                                              keyboardType: TextInputType.phone,
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              validator: _model
                                                  .textFieldRUKZTextControllerValidator
                                                  .asValidator(context),
                                              inputFormatters: [
                                                _model.textFieldRUKZMask
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: Builder(
                                    builder: (context) => Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          1.0, 6.0, 0.0, 6.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await showAlignedDialog(
                                            barrierColor: Colors.transparent,
                                            context: context,
                                            isGlobal: false,
                                            avoidOverflow: true,
                                            targetAnchor: const AlignmentDirectional(
                                                    0.0, 1.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                            followerAnchor:
                                                const AlignmentDirectional(0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                            builder: (dialogContext) {
                                              return Material(
                                                color: Colors.transparent,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: const CountriesWidget(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 60.0,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .customColor1,
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(12.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(12.0),
                                              topRight: Radius.circular(0.0),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Builder(
                                                builder: (context) {
                                                  if (FFAppState().country ==
                                                      'bel') {
                                                    return Container(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/Flag_of_Belarus.svg.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  } else if (FFAppState()
                                                          .country ==
                                                      'kz') {
                                                    return Container(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/Flag_of_Kazakhstan.svg.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/images.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 0.0),
                                                child: FaIcon(
                                                  FontAwesomeIcons.angleDown,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 18.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.privacy = !_model.privacy;
                                safeSetState(() {});
                                if (_model.privacy) {
                                  _model.error = false;
                                  safeSetState(() {});
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12.0, 12.0, 12.0, 12.0),
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(
                                        color: valueOrDefault<Color>(
                                          !_model.privacy && _model.error
                                              ? FlutterFlowTheme.of(context)
                                                  .error
                                              : FlutterFlowTheme.of(context)
                                                  .borderColor,
                                          FlutterFlowTheme.of(context)
                                              .borderColor,
                                        ),
                                      ),
                                    ),
                                    child: Visibility(
                                      visible: _model.privacy,
                                      child: Icon(
                                        Icons.check_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 14.0,
                                      ),
                                    ),
                                  ).animateOnActionTrigger(
                                    animationsMap[
                                        'containerOnActionTriggerAnimation1']!,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Я подтверждаю ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                            lineHeight: 1.4,
                                          ),
                                    ),
                                    TextSpan(
                                      text:
                                          'согласие на обработку моих персональных данных',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                            lineHeight: 1.4,
                                          ),
                                      mouseCursor: SystemMouseCursors.click,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          await launchURL(
                                              FFAppConstants.privacyURL);
                                        },
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.terms = !_model.terms;
                              safeSetState(() {});
                              if (_model.terms) {
                                _model.error = false;
                                safeSetState(() {});
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 12.0, 12.0),
                                child: Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      color: valueOrDefault<Color>(
                                        !_model.terms && _model.error
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .borderColor,
                                        FlutterFlowTheme.of(context)
                                            .borderColor,
                                      ),
                                    ),
                                  ),
                                  child: Visibility(
                                    visible: _model.terms,
                                    child: Icon(
                                      Icons.check_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 14.0,
                                    ),
                                  ),
                                ).animateOnActionTrigger(
                                  animationsMap[
                                      'containerOnActionTriggerAnimation2']!,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Я принимаю условия ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'политики конфиденциальности',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                          lineHeight: 1.4,
                                        ),
                                    mouseCursor: SystemMouseCursors.click,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await launchURL(
                                            FFAppConstants.termsOfUseURL);
                                      },
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                        .divide(const SizedBox(height: 12.0))
                        .addToStart(const SizedBox(height: 12.0)),
                  ),
                ),
              ),
            ),
            if (!(isWeb
                ? MediaQuery.viewInsetsOf(context).bottom > 0
                : _isKeyboardVisible))
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 48.0),
                child: FFButtonWidget(
                  onPressed: (FFAppState().country == 'bel'
                          ? (random_data.randomInteger(17, 17) <
                              (valueOrDefault<String>(
                                _model.textFieldBELTextController.text,
                                '0',
                              ).length))
                          : ((_model.textFieldRUKZTextController.text.length) <
                              16))
                      ? null
                      : () async {
                          var shouldSetState = false;
                          HapticFeedback.lightImpact();
                          if (functions.phoneValidation(
                              FFAppState().country == 'bel'
                                  ? _model.textFieldBELTextController.text
                                  : _model.textFieldRUKZTextController.text)) {
                            if (_model.privacy && _model.terms) {
                              _model.code =
                                  await MUSTProDriveGroup.authOTPCall.call(
                                phoneNumber: FFAppState().country == 'bel'
                                    ? _model.textFieldBELTextController.text
                                    : _model.textFieldRUKZTextController.text,
                              );

                              shouldSetState = true;
                              if ((_model.code?.succeeded ?? true)) {
                                FFAppState().OtpState =
                                    MUSTProDriveGroup.authOTPCall.otpState(
                                  (_model.code?.jsonBody ?? ''),
                                )!;
                                FFAppState().userDataAPI =
                                    UserInformationStruct();
                                FFAppState().completeDriverDT =
                                    DriverCompleteDTStruct();
                                FFAppState().token = '';
                                safeSetState(() {});

                                context.pushNamed(
                                  'SmsCodePage',
                                  queryParameters: {
                                    'phone': serializeParam(
                                      FFAppState().country == 'bel'
                                          ? _model
                                              .textFieldBELTextController.text
                                          : _model
                                              .textFieldRUKZTextController.text,
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );

                                if (shouldSetState) safeSetState(() {});
                                return;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Ошибка! Попробуйте повторить действие через 20 секунд',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                                _model.error = true;
                                safeSetState(() {});
                                if (shouldSetState) safeSetState(() {});
                                return;
                              }
                            } else {
                              HapticFeedback.vibrate();
                              _model.error = true;
                              safeSetState(() {});
                              if (!_model.privacy && !_model.terms) {
                                await Future.wait([
                                  Future(() async {
                                    if (animationsMap[
                                            'containerOnActionTriggerAnimation1'] !=
                                        null) {
                                      await animationsMap[
                                              'containerOnActionTriggerAnimation1']!
                                          .controller
                                          .forward(from: 0.0);
                                    }
                                  }),
                                  Future(() async {
                                    if (animationsMap[
                                            'containerOnActionTriggerAnimation2'] !=
                                        null) {
                                      await animationsMap[
                                              'containerOnActionTriggerAnimation2']!
                                          .controller
                                          .forward(from: 0.0);
                                    }
                                  }),
                                ]);
                                if (shouldSetState) safeSetState(() {});
                                return;
                              }
                              if (!_model.privacy) {
                                if (animationsMap[
                                        'containerOnActionTriggerAnimation1'] !=
                                    null) {
                                  await animationsMap[
                                          'containerOnActionTriggerAnimation1']!
                                      .controller
                                      .forward(from: 0.0);
                                }
                              }
                              if (!_model.terms) {
                                if (animationsMap[
                                        'containerOnActionTriggerAnimation2'] !=
                                    null) {
                                  await animationsMap[
                                          'containerOnActionTriggerAnimation2']!
                                      .controller
                                      .forward(from: 0.0);
                                }
                              }
                              if (shouldSetState) safeSetState(() {});
                              return;
                            }
                          } else {
                            HapticFeedback.vibrate();
                            _model.error = true;
                            safeSetState(() {});
                            if (shouldSetState) safeSetState(() {});
                            return;
                          }

                          if (shouldSetState) safeSetState(() {});
                        },
                  text: 'Далее',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 52.0,
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).titleSmallFamily,
                          color: Colors.white,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily),
                          lineHeight: 1.25,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(12.0),
                    disabledColor: const Color(0xB23875CF),
                  ),
                ).animateOnPageLoad(
                    animationsMap['buttonOnPageLoadAnimation']!),
              ),
          ],
        ),
      ),
    );
  }
}
