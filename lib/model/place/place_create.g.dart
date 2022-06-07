// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceCreate _$PlaceCreateFromJson(Map<String, dynamic> json) => PlaceCreate(
      categoryIdx: json['categoryIdx'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      desc: json['desc'] as String?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      favorite: (json['favorite'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaceCreateToJson(PlaceCreate instance) =>
    <String, dynamic>{
      'categoryIdx': instance.categoryIdx,
      'name': instance.name,
      'address': instance.address,
      'desc': instance.desc,
      'tags': instance.tags,
      'favorite': instance.favorite,
      'lat': instance.lat,
      'lng': instance.lng,
    };
