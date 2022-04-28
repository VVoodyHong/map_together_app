// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      loginId: json['loginId'] as String?,
      password: json['password'] as String?,
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']),
      loginType: $enumDecodeNullable(_$LoginTypeEnumMap, json['loginType']),
      osType: $enumDecodeNullable(_$OsTypeEnumMap, json['osType']),
      appVersion: json['appVersion'] as String?,
      osVersion: json['osVersion'] as int?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'loginId': instance.loginId,
      'password': instance.password,
      'userType': _$UserTypeEnumMap[instance.userType],
      'loginType': _$LoginTypeEnumMap[instance.loginType],
      'osType': _$OsTypeEnumMap[instance.osType],
      'appVersion': instance.appVersion,
      'osVersion': instance.osVersion,
      'deviceId': instance.deviceId,
    };

const _$UserTypeEnumMap = {
  UserType.USER: 'USER',
  UserType.ADMIN: 'ADMIN',
};

const _$LoginTypeEnumMap = {
  LoginType.DEFAULT: 'DEFAULT',
  LoginType.KAKAO: 'KAKAO',
  LoginType.NAVER: 'NAVER',
};

const _$OsTypeEnumMap = {
  OsType.ANDROID: 'ANDROID',
  OsType.IOS: 'IOS',
  OsType.WINDOW: 'WINDOW',
  OsType.MACOS: 'MACOS',
};
