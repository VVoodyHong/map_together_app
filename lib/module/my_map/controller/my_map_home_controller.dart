// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';

class MyMapHomeX extends GetxController {
  static MyMapHomeX get to => Get.find();

  Completer<NaverMapController> mapController = Completer();
  RxDouble zoom = 0.0.obs;
  Rx<LatLng> position = (null as LatLng).obs;
  RxList<Marker> markers = <Marker>[].obs;
  List<Place> placeList = <Place>[].obs;

  RxBool createMode = false.obs;

  @override
  void onInit() async {
    position.value = LatLng(
      App.to.user.value.lat ?? DefaultPosition.lat,
      App.to.user.value.lng ?? DefaultPosition.lng,
    );
    zoom.value = App.to.user.value.zoom ?? DefaultPosition.zoom;
    placeList = App.to.user.value.places ?? [];
    for (Place place in placeList) {
      markers.add(await createMarker(place));
    }
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
      icon: await OverlayImage.fromAssetImage(assetName: Asset().getMarker(place.category.type.getValue()))
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

  void onMapTap(LatLng _position) async {
    if(createMode.value) {
      Utils.moveTo(
        UiState.MYMAP_CREATE,
        arg: {
          'position': _position,
          'addMarker': addMarker
        }
      );
      createMode.value = !createMode.value;
    } else {
      await (await mapController.future).moveCamera(
        CameraUpdate.toCameraPosition(
          CameraPosition(
            target: _position,
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
          'addMarker': addMarker
        }
      );
      createMode.value = !createMode.value;
    }  else {
      await (await mapController.future).moveCamera(
        CameraUpdate.toCameraPosition(
          CameraPosition(
            target: _position!,
          )
        )
      );
    }
  }

  Future<void> addMarker(Place place) async {
    markers.add(await createMarker(place));
  }

  void changeCreateMode() {
    createMode.value = !createMode.value;
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
