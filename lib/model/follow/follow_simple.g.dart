// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_simple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowSimple _$FollowSimpleFromJson(Map<String, dynamic> json) => FollowSimple(
      idx: json['idx'] as int,
      name: json['name'] as String?,
      nickname: json['nickname'] as String,
      profileImg: json['profileImg'] as String,
    );

Map<String, dynamic> _$FollowSimpleToJson(FollowSimple instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'name': instance.name,
      'nickname': instance.nickname,
      'profileImg': instance.profileImg,
    };
