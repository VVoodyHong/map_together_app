// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowSearch _$FollowSearchFromJson(Map<String, dynamic> json) => FollowSearch(
      keyword: json['keyword'] as String,
      requestPage:
          RequestPage.fromJson(json['requestPage'] as Map<String, dynamic>),
      followType: $enumDecode(_$FollowTypeEnumMap, json['followType']),
      userIdx: json['userIdx'] as int,
    );

Map<String, dynamic> _$FollowSearchToJson(FollowSearch instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'requestPage': instance.requestPage,
      'followType': _$FollowTypeEnumMap[instance.followType],
      'userIdx': instance.userIdx,
    };

const _$FollowTypeEnumMap = {
  FollowType.FOLLOWING: 'FOLLOWING',
  FollowType.FOLLOWER: 'FOLLOWER',
};
