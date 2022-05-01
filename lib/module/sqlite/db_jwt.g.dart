// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_jwt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DBJwt _$DBJwtFromJson(Map<String, dynamic> json) => DBJwt(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$DBJwtToJson(DBJwt instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
