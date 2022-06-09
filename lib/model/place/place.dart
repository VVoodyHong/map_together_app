import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/place_category/place_category.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  int idx;
  // User user;
  PlaceCategory category;
  String name;
  String address;
  String? description;
  double favorite;
  double lat;
  double lng;
  
  Place({
    required this.idx,
    // required this.user,
    required this.category,
    required this.name,
    required this.address,
    this.description,
    required this.favorite,
    required this.lat,
    required this.lng
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}