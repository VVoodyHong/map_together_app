import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? idx;
  final String? loginId;
  final String? name;
  final String? nickname;
  final String? profileImg;
  final String? introduce;
  
  User({
    this.idx,
    this.loginId,
    this.name,
    this.nickname,
    this.profileImg,
    this.introduce,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}