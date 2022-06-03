import 'package:json_annotation/json_annotation.dart';

part 'user_create.g.dart';

@JsonSerializable()
class UserCreate {
  final String loginId;
  final String password;
  
  UserCreate({
    required this.loginId,
    required this.password
  });

  factory UserCreate.fromJson(Map<String, dynamic> json) => _$UserCreateFromJson(json);
  Map<String, dynamic> toJson() => _$UserCreateToJson(this);
}