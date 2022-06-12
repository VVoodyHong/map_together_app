// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceReply _$PlaceReplyFromJson(Map<String, dynamic> json) => PlaceReply(
      idx: json['idx'] as int,
      reply: json['reply'] as String,
      place: Place.fromJson(json['place'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
    );

Map<String, dynamic> _$PlaceReplyToJson(PlaceReply instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'reply': instance.reply,
      'place': instance.place,
      'user': instance.user,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
    };
