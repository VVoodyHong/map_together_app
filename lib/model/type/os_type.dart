import 'package:json_annotation/json_annotation.dart';

enum OsType {
  @JsonValue('ANDROID') ANDROID,
  @JsonValue('IOS') IOS,
  @JsonValue('WINDOW') WINDOW,
  @JsonValue('MACOS') MACOS
}