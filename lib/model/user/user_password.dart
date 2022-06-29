import 'package:json_annotation/json_annotation.dart';

part 'user_password.g.dart';

@JsonSerializable()
class UserPassword {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  
  UserPassword({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword
  });

  factory UserPassword.fromJson(Map<String, dynamic> json) => _$UserPasswordFromJson(json);
  Map<String, dynamic> toJson() => _$UserPasswordToJson(this);
}