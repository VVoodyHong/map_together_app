import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class JwtAuthenticationResponse {
  String tokenType;
  String accessToken;
  String? refreshToken;

  JwtAuthenticationResponse(
    {
      required this.tokenType,
      required this.accessToken,
      this.refreshToken
    }
  );

  factory JwtAuthenticationResponse.fromJson(Map<String, dynamic> json){
    return JwtAuthenticationResponse(
      tokenType: json['tokenType'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
      'tokenType': tokenType,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
}