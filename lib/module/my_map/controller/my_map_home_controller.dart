// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/place_category/place_categories.dart';
import 'package:map_together/model/place_category/place_category.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';

class MyMapHomeX extends GetxController {
  static MyMapHomeX get to => Get.find();

  Completer<NaverMapController> mapController = Completer();
  RxDouble zoom = 0.0.obs;
  Rx<LatLng> position = (null as LatLng).obs;
  RxList<Marker> markers = <Marker>[].obs;
  RxList<Place> placeList = <Place>[].obs;
  RxList<PlaceCategory> placeCategoryList = <PlaceCategory>[].obs;
  RxInt selectedPlaceCategory = (-1).obs;
  RxInt tempSelectedPlaceCategory = (-1).obs;

  RxBool createMode = false.obs;

  @override
  void onInit() async {
    position.value = LatLng(
      App.to.user.value.lat ?? DefaultPosition.lat,
      App.to.user.value.lng ?? DefaultPosition.lng,
    );
    zoom.value = App.to.user.value.zoom ?? DefaultPosition.zoom;
    placeList.value = App.to.user.value.places ?? <Place>[];
    for (Place place in placeList) {
      markers.add(await createMarker(place));
    }
    await getPlaceCategories();
    super.onInit();
  }

  Future<Marker> createMarker(Place place) async {
    LatLng _position = LatLng(
      place.lat,
      place.lng,
    );
    return Marker(
      markerId: _position.json.toString(),
      position: _position,
      height: 20,
      width: 20,
      icon: await OverlayImage.fromAssetImage(assetName: Asset().getMarker(place.category.type.getValue())),
      onMarkerTab: onMarkerTap
    );
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

   void onPressCreate() {
    changeCreateMode();
    if(createMode.value) {
      Utils.showToast('추가할 장소를 선택해주세요.');
    }
  }

  void onMarkerTap(Marker? marker, Map<String, int?> size) async {
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: marker!.position!,
          zoom: zoom.value
        )
      )
    );
  }

  void onMapTap(LatLng _position) async {
    if(createMode.value) {
      Utils.moveTo(
        UiState.MYMAP_CREATE,
        arg: {
          'position': _position,
          'addMarker': addMarker,
          'placeCategoryList': placeCategoryList,
        }
      );
      createMode.value = !createMode.value;
    } else {
      await (await mapController.future).moveCamera(
        CameraUpdate.toCameraPosition(
          CameraPosition(
            target: _position,
            zoom: zoom.value
          )
        )
      );
    }
  }

  void onSymbolTap(LatLng? _position, String? caption) async {
    if(createMode.value) {
      Utils.moveTo(
        UiState.MYMAP_CREATE,
        arg: {
          'position': _position,
          'caption': caption,
          'addMarker': addMarker,
          'placeCategoryList': placeCategoryList
        }
      );
      createMode.value = !createMode.value;
    }  else {
      await (await mapController.future).moveCamera(
        CameraUpdate.toCameraPosition(
          CameraPosition(
            target: _position!,
            zoom: zoom.value
          )
        )
      );
    }
  }

  Future<void> addMarker(Place place) async {
    placeList.add(place);
    markers.add(await createMarker(place));
  }

  void changeView(LatLng _postition, double _zoom) async {
    position.value = _postition;
    zoom.value = _zoom;
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: position.value,
          zoom: zoom.value
        )
      )
    );
  }

  Future<void> getPlaceCategories() async {
    ApiResponse<PlaceCategories> response = await API.to.getPlaceCategories();
    if(response.success) {
      placeCategoryList.addAll(response.data?.list ?? []);
    } else {
      print("getCategories error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void changeCreateMode() {
    createMode.value = !createMode.value;
  }

  void setTempSelectedPlaceCategory(int index) {
    if(tempSelectedPlaceCategory.value == index){
      tempSelectedPlaceCategory.value = -1;
    } else {
      tempSelectedPlaceCategory.value = index;
    }
  }

  Future<void> setSelectedPlaceCategory() async {
    selectedPlaceCategory.value = tempSelectedPlaceCategory.value;
    // placeCategoryList[selectedPlaceCategory.value].type
    markers.clear();
    if(selectedPlaceCategory.value == -1) {
      for(Place place in placeList) {
        markers.add(await createMarker(place));
      }
    } else {
      for(Place place in placeList) {
        if(placeCategoryList[selectedPlaceCategory.value].name == place.category.name) {
          markers.add(await createMarker(place));
        }
      }
    }
    Get.close(1);
  }

  void moveToProfile() {
    Get.close(1);
    Utils.moveTo(UiState.PROFILE);
  }

  void moveToSetting() {
    Get.close(1);
    Utils.moveTo(
        UiState.MYMAP_SETTING,
        arg: {
          'position': position.value,
          'zoom': zoom.value,
          'changeView': changeView
        }
      );
  }
}
