import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/rest/api_request.dart';
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
    nameController.text = Get.arguments['caption'] ?? '';
    searchAddress();
    markers.add(
      Marker(
        markerId: position.json.toString(),
        position: position,
        height: 30,
        width: 20,
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
    searchAddress();
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: _position,
        )
      )
    ).then((value) {
      markers.clear();
      markers.add(
        Marker(
          markerId: _position.json.toString(),
          position: _position,
          height: 30,
          width: 20,
        )
      );
    });
  }

  void onSymbolTap(LatLng? _position, String? caption) async {
    position = _position!;
    nameController.text = caption ?? '';
    searchAddress();
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: _position,
        )
      )
    ).then((value) {
      markers.clear();
      markers.add(
        Marker(
          markerId: _position.json.toString(),
          position: _position,
          height: 30,
          width: 20,
        )
      );
    });
  }

  void onPressCreate() {
    print('nameController:: ${nameController.text}');
    print('addressController:: ${addressController.text}');
    print('descriptionController:: ${descriptionController.text}');
  }

  void searchAddress() async {
    await API.to.reverseGeocoding(position.longitude, position.latitude).then((res) {
      if(res.body['status']['code'] == 3) {
        Utils.showToast('정상적인 위치가 아니거나 상세주소를 찾을 수 없습니다.');
      } else if(res.body['status']['code'] == 0) {
        String tempAddress = '';
        for(int i = 1; i < res.body['results'][0]['region'].length; i++) {
          if(res.body['results'][0]['region']['area$i']['name'] != '') {
            tempAddress += (res.body['results'][0]['region']['area$i']['name'] + ' ');
          }
        }
        tempAddress += res.body['results'][0]['land']['number1'];
        if(res.body['results'][0]['land']['number2'] != '') {
          tempAddress += '-' + res.body['results'][0]['land']['number2'];
        }
        addressController.text = tempAddress;
      }
    });
  }
}