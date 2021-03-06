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
      places: (json['places'] as List<dynamic>?)
          ?.map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList(),
      loginType: $enumDecodeNullable(_$LoginTypeEnumMap, json['loginType']),
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      zoom: (json['zoom'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'idx': instance.idx,
      'loginId': instance.loginId,
      'name': instance.name,
      'nickname': instance.nickname,
      'profileImg': instance.profileImg,
      'introduce': instance.introduce,
      'places': instance.places,
      'loginType': _$LoginTypeEnumMap[instance.loginType],
      'lat': instance.lat,
      'lng': instance.lng,
      'zoom': instance.zoom,
    };

const _$LoginTypeEnumMap = {
  LoginType.DEFAULT: 'DEFAULT',
  LoginType.KAKAO: 'KAKAO',
  LoginType.NAVER: 'NAVER',
};
