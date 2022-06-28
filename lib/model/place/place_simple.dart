import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/type/place_category_type.dart';

part 'place_simple.g.dart';

@JsonSerializable()
class PlaceSimple {
  int idx;
  int userIdx;
  String userNickname;
  String? userProfileImg;
  int placeCategoryIdx;
  String placeCategoryName;
  PlaceCategoryType placeCategoryType;
  String? description;
  String name;
  String address;
  double favorite;
  double lat;
  double lng;
  String? representImg;
  int? likeCount;
  int? replyCount;
  DateTime createAt;
  DateTime updateAt;
  
  PlaceSimple({
    required this.idx,
    required this.userIdx,
    required this.userNickname,
    this.userProfileImg,
    required this.placeCategoryIdx,
    required this.placeCategoryName,
    required this.placeCategoryType,
    this.description,
    required this.name,
    required this.address,
    required this.favorite,
    required this.lat,
    required this.lng,
    this.representImg,
    this.likeCount,
    this.replyCount,
    required this.createAt,
    required this.updateAt,
  });

  factory PlaceSimple.fromJson(Map<String, dynamic> json) => _$PlaceSimpleFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceSimpleToJson(this);
}