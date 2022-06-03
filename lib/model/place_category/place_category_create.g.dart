// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_category_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceCategoryCreate _$PlaceCategoryCreateFromJson(Map<String, dynamic> json) =>
    PlaceCategoryCreate(
      name: json['name'] as String,
      type: $enumDecode(_$PlaceCategoryTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PlaceCategoryCreateToJson(
        PlaceCategoryCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$PlaceCategoryTypeEnumMap[instance.type],
    };

const _$PlaceCategoryTypeEnumMap = {
  PlaceCategoryType.AIRPLANE: 'AIRPLANE',
  PlaceCategoryType.BEER: 'BEER',
  PlaceCategoryType.COFFEE: 'COFFEE',
  PlaceCategoryType.DESSERT: 'DESSERT',
  PlaceCategoryType.HEART: 'HEART',
  PlaceCategoryType.MARKER: 'MARKER',
  PlaceCategoryType.RICE: 'RICE',
  PlaceCategoryType.SPORTS: 'SPORTS',
  PlaceCategoryType.STAR: 'STAR',
};
