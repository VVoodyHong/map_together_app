// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceSearch _$PlaceSearchFromJson(Map<String, dynamic> json) => PlaceSearch(
      keyword: json['keyword'] as String,
      address: json['address'] as String,
      requestPage:
          RequestPage.fromJson(json['requestPage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceSearchToJson(PlaceSearch instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'address': instance.address,
      'requestPage': instance.requestPage,
    };
