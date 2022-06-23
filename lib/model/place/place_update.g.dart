// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceUpdate _$PlaceUpdateFromJson(Map<String, dynamic> json) => PlaceUpdate(
      idx: json['idx'] as int,
      categoryIdx: json['categoryIdx'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      addTags: (json['addTags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      deleteTags: (json['deleteTags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      deleteFiles: (json['deleteFiles'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      favorite: (json['favorite'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaceUpdateToJson(PlaceUpdate instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'categoryIdx': instance.categoryIdx,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'addTags': instance.addTags,
      'deleteTags': instance.deleteTags,
      'deleteFiles': instance.deleteFiles,
      'favorite': instance.favorite,
      'lat': instance.lat,
      'lng': instance.lng,
    };
