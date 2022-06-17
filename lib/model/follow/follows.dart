import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/follow/follow_simple.dart';

part 'follows.g.dart';

@JsonSerializable()
class Follows {
  List<FollowSimple> list;
  int totalCount;
  bool last;
  
  Follows({
    required this.list,
    required this.totalCount,
    required this.last
  });

  factory Follows.fromJson(Map<String, dynamic> json) => _$FollowsFromJson(json);
  Map<String, dynamic> toJson() => _$FollowsToJson(this);
}