// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_reply_simple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceReplySimple _$PlaceReplySimpleFromJson(Map<String, dynamic> json) =>
    PlaceReplySimple(
      idx: json['idx'] as int,
      reply: json['reply'] as String,
      userIdx: json['userIdx'] as int,
      userNickname: json['userNickname'] as String,
      userProfileImg: json['userProfileImg'] as String?,
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
    );

Map<String, dynamic> _$PlaceReplySimpleToJson(PlaceReplySimple instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'reply': instance.reply,
      'userIdx': instance.userIdx,
      'userNickname': instance.userNickname,
      'userProfileImg': instance.userProfileImg,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
    };
