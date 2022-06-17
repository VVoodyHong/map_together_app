import 'package:json_annotation/json_annotation.dart';

part 'follow_state.g.dart';

@JsonSerializable()
class FollowState {
  bool follow;
  
  FollowState({
    required this.follow,
  });

  factory FollowState.fromJson(Map<String, dynamic> json) => _$FollowStateFromJson(json);
  Map<String, dynamic> toJson() => _$FollowStateToJson(this);
}