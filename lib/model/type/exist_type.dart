import 'package:json_annotation/json_annotation.dart';

enum ExistType{
  @JsonValue('LOGINID') LOGINID,
  @JsonValue('NICKNAME') NICKNAME
}

extension ParseToString on ExistType {
  String getValue() {
    return toString().split('.').last;
  }
}