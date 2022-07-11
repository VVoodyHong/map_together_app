// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthEmail _$AuthEmailFromJson(Map<String, dynamic> json) => AuthEmail(
      email: json['email'] as String,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$AuthEmailToJson(AuthEmail instance) => <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };
