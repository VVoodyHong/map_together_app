// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(Map<String, dynamic> json) =>
    ApiResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String,
      code: json['code'] as int,
      data: ApiResponse._fromGenericJson(json['data'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$ApiResponseToJson<T>(ApiResponse<T> instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'data': ApiResponse._toGenericJson(instance.data),
    };
