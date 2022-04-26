// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreate _$UserCreateFromJson(Map<String, dynamic> json) => UserCreate(
      loginId: json['loginId'] as String,
      nickname: json['nickname'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserCreateToJson(UserCreate instance) =>
    <String, dynamic>{
      'loginId': instance.loginId,
      'nickname': instance.nickname,
      'password': instance.password,
    };
