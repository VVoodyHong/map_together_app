import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/model/page/request_page.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/user/user_search.dart';
import 'package:map_together/model/user/user_simple.dart';
import 'package:map_together/model/user/users.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';

class SearchHomeX extends GetxController {

  static SearchHomeX get to => Get.find();

  Rx<UiState> currentTab = UiState.SEARCH_USER.obs;
  RxBool hasValue = false.obs;
  RxInt userPage = 1.obs;
  RxBool isLastUser = false.obs;
  RxBool isLoading = false.obs;
  RxList<UserSimple> userList = <UserSimple>[].obs;

  TextEditingController textEditingController = TextEditingController();

  ScrollController userScrollController = ScrollController();

  @override
  void onInit() {
    userScrollController.addListener(listenScrollingUser);
    super.onInit();
  }

  void listenScrollingUser() async {
    if (userScrollController.position.atEdge) {
      bool isTop = userScrollController.position.pixels == 0;
      if (!isTop && !isLastUser.value) {
        userPage++;
        await searchUser();        
      }
    }
  }

  void doSearch() async {
    userList.clear();
    userPage.value = 1;
    isLastUser.value = false;
    await searchUser();
  }

  Future<void> searchUser() async {
    if(textEditingController.text.trim().isEmpty) {
      Utils.showToast('검색어를 입력해주세요');
      return;
    }
    UserSearch userSearch = UserSearch(
      keyword: textEditingController.text,
      requestPage: RequestPage(
        page: userPage.value,
        size: DefaultPage.size,
      ),
    );
    isLoading.value = true;
    ApiResponse<Users> response = await API.to.searchUser(userSearch);
    if(response.success) {
      userList.addAll(response.data?.list ?? []);
      isLastUser.value = response.data!.last;
    } else {
      print("searchUser error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }

  void onChangeTab(UiState state) {
    currentTab.value = state;
  }

  void onChangeSearch(String value) {
    hasValue.value = textEditingController.text.isNotEmpty;
  }

  void clearSearch() {
    textEditingController.clear();
    hasValue.value = false;
  }

  void moveToUserHome(int userIdx) {
    Utils.moveTo(
      UiState.USER_HOME_SCREEN,
      arg: {
        'userIdx': userIdx
      }
    );
  }
}