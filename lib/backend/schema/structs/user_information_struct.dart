// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserInformationStruct extends BaseStruct {
  UserInformationStruct({
    String? firstName,
    String? lastName,
    String? patronymic,
    String? email,
    DateTime? bornOn,
    String? mainPhone,
    String? legalEntityNumber,
    String? phoneFormatted,
    String? avatarBlobId,
    String? userID,
  })  : _firstName = firstName,
        _lastName = lastName,
        _patronymic = patronymic,
        _email = email,
        _bornOn = bornOn,
        _mainPhone = mainPhone,
        _legalEntityNumber = legalEntityNumber,
        _phoneFormatted = phoneFormatted,
        _avatarBlobId = avatarBlobId,
        _userID = userID;

  // "FirstName" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) => _firstName = val;

  bool hasFirstName() => _firstName != null;

  // "LastName" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) => _lastName = val;

  bool hasLastName() => _lastName != null;

  // "patronymic" field.
  String? _patronymic;
  String get patronymic => _patronymic ?? '';
  set patronymic(String? val) => _patronymic = val;

  bool hasPatronymic() => _patronymic != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "bornOn" field.
  DateTime? _bornOn;
  DateTime? get bornOn => _bornOn;
  set bornOn(DateTime? val) => _bornOn = val;

  bool hasBornOn() => _bornOn != null;

  // "mainPhone" field.
  String? _mainPhone;
  String get mainPhone => _mainPhone ?? '';
  set mainPhone(String? val) => _mainPhone = val;

  bool hasMainPhone() => _mainPhone != null;

  // "legalEntityNumber" field.
  String? _legalEntityNumber;
  String get legalEntityNumber => _legalEntityNumber ?? '';
  set legalEntityNumber(String? val) => _legalEntityNumber = val;

  bool hasLegalEntityNumber() => _legalEntityNumber != null;

  // "phoneFormatted" field.
  String? _phoneFormatted;
  String get phoneFormatted => _phoneFormatted ?? '';
  set phoneFormatted(String? val) => _phoneFormatted = val;

  bool hasPhoneFormatted() => _phoneFormatted != null;

  // "avatarBlobId" field.
  String? _avatarBlobId;
  String get avatarBlobId => _avatarBlobId ?? '';
  set avatarBlobId(String? val) => _avatarBlobId = val;

  bool hasAvatarBlobId() => _avatarBlobId != null;

  // "userID" field.
  String? _userID;
  String get userID => _userID ?? '';
  set userID(String? val) => _userID = val;

  bool hasUserID() => _userID != null;

  static UserInformationStruct fromMap(Map<String, dynamic> data) =>
      UserInformationStruct(
        firstName: data['FirstName'] as String?,
        lastName: data['LastName'] as String?,
        patronymic: data['patronymic'] as String?,
        email: data['email'] as String?,
        bornOn: data['bornOn'] as DateTime?,
        mainPhone: data['mainPhone'] as String?,
        legalEntityNumber: data['legalEntityNumber'] as String?,
        phoneFormatted: data['phoneFormatted'] as String?,
        avatarBlobId: data['avatarBlobId'] as String?,
        userID: data['userID'] as String?,
      );

  static UserInformationStruct? maybeFromMap(dynamic data) => data is Map
      ? UserInformationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'FirstName': _firstName,
        'LastName': _lastName,
        'patronymic': _patronymic,
        'email': _email,
        'bornOn': _bornOn,
        'mainPhone': _mainPhone,
        'legalEntityNumber': _legalEntityNumber,
        'phoneFormatted': _phoneFormatted,
        'avatarBlobId': _avatarBlobId,
        'userID': _userID,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'FirstName': serializeParam(
          _firstName,
          ParamType.String,
        ),
        'LastName': serializeParam(
          _lastName,
          ParamType.String,
        ),
        'patronymic': serializeParam(
          _patronymic,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'bornOn': serializeParam(
          _bornOn,
          ParamType.DateTime,
        ),
        'mainPhone': serializeParam(
          _mainPhone,
          ParamType.String,
        ),
        'legalEntityNumber': serializeParam(
          _legalEntityNumber,
          ParamType.String,
        ),
        'phoneFormatted': serializeParam(
          _phoneFormatted,
          ParamType.String,
        ),
        'avatarBlobId': serializeParam(
          _avatarBlobId,
          ParamType.String,
        ),
        'userID': serializeParam(
          _userID,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserInformationStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserInformationStruct(
        firstName: deserializeParam(
          data['FirstName'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['LastName'],
          ParamType.String,
          false,
        ),
        patronymic: deserializeParam(
          data['patronymic'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        bornOn: deserializeParam(
          data['bornOn'],
          ParamType.DateTime,
          false,
        ),
        mainPhone: deserializeParam(
          data['mainPhone'],
          ParamType.String,
          false,
        ),
        legalEntityNumber: deserializeParam(
          data['legalEntityNumber'],
          ParamType.String,
          false,
        ),
        phoneFormatted: deserializeParam(
          data['phoneFormatted'],
          ParamType.String,
          false,
        ),
        avatarBlobId: deserializeParam(
          data['avatarBlobId'],
          ParamType.String,
          false,
        ),
        userID: deserializeParam(
          data['userID'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserInformationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserInformationStruct &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        patronymic == other.patronymic &&
        email == other.email &&
        bornOn == other.bornOn &&
        mainPhone == other.mainPhone &&
        legalEntityNumber == other.legalEntityNumber &&
        phoneFormatted == other.phoneFormatted &&
        avatarBlobId == other.avatarBlobId &&
        userID == other.userID;
  }

  @override
  int get hashCode => const ListEquality().hash([
        firstName,
        lastName,
        patronymic,
        email,
        bornOn,
        mainPhone,
        legalEntityNumber,
        phoneFormatted,
        avatarBlobId,
        userID
      ]);
}

UserInformationStruct createUserInformationStruct({
  String? firstName,
  String? lastName,
  String? patronymic,
  String? email,
  DateTime? bornOn,
  String? mainPhone,
  String? legalEntityNumber,
  String? phoneFormatted,
  String? avatarBlobId,
  String? userID,
}) =>
    UserInformationStruct(
      firstName: firstName,
      lastName: lastName,
      patronymic: patronymic,
      email: email,
      bornOn: bornOn,
      mainPhone: mainPhone,
      legalEntityNumber: legalEntityNumber,
      phoneFormatted: phoneFormatted,
      avatarBlobId: avatarBlobId,
      userID: userID,
    );
