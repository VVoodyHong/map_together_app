import 'package:json_annotation/json_annotation.dart';

part 'db_jwt.g.dart';

@JsonSerializable()
class DBJwt {
  String accessToken;
  String refreshToken;

  DBJwt({
    required this.accessToken,
    required this.refreshToken,
  });

  factory DBJwt.fromJson(Map<String, dynamic> json) => _$DBJwtFromJson(json);
  Map<String, dynamic> toJson() => _$DBJwtToJson(this);
}