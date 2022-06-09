import 'package:json_annotation/json_annotation.dart';

part 'place_create.g.dart';

@JsonSerializable()
class PlaceCreate {
  int categoryIdx;
  String name;
  String address;
  String? description;
  List<String> tags;
  double favorite;
  double lat;
  double lng;
  
  PlaceCreate({
    required this.categoryIdx,
    required this.name,
    required this.address,
    this.description,
    required this.tags,
    required this.favorite,
    required this.lat,
    required this.lng
  });

  factory PlaceCreate.fromJson(Map<String, dynamic> json) => _$PlaceCreateFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceCreateToJson(this);
}