import 'package:json_annotation/json_annotation.dart';

part 'user_update.g.dart';

@JsonSerializable()
class UserUpdate {
  final String? nickname;
  final String? name;
  final String? profileImg;
  final String? introduce;
  final double? lat;
  final double? lng;
  final double? zoom;
  
  UserUpdate({
    this.nickname,
    this.name,
    this.profileImg,
    this.introduce,
    this.lat,
    this.lng,
    this.zoom
  });

  factory UserUpdate.fromJson(Map<String, dynamic> json) => _$UserUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateToJson(this);
}