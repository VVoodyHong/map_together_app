import 'package:json_annotation/json_annotation.dart';

enum PlaceCategoryType{
  @JsonValue('AIRPLANE') AIRPLANE,
  @JsonValue('BEER') BEER,
  @JsonValue('COFFEE') COFFEE,
  @JsonValue('DESSERT') DESSERT,
  @JsonValue('HEART') HEART,
  @JsonValue('MARKER') MARKER,
  @JsonValue('RICE') RICE,
  @JsonValue('SPORTS') SPORTS,
  @JsonValue('STAR') STAR,
  NONE
}

extension ParseToString on PlaceCategoryType {
  String getValue() {
    return toString().split('.').last;
  }
}