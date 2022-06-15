import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/page/request_page.dart';

part 'place_search.g.dart';

@JsonSerializable()
class PlaceSearch {
  String keyword;
  String address;
  RequestPage requestPage;
  
  PlaceSearch({
    required this.keyword,
    required this.address,
    required this.requestPage
  });

  factory PlaceSearch.fromJson(Map<String, dynamic> json) => _$PlaceSearchFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceSearchToJson(this);
}