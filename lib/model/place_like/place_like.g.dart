// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceLike _$PlaceLikeFromJson(Map<String, dynamic> json) => PlaceLike(
      idx: json['idx'] as int?,
      userIdx: json['userIdx'] as int?,
      placeIdx: json['placeIdx'] as int?,
      like: json['like'] as bool,
      totalLike: json['totalLike'] as int,
    );

Map<String, dynamic> _$PlaceLikeToJson(PlaceLike instance) => <String, dynamic>{
      'idx': instance.idx,
      'userIdx': instance.userIdx,
      'placeIdx': instance.placeIdx,
      'like': instance.like,
      'totalLike': instance.totalLike,
    };
