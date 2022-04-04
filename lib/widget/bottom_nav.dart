import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        selectedFontSize: 14,
        unselectedFontSize: 13,
        unselectedItemColor: MtColor.black,
        backgroundColor: MtColor.white,
        currentIndex: controller.currentIndex.value,
        elevation: 0,
        iconSize: 30,
        onTap: (index) { controller.switchNav(index); },
        items: [
          BottomNavigationBarItem(
            label: '나의 맵',
            icon: Icon(Icons.person).marginSymmetric(vertical: 3),
          ),
          BottomNavigationBarItem(
            label: '준비 중 ',
            icon: Icon(Icons.priority_high_rounded).marginSymmetric(vertical: 3),
          ),
          BottomNavigationBarItem(
            label: '준비 중 ',
            icon: Icon(Icons.priority_high_rounded).marginSymmetric(vertical: 3),
          ),
          BottomNavigationBarItem(
            label: '더보기',
            icon: Icon(Icons.more_horiz).marginSymmetric(vertical: 3),
          ),
        ],
      ),
    ));
  }
}

class NavigatorX extends GetxController{
  static NavigatorX get to => Get.find();
  var currentIndex = 0.obs;
  var navList = [
    // UiState.COMPANY_HOME,
    // UiState.CHAT_HOME,
    // UiState.REQUEST_HOME,
    // UiState.CONFIG_HOME
  ];

  void switchNav(int index){
    if(currentIndex.value == index) return;
    currentIndex.value = index;
    // UiLogic.changeUiState(navList[index]);
  }
}