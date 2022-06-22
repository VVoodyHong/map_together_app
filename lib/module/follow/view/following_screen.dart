import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/follow/follow_simple.dart';
import 'package:map_together/module/follow/controller/follow_home_controller.dart';
import 'package:map_together/widget/empty_view.dart';
import 'package:map_together/widget/image_round.dart';

class FollowingScreen extends StatelessWidget {

  late final String uniqueTag;
  late final FollowHomeX controller;

  FollowingScreen(String _tag, FollowHomeX _controller) {
    uniqueTag = _tag;
    controller = _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.followingList.isNotEmpty ? SingleChildScrollView(
      key: PageStorageKey<String>('following'),
      controller: controller.followingScrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _userList()
      )
    ) : !controller.isLoading.value ? EmptyView(text: '팔로잉이 없습니다.') : Container()).marginSymmetric(horizontal: 20);
  }

  List<Widget> _userList() {
    List<Widget> _list = [];
    for (FollowSimple follow in controller.followingList) {
      _list.add(
        InkWell(
          onTap: () {follow.idx != App.to.user.value.idx ? controller.moveToUserHome(follow.idx) : () {};},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageRound(
                imagePath: follow.profileImg,
                imageSize: 70
              ),
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        follow.nickname,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        follow.name ?? '',
                        style: TextStyle(
                          fontSize: 15
                        ),
                      ).marginOnly(top: 5),
                    ],
                  )
                ).marginOnly(left: 10),
              ),
            ],
          ).marginOnly(top: 15),
        )
      );
    }
    return _list;
  }
}