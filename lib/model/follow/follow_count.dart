import 'package:json_annotation/json_annotation.dart';

part 'follow_count.g.dart';

@JsonSerializable()
class FollowCount {
  int following;
  int follower;
  
  FollowCount({
    required this.following,
    required this.follower,
  });

  factory FollowCount.fromJson(Map<String, dynamic> json) => _$FollowCountFromJson(json);
  Map<String, dynamic> toJson() => _$FollowCountToJson(this);
}