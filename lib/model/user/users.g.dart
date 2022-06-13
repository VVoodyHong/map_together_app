// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      list: (json['list'] as List<dynamic>)
          .map((e) => UserSimple.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'list': instance.list,
      'totalCount': instance.totalCount,
      'last': instance.last,
    };
