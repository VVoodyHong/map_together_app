// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceCategory _$PlaceCategoryFromJson(Map<String, dynamic> json) =>
    PlaceCategory(
      idx: json['idx'] as int,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      name: json['name'] as String,
      type: $enumDecode(_$PlaceCategoryTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$PlaceCategoryToJson(PlaceCategory instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'user': instance.user,
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
  PlaceCategoryType.NONE: 'NONE',
};
