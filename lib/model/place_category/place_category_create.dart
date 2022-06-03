import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/type/place_category_type.dart';

part 'place_category_create.g.dart';

@JsonSerializable()
class PlaceCategoryCreate {
  String name;
  PlaceCategoryType type;
  
  PlaceCategoryCreate({
    required this.name,
    required this.type
  });

  factory PlaceCategoryCreate.fromJson(Map<String, dynamic> json) => _$PlaceCategoryCreateFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceCategoryCreateToJson(this);
}