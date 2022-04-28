import 'package:json_annotation/json_annotation.dart';

enum UserType{
  @JsonValue('USER') USER,
  @JsonValue('ADMIN') ADMIN
}