import 'dart:async';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/utils/utils.dart';

class MyMapHomeX extends GetxController {
  static MyMapHomeX get to => Get.find();

  Completer<NaverMapController> mapController = Completer();

  RxBool createMode = false.obs;

  Rx<CameraPosition> position = CameraPosition(
    target: LatLng(35.94841985643522, 127.68575755041469),
    zoom: 5.7,
  ).obs;

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

  void onMapTap(LatLng position) async {
    if(createMode.value) {
      Utils.moveTo(
        UiState.MYMAP_CREATE,
        arg: {
          'position': position,
        }
      );
      createMode.value = !createMode.value;
    } else {
      await (await mapController.future).moveCamera(
        CameraUpdate.toCameraPosition(
          CameraPosition(
            target: position,
          )
        )
      );
    }
  }

  void onSymbolTap(LatLng? position, String? caption) async {
    if(createMode.value) {
      Utils.moveTo(
        UiState.MYMAP_CREATE,
        arg: {
          'position': position,
          'caption': caption,
        }
      );
      createMode.value = !createMode.value;
    }  else {
      await (await mapController.future).moveCamera(
        CameraUpdate.toCameraPosition(
          CameraPosition(
            target: position!,
          )
        )
      );
    }
  }

  void changeCreateMode() {
    createMode.value = !createMode.value;
  }

  void moveToProfile() {
    Get.close(1);
    Utils.moveTo(UiState.PROFILE);
  }
}
