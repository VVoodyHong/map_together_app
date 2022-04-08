import 'package:get/get.dart';
import 'package:map_together/auth/secrets.dart';

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
      "X-NCP-APIGW-API-KEY-ID": naverClientId, // 개인 클라이언트 아이디
      "X-NCP-APIGW-API-KEY": naverClientSecret // 개인 시크릿 키
    };
    return await httpClient.get('https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=$lon,$lat&sourcecrs=epsg:4326&orders=addr&output=json', headers: headers);
  }
}