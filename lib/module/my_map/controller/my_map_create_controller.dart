import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';

class MyMapCreateX extends GetxController {

  static MyMapCreateX get to => Get.find();

  Completer<NaverMapController> mapController = Completer();

  late LatLng position;

  RxList<Marker> markers = <Marker>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() async {
    position = Get.arguments['position'];
    nameController.text = (Get.arguments['caption'] ?? '').replaceAll('\n', ' ');

    await searchAddress();
    markers.add(
      Marker(
        markerId: position.json.toString(),
        position: position,
        height: 20,
        width: 20,
        icon: await OverlayImage.fromAssetImage(assetName: 'lib/assets/markers/marker.png')
      )
    );
    super.onInit();
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void onMapTap(LatLng _position) async {
    position = _position;
    nameController.text = '';
    await searchAddress();
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: _position,
        )
      )
    );
    markers.clear();
    markers.add(
      Marker(
        markerId: _position.json.toString(),
        position: _position,
        height: 20,
        width: 20,
        icon: await OverlayImage.fromAssetImage(
          assetName: 'lib/assets/markers/marker.png'
        ),
      )
    );
  }

  void onSymbolTap(LatLng? _position, String? caption) async {
    position = _position!;
    nameController.text = (caption ?? '').replaceAll('\n', ' ');
    await searchAddress();
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: _position,
        )
      )
    );
    markers.clear();
    markers.add(
      Marker(
        markerId: _position.json.toString(),
        position: _position,
        height: 30,
        width: 20,
      )
    );
  }

  void createPlace() {
    print('nameController:: ${nameController.text}');
    print('addressController:: ${addressController.text}');
    print('descriptionController:: ${descriptionController.text}');
  }

  Future<void> searchAddress() async {
    dynamic res = await API.to.reverseGeocoding(position.longitude, position.latitude);
    if(res['status']['code'] == 3) {
      Utils.showToast('정상적인 위치가 아니거나 상세주소를 찾을 수 없습니다.');
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
      addressController.text = tempAddress;
    }
  }

  void moveToCategory() {
    Utils.moveTo(UiState.MYMAP_CATEGORY);
  }
}