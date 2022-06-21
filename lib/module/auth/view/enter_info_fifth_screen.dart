import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/module/auth/controller/enter_info_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/button_round.dart';

class EnterInfoFifthScreen extends GetView<EnterInfoX> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: BaseAppBar(
            title: '활동 지역 선택 (4/4)',
            leading: BaseButton.iconButton(
              iconData: Icons.arrow_back,
              onPressed: () => Get.close(1)
            )
          ).init(),
          body: _body(context)
        ),
        controller.isLoading.value ? Utils.showLoading(isLoading: controller.isLoading.value) : Container()
      ],
    ));
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LinearProgressIndicator(
            value: 1,
            backgroundColor: MtColor.paleGrey,
            valueColor: AlwaysStoppedAnimation<Color>(MtColor.signature),
            minHeight: 5,
          ),
          Expanded(
            child: Column(
              children: [
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
                  locationButtonEnable: true,
                  ),
                ),
                Slider(
                  value: controller.zoom.value,
                  max: ZoomLevel.max,
                  min: ZoomLevel.min,
                  onChanged: controller.onChangeZoom,
                  activeColor: MtColor.signature,
                ),
              ],
            ),
          ),
          ButtonRound(
          label: '완료',
          onTap: controller.updateUser,
        ).marginAll(15),
        ],
      ),
    );
  }

}