import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/module/news/controller/select_place_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/button_round.dart';

class SelectPlaceScreen extends GetView<SelectPlaceX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
        title: '지역 선택',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        )
      ).init(),
      body: SafeArea(child: _myMap())
    ));
  }

  Widget _myMap() {
    return Column(
      children: [
        Slider(
          value: controller.zoom.value,
          max: ZoomLevel.max,
          min: ZoomLevel.min,
          onChanged: controller.onChangeZoom,
          activeColor: MtColor.signature,
        ),
        Expanded(
          child: Stack(
            children: [
              NaverMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    DefaultPosition.lat,
                    DefaultPosition.lng,
                  ),
                  zoom: DefaultPosition.zoom
                ),
                onMapCreated: controller.onMapCreated,
                onMapTap: controller.onMapTap,
                onSymbolTap: controller.onSymbolTap,
                onCameraIdle: controller.onCameraIdle,
                markers: controller.markers.value,
                maxZoom: ZoomLevel.max,
                minZoom: ZoomLevel.min,
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
                      '현재 선택 지역',
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
          ),
        ),
        ButtonRound(
          label: '완료',
          onTap: controller.onComplete
        ).marginAll(15)
      ],
    );
  }
}