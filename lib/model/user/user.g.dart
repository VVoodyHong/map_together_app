// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      idx: json['idx'] as int?,
      loginId: json['loginId'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      profileImg: json['profileImg'] as String?,
      introduce: json['introduce'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'idx': instance.idx,
      'loginId': instance.loginId,
      'name': instance.name,
      'nickname': instance.nickname,
      'profileImg': instance.profileImg,
      'introduce': instance.introduce,
    };
