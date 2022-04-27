import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:map_together/auth/secrets.dart';
import 'package:map_together/model/KakaoAccount.dart';
import 'package:map_together/model/request/user_create.dart';
import 'package:map_together/rest/api_keys.dart';

class API extends GetConnect {
  static API get to => Get.find();

  @override
  void onInit() {
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = Duration(seconds: 5);
    httpClient.addResponseModifier((request, response) {
      print('rest result:: ${response.status.code}');
    });

    super.onInit();
  }

  // https://api.ncloud-docs.com/docs/ai-naver-mapsreversegeocoding-gc
  Future<Response<dynamic>> reverseGeocoding(lon ,lat) async {
    // httpClient.defaultDecoder = (map) => map['data'];
    Map<String, String> headers = {
      "X-NCP-APIGW-API-KEY-ID": SdkKeys.naverClientId, // 개인 클라이언트 아이디
      "X-NCP-APIGW-API-KEY": SdkKeys.naverClientSecret // 개인 시크릿 키
    };
    return await httpClient.get('https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=$lon,$lat&sourcecrs=epsg:4326&orders=addr&output=json', headers: headers);
  }

  Future<Response<KakaoAccount>> getKakaoAccount(String? token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    httpClient.addAuthenticator((Request request) async {
      request.headers.addAll(headers);
      return request;
    });
    httpClient.defaultDecoder = (map) => KakaoAccount.fromJson(map);
    return await httpClient.get(URL_KAKAO_USER_ME);
  }

  Future<Response<Object>> signUp(UserCreate req) async {
    return await httpClient.post(
      SCHEME + APP_SERVER_URL + PATH_USER_CREATE,
      body: req.toJson()
    );
  }
}