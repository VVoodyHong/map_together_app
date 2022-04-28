import 'package:json_annotation/json_annotation.dart';

enum LoginType{
  @JsonValue('DEFAULT') DEFAULT,
  @JsonValue('KAKAO') KAKAO,
  @JsonValue('NAVER') NAVER
}