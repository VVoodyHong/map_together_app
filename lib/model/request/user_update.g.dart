// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdate _$UserUpdateFromJson(Map<String, dynamic> json) => UserUpdate(
      nickname: json['nickname'] as String?,
      name: json['name'] as String?,
      profileImg: json['profileImg'] as String?,
      introduce: json['introduce'] as String?
    );

Map<String, dynamic> _$UserUpdateToJson(UserUpdate instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'name': instance.name,
      'profileImg': instance.profileImg,
      'introduce': instance.introduce
    };
