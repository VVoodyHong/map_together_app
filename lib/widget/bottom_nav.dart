import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/utils/constants.dart';

class BottomNav extends GetView<NavigatorX> {

  @override
  Widget build(BuildContext context) {
    
    return Obx(() => Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: MtColor.grey,
            width: 0.1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MtColor.signature,
        unselectedItemColor: MtColor.paleBlack,
        currentIndex: controller.currentIndex.value,
        backgroundColor: MtColor.white,
        selectedFontSize: 14,
        unselectedFontSize: 13,
        elevation: 0,
        iconSize: 30,
        onTap: (index) { controller.switchNav(index); },
        items: [
          BottomNavigationBarItem(
            label: '나의 맵',
            icon: Icon(Icons.person).marginSymmetric(vertical: 3),
          ),
          BottomNavigationBarItem(
            label: '검색',
            icon: Icon(Icons.search).marginSymmetric(vertical: 3),
          )
        ],
      ),
    ));
  }
}

class NavigatorX extends GetxController{
  static NavigatorX get to => Get.find();
  var currentIndex = 0.obs;
  var navList = [
    UiState.MYMAP_HOME,
    UiState.SEARCH_HOME,
  ];

  void switchNav(int index){
    if(currentIndex.value == index) return;
    currentIndex.value = index;
    UiLogic.changeUiState(navList[index]);
  }
}