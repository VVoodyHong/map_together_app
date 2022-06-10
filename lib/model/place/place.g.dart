// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      idx: json['idx'] as int,
      category:
          PlaceCategory.fromJson(json['category'] as Map<String, dynamic>),
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      favorite: (json['favorite'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'idx': instance.idx,
      'category': instance.category,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'favorite': instance.favorite,
      'lat': instance.lat,
      'lng': instance.lng,
    };
