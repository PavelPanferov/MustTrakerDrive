import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start MUSTProDrive Group Code

class MUSTProDriveGroup {
  static String getBaseUrl() => 'https://api.must.io';
  static Map<String, String> headers = {};
  static AuthOTPCall authOTPCall = AuthOTPCall();
  static AuthorizePersonalDataProcessinCall authorizePersonalDataProcessinCall =
      AuthorizePersonalDataProcessinCall();
  static ConfirmTermsOfServiceCall confirmTermsOfServiceCall =
      ConfirmTermsOfServiceCall();
  static LoginJWTCall loginJWTCall = LoginJWTCall();
  static ProfileGETCall profileGETCall = ProfileGETCall();
  static DriverCompleteCall driverCompleteCall = DriverCompleteCall();
  static NormalizedHumanDataCall normalizedHumanDataCall =
      NormalizedHumanDataCall();
}

class AuthOTPCall {
  Future<ApiCallResponse> call({
    String? phoneNumber = '',
  }) async {
    final baseUrl = MUSTProDriveGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "phone": "$phoneNumber"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AuthOTP',
      apiUrl: '$baseUrl/api/auth/otp',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? otpState(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.otpState''',
      ));
}

class AuthorizePersonalDataProcessinCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = MUSTProDriveGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "isConfirmed": true
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AuthorizePersonalDataProcessin',
      apiUrl: '$baseUrl/api/profile/authorize-personal-data-processing',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ConfirmTermsOfServiceCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = MUSTProDriveGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "isConfirmed": true
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Confirm Terms Of Service',
      apiUrl: '$baseUrl/api/profile/confirm-terms-of-service',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LoginJWTCall {
  Future<ApiCallResponse> call({
    String? phone = '',
    int? otpState,
    String? otp = '',
  }) async {
    final baseUrl = MUSTProDriveGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "phone": "$phone",
  "otpState": $otpState,
  "otp": "$otp",
  "source": "1f12f66b-dcdf-41aa-81c8-1420c59d32f7",
  "utm": {}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login JWT',
      apiUrl: '$baseUrl/api/auth/login/jwt',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.token''',
      ));
}

class ProfileGETCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = MUSTProDriveGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'ProfileGET',
      apiUrl: '$baseUrl/api/profile',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {
        'token': token,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? firstName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.firstName''',
      ));
  String? patronymic(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.patronymic''',
      ));
  String? lastName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.lastName''',
      ));
  bool? isEmailVerified(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.isEmailVerified''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  String? bornOn(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.bornOn''',
      ));
  String? gender(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.gender''',
      ));
  String? formattedPhone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.formattedPhone''',
      ));
  String? legalEntityNumber(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.legalEntity.number''',
      ));
  String? avatarBlobId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.avatarBlobId''',
      ));
  int? userID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.userId''',
      ));
  String? phonesmain(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.phones.main.number''',
      ));
}

class DriverCompleteCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = MUSTProDriveGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'driver complete',
      apiUrl: '$baseUrl/api/profile/driver/complete',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {
        'token': token,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  bool? onBoarding(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.onBoarding''',
      ));
  bool? registration(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.registration''',
      ));
  bool? noBot(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.noBot''',
      ));
  bool? experience(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.experience''',
      ));
  bool? dreamJob(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.dreamJob''',
      ));
  bool? employmentStatus(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.employmentStatus''',
      ));
  bool? myVehicle(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.myVehicle''',
      ));
  bool? myFleet(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.myFleet''',
      ));
}

class NormalizedHumanDataCall {
  Future<ApiCallResponse> call({
    String? userCrossSystemId = '',
    String? token = '',
  }) async {
    final baseUrl = MUSTProDriveGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'NormalizedHumanData',
      apiUrl: '$baseUrl/api/normalized-human-data/$userCrossSystemId',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {
        'userCrossSystemId': userCrossSystemId,
        'token': token,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? seriesAndNumber(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.driverData.driverLicenses.RU.seriesAndNumber''',
      ));
}

/// End MUSTProDrive Group Code

/// Start GPSsystemAPI Group Code

class GPSsystemAPIGroup {
  static String getBaseUrl() => 'https://api.must.io/api';
  static Map<String, String> headers = {};
  static LoginCall loginCall = LoginCall();
  static ProfileCall profileCall = ProfileCall();
}

class LoginCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = GPSsystemAPIGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
"systemName": "ProDriveTrackerApp",
  "password": "jS\`2@dc~Nn3~Y3e",
  "daysTimeout": 1
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: '$baseUrl/systems/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? tokenSystem(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.token''',
      ));
}

class ProfileCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
  }) async {
    final baseUrl = GPSsystemAPIGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Profile',
      apiUrl: '$baseUrl/profile',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $userToken',
        'accept': 'application/json',
      },
      params: {
        'userToken': userToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End GPSsystemAPI Group Code

/// Start MustGamesAPI Group Code

class MustGamesAPIGroup {
  static String getBaseUrl() => 'https://must-games.back.must.io/api/tracker';
  static Map<String, String> headers = {};
  static LocationUserPuttCall locationUserPuttCall = LocationUserPuttCall();
  static TraksAllMonthCall traksAllMonthCall = TraksAllMonthCall();
  static TraksByMonthDataCall traksByMonthDataCall = TraksByMonthDataCall();
  static TraksByDayCall traksByDayCall = TraksByDayCall();
}

class LocationUserPuttCall {
  Future<ApiCallResponse> call({
    String? systemToken = '',
  }) async {
    final baseUrl = MustGamesAPIGroup.getBaseUrl();

    const ffApiRequestBody = '''
''';
    return ApiManager.instance.makeApiCall(
      callName: 'locationUserPutt',
      apiUrl: '$baseUrl/gps-data',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $systemToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TraksAllMonthCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
    int? offset = 0,
    int? limit = 10,
  }) async {
    final baseUrl = MustGamesAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "offset": $offset,
  "limit": $limit
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'traksAllMonth',
      apiUrl: '$baseUrl/tracks',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $userToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  double? totalReward(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.total.reward''',
      ));
  double? totalDistance(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.total.distance''',
      ));
  double? totalAverageSpeed(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.total.averageSpeed''',
      ));
  dynamic monthlyJSON(dynamic response) => getJsonField(
        response,
        r'''$.monthly''',
      );
}

class TraksByMonthDataCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
    String? isoMonth = '',
    int? offset = 0,
    int? limit = 10,
  }) async {
    final baseUrl = MustGamesAPIGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "isoMonth": "${escapeStringForJson(isoMonth)}",
  "offset": $offset,
  "limit": $limit
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'TraksByMonthData',
      apiUrl: '$baseUrl/tracks/by-month',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $userToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic daily(dynamic response) => getJsonField(
        response,
        r'''$.daily''',
      );
}

class TraksByDayCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
    String? isoDate = '',
    int? offset = 0,
    int? limit = 10,
  }) async {
    final baseUrl = MustGamesAPIGroup.getBaseUrl();

    const ffApiRequestBody = '''
{
  "isoDate": "2024-12-12",
  "offset": 0,
  "limit": 10
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'traksByDay',
      apiUrl: '$baseUrl/tracks/by-day',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $userToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End MustGamesAPI Group Code

class TesttttCall {
  static Future<ApiCallResponse> call({
    int? userID,
  }) async {
    final ffApiRequestBody = '''
{
  "userId": $userID,
  "requestType": "default"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'testttt',
      apiUrl: 'https://must-games.back.must.io/api/tracker/gps-data/pojection',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IlByb0RyaXZlVHJhY2tlckFwcCIsInJvbGUiOiJTeXN0ZW0iLCJuYmYiOjE3MzY5NTEyNTIsImV4cCI6MTczNzAzNzY1MiwiaWF0IjoxNzM2OTUxMjUyfQ.UsnoAnaeR12RYDTHVt2UVQgDfqIyQy8trKJFOEBjVmw',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
