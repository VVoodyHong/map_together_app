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
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaceCreateToJson(PlaceCreate instance) =>
    <String, dynamic>{
      'categoryIdx': instance.categoryIdx,
      'name': instance.name,
      'address': instance.address,
      'desc': instance.desc,
      'lat': instance.lat,
      'lng': instance.lng,
    };
