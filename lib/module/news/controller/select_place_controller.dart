import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_list_tile.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';

class SelectPlaceX extends GetxController {
  static SelectPlaceX get to => Get.find();

  Rx<LatLng> position = (null as LatLng).obs;
  RxDouble zoom = (null as double).obs;
  Rx<Marker> marker = (null as Marker).obs;
  RxList<Marker> markers = <Marker>[].obs;
  Completer<NaverMapController> mapController = Completer();
  TextEditingController addressController = TextEditingController();
  RxString address = ''.obs;
  late Function(String) onChangeAddress;

  @override
  void onInit() {
    onChangeAddress = Get.arguments['onChangeAddress'];
    position.value = LatLng(
      DefaultPosition.lat,
      DefaultPosition.lng,
    );
    zoom.value = DefaultPosition.zoom;
    super.onInit();
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

  void onCameraIdle() {
    mapController.future.then((value) {
      value.getCameraPosition().then((value) {
        position.value = value.target;
        zoom.value = value.zoom;
      });
    });
  }

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
    double _zoom = await mapController.future.then((value) => value.getCameraPosition().then((value) => value.zoom));
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: _position,
          zoom: _zoom
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

  void onComplete() {
    if(address.value.isNotEmpty) {
      List<String> addressList = address.value.split(' ');
      addressList.removeLast();
      onChangeAddress(addressList.last);
    } else {
      onChangeAddress(address.value);
    }
    Get.close(1);
  }
}