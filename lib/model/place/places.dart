import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/place/place_simple.dart';

part 'places.g.dart';

@JsonSerializable()
class Places {
  List<PlaceSimple> list;
  int totalCount;
  bool last;
  
  Places({
    required this.list,
    required this.totalCount,
    required this.last
  });

  factory Places.fromJson(Map<String, dynamic> json) => _$PlacesFromJson(json);
  Map<String, dynamic> toJson() => _$PlacesToJson(this);
}