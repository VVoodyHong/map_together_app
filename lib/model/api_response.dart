import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/jwt_authentication_response.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> extends Response{
  bool success;
  String message;
  int code;
  @JsonKey(fromJson: _fromGenericJson, toJson: _toGenericJson)
  T? data;

  ApiResponse(
    {
      required this.success,
      required this.message,
      required this.code,
      this.data
    }
  );

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  static T? _fromGenericJson<T>(Map<String, dynamic> json) {
    if (T == JwtAuthenticationResponse) {
      return JwtAuthenticationResponse.fromJson(json) as T;
    }else {
      return null;
    }
  }

  static Map<String, dynamic>? _toGenericJson<T>(T value) {
    return null;
  }
}