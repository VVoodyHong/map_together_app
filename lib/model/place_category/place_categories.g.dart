// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceCategories _$PlaceCategoriesFromJson(Map<String, dynamic> json) =>
    PlaceCategories(
      list: (json['list'] as List<dynamic>)
          .map((e) => PlaceCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceCategoriesToJson(PlaceCategories instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
