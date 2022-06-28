import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        onTap: (index) { controller.switchNav(index, context); },
        items: [
          BottomNavigationBarItem(
            label: '소식',
            icon: Icon(Icons.people).marginSymmetric(vertical: 3),
          ),
          BottomNavigationBarItem(
            label: '검색',
            icon: Icon(Icons.search).marginSymmetric(vertical: 3),
          ),
          BottomNavigationBarItem(
            label: '나의 맵',
            icon: Icon(Icons.person).marginSymmetric(vertical: 3),
          ),
        ],
      ),
    ));
  }
}

class NavigatorX extends GetxController{
  static NavigatorX get to => Get.find();
  var currentIndex = 2.obs;
  var navList = [
    UiState.NEWS_HOME,
    UiState.SEARCH_HOME,
    UiState.MYMAP_HOME,
  ];

  void switchNav(int index, BuildContext context){
    FocusScope.of(context).unfocus();
    if(currentIndex.value == index) return;
    currentIndex.value = index;
    // UiLogic.changeUiState(navList[index]);
  }
}