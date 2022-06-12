// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_reply_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceReplyCreate _$PlaceReplyCreateFromJson(Map<String, dynamic> json) =>
    PlaceReplyCreate(
      reply: json['reply'] as String,
      placeIdx: json['placeIdx'] as int,
    );

Map<String, dynamic> _$PlaceReplyCreateToJson(PlaceReplyCreate instance) =>
    <String, dynamic>{
      'reply': instance.reply,
      'placeIdx': instance.placeIdx,
    };
