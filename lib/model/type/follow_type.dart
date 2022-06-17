import 'package:json_annotation/json_annotation.dart';

enum FollowType {
  @JsonValue('FOLLOWING') FOLLOWING,
  @JsonValue('FOLLOWER') FOLLOWER
}