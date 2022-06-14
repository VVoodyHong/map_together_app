import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/search/controller/search_home_controller.dart';
import 'package:map_together/module/search/view/search_place_screen.dart';
import 'package:map_together/module/search/view/search_user_screen.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/bottom_nav.dart';
import 'package:map_together/widget/finder_box.dart';

class SearchHomeScreen extends GetView<SearchHomeX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: BaseAppBar(
          title: '검색',
          titleWeight: FontWeight.bold,
          centerTitle: false,
        ).init(),
        body: WillPopScope(
          onWillPop: App.to.exitApp,
          child: SafeArea(
            child: _body()
          ),
        ),
        bottomNavigationBar: BottomNav(),
      ),
    ));
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _tabItem(
              label: '계정',
              onTap: () {controller.onChangeTab(UiState.SEARCH_USER);},
              isSelected: controller.currentTab.value == UiState.SEARCH_USER,
            ),
            _tabItem(
              label: '장소',
              onTap: () {controller.onChangeTab(UiState.SEARCH_PLACE);},
              isSelected: controller.currentTab.value == UiState.SEARCH_PLACE,
            )
          ],
        ).marginSymmetric(horizontal: 20),
        FinderBox(
          controller: controller.searchController,
          hintText: '검색어를 입력해주세요.',
          onSearch: controller.doSearch,
          hasValue: controller.hasValue.value,
          onChanged: controller.onChangeSearch,
          clear: controller.clearSearch
        ).marginSymmetric(horizontal: 20, vertical: 10),
        Expanded(child: _list())
      ],
    );
  }

  Widget _tabItem({
    required String label,
    required VoidCallback onTap,
    required bool isSelected
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected ? MtColor.black : MtColor.grey.withOpacity(0.5),
              fontSize: 18
            ),
            textAlign: TextAlign.center,
          )
        )
      )
    );
  }

  Widget _list() {
    switch(controller.currentTab.value) {
      case UiState.SEARCH_USER: return SearchUserScreen();
      case UiState.SEARCH_PLACE: return SearchPlaceScreen();
      default: return Container();
    }
  }
}