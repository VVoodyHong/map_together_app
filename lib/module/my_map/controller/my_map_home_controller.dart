import 'dart:async';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/utils/utils.dart';

class MyMapHomeX extends GetxController {
  static MyMapHomeX get to => Get.find();

  Completer<NaverMapController> mapController = Completer();

  RxBool createMode = false.obs;

  Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(35.94841985643522, 127.68575755041469),
    zoom: 5.7,
  ).obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void onMapTap(LatLng position) {
    if(createMode.value) {
      Utils.showToast('mapTap\n' + position.toString());
    }
  }

  void onSymbolTap(LatLng? position, String? caption) {
    if(createMode.value) {
      Utils.showToast('symbolTap\n' + position.toString() + '\n' + caption.toString());
    }
  }

  void changeCreateMode() {
    createMode.value = !createMode.value;
  }
}
