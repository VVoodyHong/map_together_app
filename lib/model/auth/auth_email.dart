import 'package:json_annotation/json_annotation.dart';

part 'auth_email.g.dart';

@JsonSerializable()
class AuthEmail {
  String email;
  String? code;
  
  AuthEmail({
    required this.email,
    this.code,
  });

  factory AuthEmail.fromJson(Map<String, dynamic> json) => _$AuthEmailFromJson(json);
  Map<String, dynamic> toJson() => _$AuthEmailToJson(this);
}