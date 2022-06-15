import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_together/model/page/request_page.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/place/place_search.dart';
import 'package:map_together/model/place/place_simple.dart';
import 'package:map_together/model/place/places.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';

class SearchPlaceListX extends GetxController {
  static SearchPlaceListX get to => Get.find();
  
  Rx<Position> currentPlace = (null as Position).obs;
  RxBool isLoading = false.obs;
  RxString keyword = ''.obs;
  RxString address = ''.obs;
  RxInt page = 1.obs;
  RxBool isLast = false.obs;
  RxList<PlaceSimple> placeList = <PlaceSimple>[].obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    currentPlace.value = await Geolocator.getCurrentPosition();
    keyword.value = Get.arguments['keyword'];
    address.value = Get.arguments['address'];
    scrollController.addListener(listenScrolling);
    await searchPlace();
    super.onInit();
  }

  void listenScrolling() async {
    if (scrollController.position.atEdge) {
      bool isTop = scrollController.position.pixels == 0;
      if (!isTop && !isLast.value) {
        page++;
        await searchPlace();        
      }
    }
  }

  Future<void> searchPlace() async {
    PlaceSearch placeSearch = PlaceSearch(
      keyword: keyword.value,
      address: address.value,
      requestPage: RequestPage(
        page: page.value,
        size: DefaultPage.size
      )
    );
    isLoading.value = true;
    ApiResponse<Places> response = await API.to.searcPlace(placeSearch);
    if(response.success) {
      placeList.addAll(response.data?.list ?? []);
      isLast.value = response.data!.last;
    } else {
      print("searchPlace error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }

  void moveToPlace(int userIdx, String userNickname, PlaceSimple placeSimple) {
    print(userIdx);
    print(userNickname);
    Place place = Place(
      idx: placeSimple.idx,
      category: placeSimple.category,
      name: placeSimple.name,
      address: placeSimple.address,
      favorite: placeSimple.favorite,
      lat: placeSimple.lat,
      lng: placeSimple.lng,
      createAt: placeSimple.createAt,
      updateAt: placeSimple.updateAt
    );
    Utils.moveTo(
      UiState.PLACE,
      arg: {
        'userIdx': userIdx,
        'userNickname': userNickname,
        'place': place,
      }
    );
  }
}