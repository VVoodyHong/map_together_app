// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_simple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceSimple _$PlaceSimpleFromJson(Map<String, dynamic> json) => PlaceSimple(
      idx: json['idx'] as int,
      userIdx: json['userIdx'] as int,
      userNickname: json['userNickname'] as String,
      userProfileImg: json['userProfileImg'] as String?,
      category:
          PlaceCategory.fromJson(json['category'] as Map<String, dynamic>),
      description: json['description'] as String?,
      name: json['name'] as String,
      address: json['address'] as String,
      favorite: (json['favorite'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      representImg: json['representImg'] as String?,
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
    );

Map<String, dynamic> _$PlaceSimpleToJson(PlaceSimple instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'userIdx': instance.userIdx,
      'userNickname': instance.userNickname,
      'userProfileImg': instance.userProfileImg,
      'category': instance.category,
      'description': instance.description,
      'name': instance.name,
      'address': instance.address,
      'favorite': instance.favorite,
      'lat': instance.lat,
      'lng': instance.lng,
      'representImg': instance.representImg,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
    };
