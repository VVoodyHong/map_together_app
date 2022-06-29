import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/type/login_type.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? idx;
  final String? loginId;
  final String? name;
  final String? nickname;
  final String? profileImg;
  final String? introduce;
  final List<Place>? places;
  final LoginType? loginType;
  final double? lat;
  final double? lng;
  final double? zoom;
  
  User({
    this.idx,
    this.loginId,
    this.name,
    this.nickname,
    this.profileImg,
    this.introduce,
    this.places,
    this.loginType,
    this.lat,
    this.lng,
    this.zoom
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}