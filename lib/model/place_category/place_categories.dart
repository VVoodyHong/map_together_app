import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/place_category/place_category.dart';

part 'place_categories.g.dart';

@JsonSerializable()
class PlaceCategories {
  List<PlaceCategory> list;
  
  PlaceCategories({
    required this.list
  });

  factory PlaceCategories.fromJson(Map<String, dynamic> json) => _$PlaceCategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceCategoriesToJson(this);
}