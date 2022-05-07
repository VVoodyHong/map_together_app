import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/search/controller/search_home_controller.dart';
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
        body: SafeArea(
          child: _body().marginSymmetric(horizontal: 20)
        ),
        bottomNavigationBar: BottomNav(),
      ),
    ));
  }

  Widget _body() {
    return Column(
      children: [
        FinderBox(
          controller: controller.textEditingController,
          onSearch: controller.doSearch,
          hasValue: controller.hasValue.value,
          onChanged: controller.onChangeSearch,
          clear: controller.clearSearch
        ),
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
        ),
        _list()
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
          decoration: isSelected
          ? BoxDecoration(
              border: Border(
              bottom: BorderSide(
                width: 3,
                color: MtColor.black
              )
            )
          )
          : BoxDecoration(
              border: Border(
              bottom: BorderSide(
                width: 3,
                color: MtColor.transparent
              )
            )
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected ? MtColor.black : MtColor.grey,
              fontSize: 18
            ),
            textAlign: TextAlign.center,
          )
        )
      ).marginSymmetric(horizontal: 10)
    );
  }

  Widget _list() {
    switch(controller.currentTab.value) {
      case UiState.SEARCH_USER: return Container();
      case UiState.SEARCH_PLACE: return Container();
      default: return Container();
    }
  }
}