import 'package:json_annotation/json_annotation.dart';

part 'follow_simple.g.dart';

@JsonSerializable()
class FollowSimple {
  int idx;
  String? name;
  String nickname;
  String profileImg;
  
  FollowSimple({
    required this.idx,
    this.name,
    required this.nickname,
    required this.profileImg,
  });

  factory FollowSimple.fromJson(Map<String, dynamic> json) => _$FollowSimpleFromJson(json);
  Map<String, dynamic> toJson() => _$FollowSimpleToJson(this);
}