// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/search/controller/search_home_controller.dart';
import 'package:map_together/utils/constants.dart';

class SearchPlaceScreen extends GetView<SearchHomeX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => _myMap());
  }

   Widget _myMap() {
    return Stack(
      children: [
        NaverMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              App.to.user.value.lat!,
              App.to.user.value.lng!,
            ),
            zoom: App.to.user.value.zoom!
          ),
          locationButtonEnable: true,
          onMapCreated: controller.onMapCreated,
          onMapTap: controller.onMapTap,
          onSymbolTap: controller.onSymbolTap,
          markers: controller.address.value.isNotEmpty ? controller.markers.value : []
        ),
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: MtColor.signature,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '현재 검색 범위',
                style: TextStyle(
                  color: MtColor.white,
                  fontWeight: FontWeight.w600
                ),
              ).marginOnly(bottom: 5),
              Text(
                controller.address.value.isEmpty ? '전체' : controller.address.value,
                style: TextStyle(
                  color: MtColor.white,
                ),
              ),
            ],
          )
        )
      ],
    ).marginOnly(top: 10);
  }
}