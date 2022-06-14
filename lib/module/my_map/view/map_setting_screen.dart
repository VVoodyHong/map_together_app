import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/map_setting_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/button_round.dart';

class MapSettingScreen extends GetView<MapSettingX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
        title: '나의 맵 설정',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        )
      ).init(),
      body: SafeArea(
        child: Column(
          children: [
            _body()
          ]
        )
      )
    ));
  }

  Widget _body() {
    return Expanded(
      child: Column(
        children: [
          Slider(
            value: controller.zoom.value,
            max: ZoomLevel.max,
            min: ZoomLevel.min,
            onChanged: controller.onChangeZoom,
            activeColor: MtColor.signature,
          ),
          Expanded(
            child: NaverMap(
            initialCameraPosition: CameraPosition(
              target: controller.position.value,
              zoom: controller.zoom.value,
            ),
            onMapCreated: controller.onMapCreated,
            onCameraIdle: controller.onCameraIdle,
            maxZoom: ZoomLevel.max,
            minZoom: ZoomLevel.min,
            ),
          ),
          ButtonRound(
            label: '맵 기본 위치 변경하기',
            onTap: controller.updateUser
          ).marginAll(15)
        ],
      ),
    );
  }
}