// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_simple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSimple _$UserSimpleFromJson(Map<String, dynamic> json) => UserSimple(
      idx: json['idx'] as int,
      nickname: json['nickname'] as String,
      name: json['name'] as String?,
      profileImg: json['profileImg'] as String?,
    );

Map<String, dynamic> _$UserSimpleToJson(UserSimple instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'nickname': instance.nickname,
      'name': instance.name,
      'profileImg': instance.profileImg,
    };
