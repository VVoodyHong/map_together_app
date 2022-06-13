// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSearch _$UserSearchFromJson(Map<String, dynamic> json) => UserSearch(
      keyword: json['keyword'] as String,
      requestPage:
          RequestPage.fromJson(json['requestPage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserSearchToJson(UserSearch instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'requestPage': instance.requestPage,
    };
