import 'package:json_annotation/json_annotation.dart';

part 'place_like.g.dart';

@JsonSerializable()
class PlaceLike {
  int? idx;
  int? userIdx;
  int? placeIdx;
  bool like;
  int totalLike;
  
  PlaceLike({
    this.idx,
    this.userIdx,
    this.placeIdx,
    required this.like,
    required this.totalLike,
  });

  factory PlaceLike.fromJson(Map<String, dynamic> json) => _$PlaceLikeFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceLikeToJson(this);
}