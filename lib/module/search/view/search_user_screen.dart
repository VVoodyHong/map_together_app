import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/search/controller/search_home_controller.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/image_round.dart';

class SearchUserScreen extends GetView<SearchHomeX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        SingleChildScrollView(
          controller: controller.userScrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _userList()
          ),
        ),
        Utils.showLoading(isLoading: controller.isLoading.value)
      ],
    )).marginSymmetric(horizontal: 20);
  }

  List<Widget> _userList() {
    List<Widget> _list = [];
    for (var user in controller.userList) {
      if(user.idx != App.to.user.value.idx) {
        _list.add(
          InkWell(
            onTap: () {controller.moveToUserHome(user.idx);},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageRound(
                  imagePath: user.profileImg,
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
                          user.nickname,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          user.name ?? '',
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
    }
    return _list;
  }
}