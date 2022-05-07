import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/navigator/ui_state.dart';

class SearchHomeX extends GetxController {

  static SearchHomeX get to => Get.find();

  Rx<UiState> currentTab = UiState.SEARCH_USER.obs;
  RxBool hasValue = false.obs;

  TextEditingController textEditingController = TextEditingController();

  void onChangeTab(UiState state) {
    currentTab.value = state;
  }

  void doSearch() {
  }

  void onChangeSearch(String value) {
    hasValue.value = textEditingController.text.isNotEmpty;
  }

  void clearSearch() {
    textEditingController.clear();
    hasValue.value = false;
  }
}