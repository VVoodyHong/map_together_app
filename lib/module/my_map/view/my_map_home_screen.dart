import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/my_map_home_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/bottom_nav.dart';
import 'package:map_together/widget/header_bar.dart';
import 'package:map_together/widget/profile.dart';

class MyMapHomeScreen extends GetView<MyMapHomeX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderBar(),
            Profile(),
            _myMap()
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: BottomNav(),
    ));
  }

  _floatingActionButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: FloatingActionButton(
        elevation: 2,
        backgroundColor: MtColor.signature,
        child: Icon(
          !controller.createMode.value ? Icons.add : Icons.clear,
          color: MtColor.white,
          size: 35,
        ),
        onPressed: _onPressButton,
      ),
    );
  }

  _onPressButton() {
    controller.changeCreateMode();
    if(controller.createMode.value) {
      Utils.showToast('추가할 장소를 선택해주세요.');
    }
  }

  _myMap() {
    return Expanded(
      child: NaverMap(
        initialCameraPosition: controller.cameraPosition.value,
        locationButtonEnable: true,
        onMapCreated: controller.onMapCreated,
        onMapTap: controller.onMapTap,
        onSymbolTap: controller.onSymbolTap,
      ),
    );
  }
}
