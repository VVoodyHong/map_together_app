import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/follow/controller/follow_home_controller.dart';
import 'package:map_together/module/follow/view/follower_screen.dart';
import 'package:map_together/module/follow/view/following_screen.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/finder_box.dart';

class FollowHomeScreen extends GetView<FollowHomeX> {

  late final String? uniqueTag;

  @override
  String? get tag => uniqueTag;

  FollowHomeScreen(String tag) {
    uniqueTag = tag;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: BaseAppBar(
              title: controller.userNickname.value,
              leading: BaseButton.iconButton(
                iconData: Icons.arrow_back,
                onPressed: () => Get.close(1)
              ),
              centerTitle: false,
            ).init(),
            body: SafeArea(
              child: _body()
            )
          ),
          Utils.showLoading(isLoading: controller.isLoading.value)
        ],
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
              label: '팔로워 ${controller.followerCount.value}명',
              onTap: () {controller.onChangeTab(UiState.FOLLOW_FOLLOWER);},
              isSelected: controller.currentTab.value == UiState.FOLLOW_FOLLOWER,
            ),
            _tabItem(
              label: '팔로잉 ${controller.followingCount.value}명',
              onTap: () {controller.onChangeTab(UiState.FOLLOW_FOLLOWING);},
              isSelected: controller.currentTab.value == UiState.FOLLOW_FOLLOWING,
            )
          ],
        ).marginSymmetric(horizontal: 20),
        FinderBox(
          controller: controller.currentTab.value == UiState.FOLLOW_FOLLOWER ? controller.followerSearchController : controller.followingSearchController,
          hintText: '검색어를 입력해주세요.',
          onSearch: controller.doSearch,
          hasValue: controller.currentTab.value == UiState.FOLLOW_FOLLOWER ? controller.followerHasValue.value : controller.followingHasValue.value,
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
      case UiState.FOLLOW_FOLLOWER: return uniqueTag != null ? FollowerScreen(uniqueTag!, controller) : Container();
      case UiState.FOLLOW_FOLLOWING: return uniqueTag != null ? FollowingScreen(uniqueTag!, controller) : Container();
      default: return Container();
    }
  }
}