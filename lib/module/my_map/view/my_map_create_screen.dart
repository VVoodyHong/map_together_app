import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/my_map_create_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_tff.dart';
import 'package:map_together/widget/button_round.dart';

class MyMapCreateScreen extends GetView<MyMapCreateX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: BaseAppBar(
          title: '장소 추가',
          leading: BaseButton.iconButton(
            iconData: Icons.arrow_back,
            onPressed: () => Get.close(1)
          )
        ).init(),
        body: SafeArea(
          child: Column(
            children: [
              _naverMap(),
              _body()
            ]
          )
        )
      )
    ));
  }

  Widget _naverMap() {
    // to use GetX detector
    controller.markers.value;
    return SizedBox(
      height: 200,
      child: NaverMap(
        initialCameraPosition: CameraPosition(
          target: controller.position,
          zoom: 15,
        ),
        onMapCreated: controller.onMapCreated,
        locationButtonEnable: true,
        onMapTap: controller.onMapTap,
        onSymbolTap: controller.onSymbolTap,
        markers: controller.markers
      )
    );
  }

  Widget _body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BaseTextFormField(
              controller: controller.nameController,
              hintText: '장소명을 입력해주세요.',
              maxLength: 64,
              enabled: true
            ).marginSymmetric(horizontal: 15),
            BaseTextFormField(
              controller: controller.addressController,
              hintText: '위치를 선택해 주소를 입력해주세요.',
              maxLength: 64,
              enabled: false
            ).marginSymmetric(horizontal: 15),
            BaseTextFormField(
              hintText: '카테고리 선택',
              maxLength: 64,
              enabled: false,
              onTap: controller.moveToCategory,
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                color: MtColor.black,
              ),
            ).marginSymmetric(horizontal: 15),
            BaseTextFormField(
              controller: controller.descriptionController,
              hintText: '장소에 대한 설명을 입력해주세요.',
              maxLength: 1800,
              multiline: true,
            ).marginSymmetric(horizontal: 15),
            ButtonRound(
              label: '등록',
              onTap: controller.createPlace,
              buttonColor: MtColor.signature,
              textColor: MtColor.white,
            ).marginOnly(left: 15, right: 15, top: 30),
          ],
        ),
      )
    );
  }
}