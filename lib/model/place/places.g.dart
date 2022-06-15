// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Places _$PlacesFromJson(Map<String, dynamic> json) => Places(
      list: (json['list'] as List<dynamic>)
          .map((e) => PlaceSimple.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$PlacesToJson(Places instance) => <String, dynamic>{
      'list': instance.list,
      'totalCount': instance.totalCount,
      'last': instance.last,
    };
