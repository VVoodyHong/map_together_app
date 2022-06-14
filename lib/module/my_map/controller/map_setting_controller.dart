import 'dart:async';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/user/user.dart';
import 'package:map_together/model/user/user_update.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';

class MapSettingX extends GetxController {
  static MapSettingX get to => Get.find();

  Completer<NaverMapController> mapController = Completer();
  Rx<LatLng> position = (null as LatLng).obs;
  RxDouble zoom = (null as double).obs;
  Function? changeView;

  @override
  void onInit() {
    position.value = Get.arguments['position'];
    zoom.value = Get.arguments['zoom'];
    changeView = Get.arguments['changeView'];
    super.onInit();
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void onCameraIdle() {
    mapController.future.then((value) {
      value.getCameraPosition().then((value) {
        position.value = value.target;
        zoom.value = value.zoom;
      });
    });
  }

  void onChangeZoom(double _zoom) async {
    zoom.value = _zoom;
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: position.value,
          zoom: _zoom
        )
      )
    );
  }

  void updateUser() async {
    UserUpdate userUpdate = UserUpdate(
      nickname: App.to.user.value.nickname,
      lat: position.value.latitude,
      lng: position.value.longitude,
      zoom: zoom.value
    );
    ApiResponse<User> response = await API.to.updateUser(userUpdate, null);
    if(response.success) {
      App.to.user.value = response.data!;
      if(changeView != null) {
        changeView!(
          LatLng(App.to.user.value.lat!, App.to.user.value.lng!),
          App.to.user.value.zoom!
        );
        Utils.showToast('설정이 완료되었습니다.');
        Get.close(1);
      }
    } else {
      print("updateUser error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }
}