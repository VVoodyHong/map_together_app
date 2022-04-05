import 'dart:async';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/rest/api_request.dart';

class MyMapCreateX extends GetxController {
  static MyMapCreateX get to => Get.find();

  Completer<NaverMapController> mapController = Completer();

  late LatLng position;
  late String place;

  RxList<Marker> markers = <Marker>[].obs;

  @override
  void onInit() async {

    super.onInit();
    position = Get.arguments['position'];
    place = Get.arguments['caption'];
    
    await API.to.test(position.longitude, position.latitude).then((res) {
      print("@@@@@");
      print(res.body.toString());
    });
    markers.add(
      Marker(
        markerId: position.json.toString(),
        position: position,
        height: 30,
        width: 20,
      )
    );
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void onMapTap(LatLng position) async {
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: position,
        )
      )
    ).then((value) {
      markers.clear();
      markers.add(
        Marker(
          markerId: position.json.toString(),
          position: position,
          height: 30,
          width: 20,
        )
      );
    });
  }

  onSymbolTap(LatLng? position, String? caption) async {
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: position!,
        )
      )
    ).then((value) {
      markers.clear();
      markers.add(
        Marker(
          markerId: position.json.toString(),
          position: position,
          height: 30,
          width: 20,
        )
      );
    });
  }
}