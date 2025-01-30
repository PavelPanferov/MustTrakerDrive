import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'splash_page_model.dart';
export 'splash_page_model.dart';

class SplashPageWidget extends StatefulWidget {
  const SplashPageWidget({super.key});

  @override
  State<SplashPageWidget> createState() => _SplashPageWidgetState();
}

class _SplashPageWidgetState extends State<SplashPageWidget>
    with TickerProviderStateMixin {
  late SplashPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().token != '') {
        _model.profileGetCheck = await MUSTProDriveGroup.profileGETCall.call(
          token: FFAppState().token,
        );

        await Future.delayed(const Duration(milliseconds: 350));
        if ((_model.profileGetCheck?.succeeded ?? true)) {
          FFAppState().userDataAPI = UserInformationStruct(
            firstName: valueOrDefault<String>(
              MUSTProDriveGroup.profileGETCall.firstName(
                (_model.profileGetCheck?.jsonBody ?? ''),
              ),
              'null',
            ),
            lastName: valueOrDefault<String>(
              MUSTProDriveGroup.profileGETCall.lastName(
                (_model.profileGetCheck?.jsonBody ?? ''),
              ),
              'null',
            ),
            patronymic: valueOrDefault<String>(
              MUSTProDriveGroup.profileGETCall.patronymic(
                (_model.profileGetCheck?.jsonBody ?? ''),
              ),
              'null',
            ),
            email: valueOrDefault<String>(
              MUSTProDriveGroup.profileGETCall.email(
                (_model.profileGetCheck?.jsonBody ?? ''),
              ),
              'null',
            ),
            bornOn: functions.stringToDateTime(valueOrDefault<String>(
              MUSTProDriveGroup.profileGETCall.bornOn(
                (_model.profileGetCheck?.jsonBody ?? ''),
              ),
              'null',
            )),
            mainPhone: valueOrDefault<String>(
              MUSTProDriveGroup.profileGETCall.phonesmain(
                (_model.profileGetCheck?.jsonBody ?? ''),
              ),
              'null',
            ),
            phoneFormatted: valueOrDefault<String>(
              MUSTProDriveGroup.profileGETCall.formattedPhone(
                (_model.profileGetCheck?.jsonBody ?? ''),
              ),
              'null',
            ),
            avatarBlobId: valueOrDefault<String>(
              MUSTProDriveGroup.profileGETCall.avatarBlobId(
                (_model.profileGetCheck?.jsonBody ?? ''),
              ),
              'null',
            ),
            userID: MUSTProDriveGroup.profileGETCall
                .userID(
                  (_model.profileGetCheck?.jsonBody ?? ''),
                )
                ?.toString(),
          );
          if ((FFAppState().userDataAPI.firstName != '') &&
              (FFAppState().userDataAPI.firstName != 'null')) {
            _model.driverNumberApiResult =
                await MUSTProDriveGroup.normalizedHumanDataCall.call(
              token: FFAppState().token,
              userCrossSystemId: FFAppState().userDataAPI.userID,
            );

            await Future.delayed(const Duration(milliseconds: 350));
            if ((_model.driverNumberApiResult?.succeeded ?? true)) {
              if (MUSTProDriveGroup.normalizedHumanDataCall.seriesAndNumber(
                        (_model.driverNumberApiResult?.jsonBody ?? ''),
                      ) !=
                      null &&
                  MUSTProDriveGroup.normalizedHumanDataCall.seriesAndNumber(
                        (_model.driverNumberApiResult?.jsonBody ?? ''),
                      ) !=
                      '') {
                FFAppState().updateUserDataAPIStruct(
                  (e) => e
                    ..legalEntityNumber = MUSTProDriveGroup
                        .normalizedHumanDataCall
                        .seriesAndNumber(
                      (_model.driverNumberApiResult?.jsonBody ?? ''),
                    ),
                );
                FFAppState().update(() {});

                context.goNamed(
                  'TrackerPage',
                  extra: <String, dynamic>{
                    kTransitionInfoKey: const TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Ошибка seriesAndNumber is set',
                      style: TextStyle(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                    duration: const Duration(milliseconds: 4000),
                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                  ),
                );

                context.goNamed(
                  'authBlockProfile',
                  extra: <String, dynamic>{
                    kTransitionInfoKey: const TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Ошибка NormalizedHumanData',
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  duration: const Duration(milliseconds: 4000),
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                ),
              );

              context.goNamed(
                'authBlockProfile',
                extra: <String, dynamic>{
                  kTransitionInfoKey: const TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Ошибка ProfileGet',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                duration: const Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).secondary,
              ),
            );

            context.goNamed(
              'profileBlock',
              extra: <String, dynamic>{
                kTransitionInfoKey: const TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );
          }
        } else {
          HapticFeedback.lightImpact();

          context.goNamed(
            'OnboadingStartPage',
            extra: <String, dynamic>{
              kTransitionInfoKey: const TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );
        }
      } else {
        context.goNamed(
          'OnboadingStartPage',
          extra: <String, dynamic>{
            kTransitionInfoKey: const TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      }
    });

    animationsMap.addAll({
      'imageOnPageLoadAnimation': AnimationInfo(
        loop: true,
        reverse: true,
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primary,
          body: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/splash.webp',
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        fit: BoxFit.cover,
                      ),
                    ).animateOnPageLoad(
                        animationsMap['imageOnPageLoadAnimation']!),
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 70.0),
                  child: Text(
                    'v.1.0.12',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
