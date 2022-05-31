import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:map_together/auth/secrets.dart';
import 'package:map_together/model/api_response.dart';
import 'package:map_together/model/jwt_authentication_response.dart';
import 'package:map_together/model/request/login.dart';
import 'package:map_together/model/request/user_create.dart';
import 'package:map_together/model/request/user_update.dart';
import 'package:map_together/model/type/exist_type.dart';
import 'package:map_together/model/user.dart';
import 'package:map_together/rest/api_keys.dart';
import 'package:map_together/utils/utils.dart';

class API extends getx.GetxController{
  static API get to => getx.Get.find();

  String token = '';

  late Dio dio;

  BaseOptions options = BaseOptions(
    baseUrl: SCHEME + APP_SERVER_URL,
    connectTimeout: 5000,
    receiveTimeout: 5000,
    validateStatus: (status) {
      return true;
    }
  );

  @override
  void onInit() async {
    dio = Dio(options);
    super.onInit();
  }

  /*
  naver map api
  */

  // https://api.ncloud-docs.com/docs/ai-naver-mapsreversegeocoding-gc
  Future<dynamic> reverseGeocoding(lon ,lat) async {
    Map<String, String> headers = {
      "X-NCP-APIGW-API-KEY-ID": SdkKeys.naverClientId,
      "X-NCP-APIGW-API-KEY": SdkKeys.naverClientSecret
    };
    Response response = await dio.get(
      'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=$lon,$lat&sourcecrs=epsg:4326&orders=addr&output=json', options: Options(
        headers: headers
      ),
    );
    return response.data;
  }

  /*
  kakao login api
  */

  Future<Response<dynamic>> getKakaoAccount(String? kakaoToken) async {
    Map<String, String> headers = {'Authorization': 'Bearer $kakaoToken'};
    Response response = await dio.get(
      URL_KAKAO_USER_ME,
      options: Options(
        headers: headers,
      ),
    );
    return response;
  }

  /*
  auth
  */

  Future<ApiResponse<JwtAuthenticationResponse>> signIn(Login req) async {
    Response response = await dio.post(
      dio.options.baseUrl + PATH_LOGIN,
      data: req.toJson(),
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<JwtAuthenticationResponse>.fromJson(response.data);
  }

  Future<ApiResponse<void>> signUp(UserCreate req) async {
    Response response = await dio.post(
      dio.options.baseUrl + PATH_SIGN_UP,
      data: req.toJson(),
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<void>.fromJson(response.data);
  }

  Future<ApiResponse<JwtAuthenticationResponse>> getNewAccessToken(String refreshToken) async {
    Response response =  await dio.get(
      dio.options.baseUrl + PATH_ACCESSTOKEN,
      options: Options(
        headers: {'authorization': 'Bearer $token'}
      ),
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<JwtAuthenticationResponse>.fromJson(response.data);
  }

  Future<ApiResponse<JwtAuthenticationResponse>> refreshJwt() async {
    Response response =  await dio.get(
      dio.options.baseUrl + PATH_REFRESH_JWT,
      options: Options(
        headers: {'authorization': 'Bearer $token'}
      ),
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<JwtAuthenticationResponse>.fromJson(response.data);
  }

  /*
  user
  */

  Future<ApiResponse<User>> getUser() async {
    Response response = await dio.get(
      dio.options.baseUrl + PATH_USER,
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<User>.fromJson(response.data);
  }

  Future<ApiResponse<User>> updateUser(UserUpdate req, File? file) async {
    Map<String, dynamic> json = req.toJson();
    if(file != null) {
      json['file'] = await MultipartFile.fromFile(file.path);
    }
    FormData formData = FormData.fromMap(json);
    Response response = await dio.post(
      dio.options.baseUrl + PATH_USER,
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
      data: formData
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<User>.fromJson(response.data);
  }

  Future<ApiResponse<void>> checkExistUser(String value, ExistType type) async {
    Response response =  await dio.get(
      dio.options.baseUrl + PATH_USER_EXIST + '?value=$value&type=${type.getValue()}'
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<void>.fromJson(response.data);
  }
}