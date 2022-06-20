import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:map_together/auth/secrets.dart';
import 'package:map_together/model/auth/jwt_authentication_response.dart';
import 'package:map_together/model/auth/login.dart';
import 'package:map_together/model/file/files.dart';
import 'package:map_together/model/follow/follow_count.dart';
import 'package:map_together/model/follow/follow_search.dart';
import 'package:map_together/model/follow/follow_state.dart';
import 'package:map_together/model/follow/follows.dart';
import 'package:map_together/model/page/request_page.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/place/place_create.dart';
import 'package:map_together/model/place/place_search.dart';
import 'package:map_together/model/place/places.dart';
import 'package:map_together/model/place_category/place_categories.dart';
import 'package:map_together/model/place_category/place_category.dart';
import 'package:map_together/model/place_category/place_category_create.dart';
import 'package:map_together/model/place_like/place_like.dart';
import 'package:map_together/model/place_reply/place_replies.dart';
import 'package:map_together/model/place_reply/place_reply_create.dart';
import 'package:map_together/model/place_reply/place_reply_simple.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/tag/tags.dart';
import 'package:map_together/model/type/exist_type.dart';
import 'package:map_together/model/user/user.dart';
import 'package:map_together/model/user/user_create.dart';
import 'package:map_together/model/user/user_search.dart';
import 'package:map_together/model/user/user_update.dart';
import 'package:map_together/model/user/users.dart';
import 'package:map_together/rest/api_keys.dart';
import 'package:map_together/utils/utils.dart';

class API extends getx.GetxController{
  static API get to => getx.Get.find();

  String token = '';

  late Dio dio;

  BaseOptions options = BaseOptions(
    baseUrl: SCHEME + APP_SERVER_URL,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    sendTimeout: 10000,
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

  Future<ApiResponse<User>> getOtherUser(int userIdx) async {
    Response response = await dio.get(
      dio.options.baseUrl + PATH_USER + '/$userIdx',
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

  Future<ApiResponse<PlaceCategory>> createPlaceCategory(PlaceCategoryCreate req) async {
    Response response = await dio.post(
      dio.options.baseUrl + PATH_PLACE_CATEGORY,
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
      data: req
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<PlaceCategory>.fromJson(response.data);
  }

  Future<ApiResponse<Users>> searchUser(UserSearch req) async {
    Map<String, dynamic> json = req.toJson();
    Response response = await dio.post(
      dio.options.baseUrl + PATH_USER_SEARCH,
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
      data: json
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<Users>.fromJson(response.data);
  }

  /*
  place
  */

  Future<ApiResponse<Place>> createPlace(PlaceCreate req, List<File>? files) async {
    Map<String, dynamic> json = req.toJson();
    if(files != null) {
      json['files'] = files.map((file) => MultipartFile.fromFileSync(file.path)).toList();
    }
    FormData formData = FormData.fromMap(json);
    Response response = await dio.post(
      dio.options.baseUrl + PATH_PLACE,
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
      data: formData
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<Place>.fromJson(response.data);
  }

  Future<ApiResponse<PlaceCategories>> getPlaceCategory(int userIdx) async {
    Response response = await dio.get(
      dio.options.baseUrl + PATH_PLACE_CATEGORY + '/$userIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<PlaceCategories>.fromJson(response.data);
  }

  Future<ApiResponse<void>> deletePlaceCategory(PlaceCategories req) async {
    Response response = await dio.delete(
      dio.options.baseUrl + PATH_PLACE_CATEGORY,
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
      data: req
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<void>.fromJson(response.data);
  }

  Future<ApiResponse<Files>> getPlaceImage(int placeIdx) async {
    Response response = await dio.get(
      dio.options.baseUrl + PATH_PLACE_IMAGE + '/$placeIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<Files>.fromJson(response.data);
  }

  Future<ApiResponse<Tags>> getPlaceTag(int placeIdx) async {
    Response response = await dio.get(
      dio.options.baseUrl + PATH_PLACE_TAG + '/$placeIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<Tags>.fromJson(response.data);
  }

  Future<ApiResponse<PlaceReplySimple>> createPlaceReply(PlaceReplyCreate req) async {
    Response response = await dio.post(
      dio.options.baseUrl + PATH_PLACE_REPLY,
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
      data: req
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<PlaceReplySimple>.fromJson(response.data);
  }

  Future<ApiResponse<PlaceReplies>> getPlaceReply(int placeIdx, RequestPage requestPage) async {
    Response response = await dio.get(
      dio.options.baseUrl + PATH_PLACE_REPLY + '/$placeIdx?page=${requestPage.page}&size=${requestPage.size}',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<PlaceReplies>.fromJson(response.data);
  }

  Future<ApiResponse<void>> deletePlaceReply(int placeReplyIdx) async {
    Response response = await dio.delete(
      dio.options.baseUrl + PATH_PLACE_REPLY + '/$placeReplyIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      )
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<void>.fromJson(response.data);
  }

  Future<ApiResponse<void>> createPlaceLike(int placeIdx) async {
    Response response = await dio.post(
      dio.options.baseUrl + PATH_PLACE_LIKE + '/$placeIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      )
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<void>.fromJson(response.data);
  }

  Future<ApiResponse<PlaceLike>> getPlaceLike(int placeIdx) async {
    Response response = await dio.get(
      dio.options.baseUrl + PATH_PLACE_LIKE + '/$placeIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      )
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<PlaceLike>.fromJson(response.data);
  }

  Future<ApiResponse<void>> deletePlaceLike(int placeIdx) async {
    Response response = await dio.delete(
      dio.options.baseUrl + PATH_PLACE_LIKE + '/$placeIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      )
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<void>.fromJson(response.data);
  }

  Future<ApiResponse<Places>> searchPlace(PlaceSearch req) async {
    Map<String, dynamic> json = req.toJson();
    Response response = await dio.post(
      dio.options.baseUrl + PATH_PLACE_SEARCH,
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
      data: json
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    print(response);
    return ApiResponse<Places>.fromJson(response.data);
  }

  /*
  follow
  */
  
  Future<ApiResponse<void>> createFollow(int userIdx) async {
    Response response = await dio.post(
      dio.options.baseUrl + PATH_FOLLOW + '/$userIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      )
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<void>.fromJson(response.data);
  }

  Future<ApiResponse<Follows>> searchFollow(FollowSearch req) async {
    Response response = await dio.post(
      dio.options.baseUrl + PATH_FOLLOW_SEARCH,
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      ),
      data: req
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<Follows>.fromJson(response.data);
  }

  Future<ApiResponse<void>> deleteFollow(int userIdx) async {
    Response response = await dio.delete(
      dio.options.baseUrl + PATH_FOLLOW + '/$userIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      )
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<void>.fromJson(response.data);
  }

  Future<ApiResponse<FollowCount>> getFollowCount(int userIdx) async {
    Response response = await dio.get(
      dio.options.baseUrl + PATH_FOLLOW_COUNT + '/$userIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      )
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<FollowCount>.fromJson(response.data);
  }

   Future<ApiResponse<FollowState>> getFollowState(int userIdx) async {
    Response response = await dio.get(
      dio.options.baseUrl + PATH_FOLLOW_STATE + '/$userIdx',
      options: Options(
        headers: {'authorization': 'Bearer $token'},
      )
    ).onError((error, stackTrace) {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      throw Exception("server error :: $error");
    });
    return ApiResponse<FollowState>.fromJson(response.data);
  }
}