import 'package:json_annotation/json_annotation.dart';

part 'user_simple.g.dart';

@JsonSerializable()
class UserSimple {
  int idx;
  String nickname;
  String? name;
  String? profileImg;
  
  UserSimple({
    required this.idx,
    required this.nickname,
    this.name,
    this.profileImg,
  });

  factory UserSimple.fromJson(Map<String, dynamic> json) => _$UserSimpleFromJson(json);
  Map<String, dynamic> toJson() => _$UserSimpleToJson(this);
}