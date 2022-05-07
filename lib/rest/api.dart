import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:map_together/auth/secrets.dart';
import 'package:map_together/model/api_response.dart';
import 'package:map_together/model/jwt_authentication_response.dart';
import 'package:map_together/model/kakao_account.dart';
import 'package:map_together/model/request/login.dart';
import 'package:map_together/model/request/user_create.dart';
import 'package:map_together/model/user.dart';
import 'package:map_together/rest/api_keys.dart';

class API extends GetConnect {
  static API get to => Get.find();

  String token = '';

  @override
  void onInit() {
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = Duration(seconds: 5);
    httpClient.addResponseModifier((request, response) {
      print('rest result:: ${request.url} ${response.status.code}');
    });
    
    super.onInit();
  }

  /*
  naver map api
  */

  // https://api.ncloud-docs.com/docs/ai-naver-mapsreversegeocoding-gc
  Future<Response<dynamic>> reverseGeocoding(lon ,lat) async {
    Map<String, String> headers = {
      "X-NCP-APIGW-API-KEY-ID": SdkKeys.naverClientId,
      "X-NCP-APIGW-API-KEY": SdkKeys.naverClientSecret
    };
    httpClient.defaultDecoder = null;
    return await httpClient.get('https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=$lon,$lat&sourcecrs=epsg:4326&orders=addr&output=json', headers: headers);
  }

  /*
  kakao login api
  */

  Future<Response<KakaoAccount>> getKakaoAccount(String? kakaoToken) async {
    Map<String, String> headers = {'Authorization': 'Bearer $kakaoToken'};
    httpClient.addAuthenticator((Request request) async {
      request.headers.addAll(headers);
      return request;
    });
    httpClient.defaultDecoder = (map) => KakaoAccount.fromJson(map);
    return await httpClient.get(URL_KAKAO_USER_ME);
  }

  /*
  auth
  */

  Future<Response<ApiResponse<JwtAuthenticationResponse>>> signIn(Login req) async {
    httpClient.defaultDecoder = (map) => ApiResponse<JwtAuthenticationResponse>.fromJson(map);
    return await httpClient.post(
      SCHEME + APP_SERVER_URL + PATH_LOGIN,
      body: req.toJson()
    );
  }

  Future<Response<ApiResponse<void>>> signUp(UserCreate req) async {
    httpClient.defaultDecoder = (map) => ApiResponse<void>.fromJson(map);
    return await httpClient.post(
      SCHEME + APP_SERVER_URL + PATH_SIGN_UP,
      body: req.toJson(),
    );
  }

  Future<Response<ApiResponse<JwtAuthenticationResponse>>> getNewAccessToken(String refreshToken) async {
    Map<String, String> headers = {'authorization': 'Bearer $refreshToken'};
    httpClient.defaultDecoder = (map) => ApiResponse<JwtAuthenticationResponse>.fromJson(map);
    return await httpClient.get(
      SCHEME + APP_SERVER_URL + PATH_ACCESSTOKEN,
      headers: headers
    );
  }

  Future<Response<ApiResponse<JwtAuthenticationResponse>>> refreshJwt() async {
    Map<String, String> headers = {'authorization': 'Bearer $token'};
    httpClient.defaultDecoder = (map) => ApiResponse<JwtAuthenticationResponse>.fromJson(map);
    return await httpClient.get(
      SCHEME + APP_SERVER_URL + PATH_REFRESH_JWT,
      headers: headers
    );
  }
  

  /*
  user
  */
  Future<Response<ApiResponse<User>>> getUser() async {
    Map<String, String> headers = {'authorization': 'Bearer $token'};
    httpClient.defaultDecoder = (map) => ApiResponse<User>.fromJson(map);
    return await httpClient.get(
      SCHEME + APP_SERVER_URL + PATH_USER,
      headers: headers
    );
  }

  Future<Response<ApiResponse<void>>> checkExistUser(String loginId) async {
    httpClient.defaultDecoder = (map) => ApiResponse<void>.fromJson(map);
    return await httpClient.get(
      SCHEME + APP_SERVER_URL + PATH_USER_EXIST +'?loginId=$loginId'
    );
  }
}