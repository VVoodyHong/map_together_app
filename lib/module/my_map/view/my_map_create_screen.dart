import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/my_map_create_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';

class MyMapCreateScreen extends GetView<MyMapCreateX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
        title: '장소 추가',
        titleWeight: FontWeight.w500,
        leading: Utils.appBarBackButton(),
        actions: [
          IconButton(
            icon: Text(
              '등록',
              style: TextStyle(
                color: MtColor.black
              )
            ),
            onPressed: () {
              print('등록');
            },
          )
        ]
      ).init(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: _naverMap()
            )
          ],
        ),
      ),
    ));
  }

  _naverMap() {
    controller.markers.value;
    return NaverMap(
      initialCameraPosition: CameraPosition(
        target: controller.position,
        zoom: 15,
      ),
      onMapCreated: controller.onMapCreated,
      locationButtonEnable: true,
      onMapTap: controller.onMapTap,
      onSymbolTap: controller.onSymbolTap,
      markers: controller.markers
    );
  }
}