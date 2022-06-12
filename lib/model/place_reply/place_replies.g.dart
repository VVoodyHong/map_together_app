// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_replies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceReplies _$PlaceRepliesFromJson(Map<String, dynamic> json) => PlaceReplies(
      list: (json['list'] as List<dynamic>)
          .map((e) => PlaceReplySimple.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$PlaceRepliesToJson(PlaceReplies instance) =>
    <String, dynamic>{
      'list': instance.list,
      'totalCount': instance.totalCount,
      'last': instance.last,
    };
