import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/auth/auth_email.dart';
import 'package:map_together/model/auth/jwt_authentication_response.dart';
import 'package:map_together/model/file/file.dart';
import 'package:map_together/model/file/files.dart';
import 'package:map_together/model/follow/follow_count.dart';
import 'package:map_together/model/follow/follow_simple.dart';
import 'package:map_together/model/follow/follow_state.dart';
import 'package:map_together/model/follow/follows.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/place/place_simple.dart';
import 'package:map_together/model/place/places.dart';
import 'package:map_together/model/place_category/place_categories.dart';
import 'package:map_together/model/place_category/place_category.dart';
import 'package:map_together/model/place_like/place_like.dart';
import 'package:map_together/model/place_reply/place_replies.dart';
import 'package:map_together/model/place_reply/place_reply.dart';
import 'package:map_together/model/place_reply/place_reply_simple.dart';
import 'package:map_together/model/tag/tag.dart';
import 'package:map_together/model/tag/tags.dart';
import 'package:map_together/model/user/user.dart';
import 'package:map_together/model/user/user_simple.dart';
import 'package:map_together/model/user/users.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> {
  bool success;
  String message;
  int code;
  @JsonKey(fromJson: _fromGenericJson, toJson: _toGenericJson)
  T? data;

  ApiResponse(
    {
      required this.success,
      required this.message,
      required this.code,
      this.data
    }
  );

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  static T? _fromGenericJson<T>(Map<String, dynamic>? json) {
    if(json == null) return null;
    if (T == JwtAuthenticationResponse) {
      return JwtAuthenticationResponse.fromJson(json) as T;
    } else if(T == User) {
      return User.fromJson(json) as T;
    } else if (T == Place) {
      return Place.fromJson(json) as T;
    } else if(T == PlaceCategory) {
      return PlaceCategory.fromJson(json) as T;
    } else if(T == PlaceCategories) {
      return PlaceCategories.fromJson(json) as T;
    } else if(T == File) {
      return File.fromJson(json) as T;
    } else if(T == Files) {
      return Files.fromJson(json) as T;
    } else if(T == Tag) {
      return Tag.fromJson(json) as T;
    } else if(T == Tags) {
      return Tags.fromJson(json) as T;
    } else if(T == PlaceReply) {
      return PlaceReply.fromJson(json) as T;
    } else if(T == PlaceReplies) {
      return PlaceReplies.fromJson(json) as T;
    } else if(T == PlaceReplySimple) {
      return PlaceReplySimple.fromJson(json) as T;
    } else if(T == PlaceLike) {
      return PlaceLike.fromJson(json) as T;
    } else if(T == UserSimple) {
      return UserSimple.fromJson(json) as T;
    } else if(T == Users) {
      return Users.fromJson(json) as T;
    } else if(T == PlaceSimple) {
      return PlaceSimple.fromJson(json) as T;
    } else if(T == Places) {
      return Places.fromJson(json) as T;
    } else if(T == FollowCount) {
      return FollowCount.fromJson(json) as T;
    } else if(T == FollowState) {
      return FollowState.fromJson(json) as T;
    } else if(T == FollowSimple) {
      return FollowSimple.fromJson(json) as T;
    } else if(T == Follows) {
      return Follows.fromJson(json) as T;
    } else if(T == AuthEmail) {
      return AuthEmail.fromJson(json) as T;
    } else {
      return null;
    }
  }

  static Map<String, dynamic>? _toGenericJson<T>(T value) {
    return null;
  }
}