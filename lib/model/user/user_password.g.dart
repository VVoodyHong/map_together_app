// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPassword _$UserPasswordFromJson(Map<String, dynamic> json) => UserPassword(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
      confirmNewPassword: json['confirmNewPassword'] as String,
    );

Map<String, dynamic> _$UserPasswordToJson(UserPassword instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
    };
