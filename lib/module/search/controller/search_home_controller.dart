import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/page/request_page.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/model/user/user_search.dart';
import 'package:map_together/model/user/user_simple.dart';
import 'package:map_together/model/user/users.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_list_tile.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';

class SearchHomeX extends GetxController {

  static SearchHomeX get to => Get.find();

  Rx<UiState> currentTab = UiState.SEARCH_USER.obs;
  RxBool hasValue = false.obs;
  TextEditingController searchController = TextEditingController();

  // serach user
  RxInt userPage = 1.obs;
  RxBool isLastUser = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSearched = false.obs;
  RxList<UserSimple> userList = <UserSimple>[].obs;
  ScrollController userScrollController = ScrollController();

  // serach place
  Rx<LatLng> position = (null as LatLng).obs;
  RxList<Marker> markers = <Marker>[].obs;
  Rx<Marker> marker = (null as Marker).obs;
  Completer<NaverMapController> mapController = Completer();
  TextEditingController addressController = TextEditingController();
  RxString address = ''.obs;

  @override
  void onInit() {

    // serach user
    userScrollController.addListener(listenScrollingUser);

    // serach place

    super.onInit();
  }

  void onChangeTab(UiState state) {
    if(state == UiState.SEARCH_PLACE) {
      Utils.showToast('지역을 선택하면\n해당 범위 내에서 검색합니다.');
      markers.clear();
      address.value = '';
    } else {
      userList.clear();
      userPage.value = 1;
      isLastUser.value = false;
      isSearched.value = false;
    }
    currentTab.value = state;
    searchController.clear();
    hasValue.value = false;
  }

  void onChangeSearch(String value) {
    hasValue.value = searchController.text.isNotEmpty;
  }

  void clearSearch() {
    searchController.clear();
    hasValue.value = false;
  }

  void doSearch() async {
    if(searchController.text.trim().isEmpty) {
      Utils.showToast('검색어를 입력해주세요');
      return;
    }
    if(currentTab.value == UiState.SEARCH_USER) {
      userList.clear();
      userPage.value = 1;
      isLastUser.value = false;
      await searchUser();
    } else {
      Utils.moveTo(
        UiState.SEARCH_PLACE_LIST,
        arg: {
          'keyword': searchController.text,
          'address': address.value
        }
      );
    }
  }

  void moveToUserHome(int userIdx) {
    Utils.moveTo(
      UiState.USER_HOME_SCREEN,
      arg: {
        'userIdx': userIdx
      }
    );
  }

  // serach user
  void listenScrollingUser() async {
    if (userScrollController.position.atEdge) {
      bool isTop = userScrollController.position.pixels == 0;
      if (!isTop && !isLastUser.value) {
        userPage++;
        await searchUser();        
      }
    }
  }

  Future<void> searchUser() async {
    UserSearch userSearch = UserSearch(
      keyword: searchController.text,
      requestPage: RequestPage(
        page: userPage.value,
        size: DefaultPage.size,
      ),
    );
    isLoading.value = true;
    ApiResponse<Users> response = await API.to.searchUser(userSearch);
    if(response.success) {
      userList.addAll(response.data?.list ?? []);
      isLastUser.value = response.data!.last;
      isSearched.value = true;
    } else {
      print("searchUser error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }

  // serach place

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void onMapTap(LatLng _position) async {
    position.value = _position;
    await searchAddress(_position);
  }

  void onSymbolTap(LatLng? _position, String? caption) async {
    position.value = _position!;
    await searchAddress(_position);
  }

  Future<void> moveMap(LatLng _position) async {
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: _position,
          zoom: App.to.user.value.zoom!
        )
      )
    );
    markers.clear();
    await setMarker();
    markers.add(marker.value);
  }

  Future<void> setMarker() async {
    marker.value = Marker(
      markerId: position.value.json.toString(),
      position: position.value,
      height: 20,
      width: 20,
      icon: await OverlayImage.fromAssetImage(assetName: Asset().getMarker(PlaceCategoryType.MARKER.getValue()))
    );
  }

  Future<bool> searchAddress(LatLng _position) async {
    dynamic res = await API.to.reverseGeocoding(position.value.longitude, position.value.latitude);
    if(res['status']['code'] == 3) {
      Utils.showToast('정상적인 위치가 아니거나 상세주소를 찾을 수 없습니다.');
      return false;
    } else if(res['status']['code'] == 0) {
      String tempAddress = '';
      for(int i = 1; i < res['results'][0]['region'].length; i++) {
        if(res['results'][0]['region']['area$i']['name'] != '') {
          tempAddress += (res['results'][0]['region']['area$i']['name'] + ' ');
        }
      }
      tempAddress += res['results'][0]['land']['number1'];
      if(res['results'][0]['land']['number2'] != '') {
        tempAddress += '-' + res['results'][0]['land']['number2'];
      }
      addressController.value = TextEditingValue(text: tempAddress);
      await moveMap(_position);
      List<String> addressList = addressController.text.split(' ');
      List<BaseListTile> listTiles = [];
      String _address = '';
      for(int i = 0; i < addressList.length + 1; i++) {
        String _tempAddress = _address;
        if(i != addressList.length) {
          listTiles.add(
            BaseListTile(
              title: _address.isEmpty ? '전체' : _address,
              onTap: () {onTapAddress(_tempAddress);},
            )
          );
          _address += (addressList[i] + ' ');
        }
      }
      BottomSheetModal.showList(
        context: Get.context!,
        listTiles: listTiles
      );
      return true;
    } else {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      return false;
    }
  }

  void onTapAddress(String _address) {
    address.value = _address;
    Get.close(1);
  }
}