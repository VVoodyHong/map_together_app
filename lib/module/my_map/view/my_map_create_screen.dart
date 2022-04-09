import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/my_map_create_controller.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_tff.dart';

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
          ),
          actions: [
            BaseButton.textButton(
              text: '등록',
              onPressed: controller.onPressCreate,
            )
          ]
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
              hintText: '장소명을 입력해주세요.'
            ).marginSymmetric(horizontal: 15),
            BaseTextFormField(
              controller: controller.addressController,
              hintText: '위치를 선택해 주소를 입력해주세요.',
              enabled: false
            ).marginSymmetric(horizontal: 15),
            BaseTextFormField(
              controller: controller.descriptionController,
              hintText: '장소에 대한 설명을 입력해주세요.',
              multiline: true
            ).marginSymmetric(horizontal: 15)
          ],
        ),
      )
    );
  }
}