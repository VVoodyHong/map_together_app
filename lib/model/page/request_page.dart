import 'package:json_annotation/json_annotation.dart';

part 'request_page.g.dart';

@JsonSerializable()
class RequestPage {
  int page;
  int size;

  RequestPage ({
    required this.page,
    required this.size
  });

  factory RequestPage.fromJson(Map<String, dynamic> json) => _$RequestPageFromJson(json);
  Map<String, dynamic> toJson() => _$RequestPageToJson(this);
}