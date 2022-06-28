import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_together/model/page/request_page.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/place/place_search.dart';
import 'package:map_together/model/place/place_simple.dart';
import 'package:map_together/model/place/places.dart';
import 'package:map_together/model/place_category/place_category.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsHomeX extends GetxController {
  static NewsHomeX get to => Get.find();

  RxString address = ''.obs;
  RxBool isLoading = false.obs;
  RxList<PlaceSimple> placeList = <PlaceSimple>[].obs;
  RxInt page = 1.obs;
  RxBool isLast = false.obs;
  Rx<Position> currentPlace = (null as Position).obs;
  ScrollController scrollController = ScrollController();
  late SharedPreferences prefs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    address.value = prefs.getString('newsAddress') ?? '';
    super.onInit();
    scrollController.addListener(listenScrolling);
    currentPlace.value = await Geolocator.getCurrentPosition();
    await newsPlace(); 
  }

  void listenScrolling() async {
    if (scrollController.hasClients && scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop && !isLast.value) {
          page++;
          await newsPlace();   
        }
      }
  }
  
  Future<void> newsPlace() async {
    PlaceSearch placeSearch = PlaceSearch(
      keyword: '',
      address: address.value,
      requestPage: RequestPage(
        page: page.value,
        size: 5
      )
    );
    isLoading.value = true;
    ApiResponse<Places> response = await API.to.newsPlace(placeSearch);
    if(response.success) {
      placeList.addAll(response.data?.list ?? []);
      isLast.value = response.data!.last;
    } else {
      print("newsPlace error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }

  Future<void> onRefresh() async {
    page.value = 1;
    isLast.value = false;
    placeList.clear();
    await newsPlace();
  }

  void moveToPlace(PlaceSimple placeSimple) {
    PlaceCategory placeCategory = PlaceCategory(
      idx: placeSimple.placeCategoryIdx,
      name: placeSimple.placeCategoryName,
      type: placeSimple.placeCategoryType
    );
    Place place = Place(
      idx: placeSimple.idx,
      category: placeCategory,
      name: placeSimple.name,
      address: placeSimple.address,
      description: placeSimple.description,
      favorite: placeSimple.favorite,
      lat: placeSimple.lat,
      lng: placeSimple.lng,
      createAt: placeSimple.createAt,
      updateAt: placeSimple.updateAt
    );
    Utils.moveTo(
      UiState.PLACE,
      arg: {
        'userIdx': placeSimple.userIdx,
        'userNickname': placeSimple.userNickname,
        'place': place,
      }
    );
  }

  void onChangeAddress(String _address) async {
    prefs.setString("newsAddress", _address);
    address.value = _address;
    await onRefresh();
  }

  void moveToUserHome(int userIdx) {
    Utils.moveTo(
      UiState.USER_HOME_SCREEN,
      arg: {
        'userIdx': userIdx
      }
    );
  }

  void moveToSelectPlace() {
    Utils.moveTo(
      UiState.SELECT_PLACE,
      arg: {
        'onChangeAddress': onChangeAddress
      }
    );
  }
}