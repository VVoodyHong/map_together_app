import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/model/user/user.dart';

part 'place_category.g.dart';

@JsonSerializable()
class PlaceCategory {
  int idx;
  User? user;
  String name;
  PlaceCategoryType type;
  
  PlaceCategory({
    required this.idx,
    this.user,
    required this.name,
    required this.type
  });

  factory PlaceCategory.fromJson(Map<String, dynamic> json) => _$PlaceCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceCategoryToJson(this);
}