// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follows.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follows _$FollowsFromJson(Map<String, dynamic> json) => Follows(
      list: (json['list'] as List<dynamic>)
          .map((e) => FollowSimple.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$FollowsToJson(Follows instance) => <String, dynamic>{
      'list': instance.list,
      'totalCount': instance.totalCount,
      'last': instance.last,
    };
