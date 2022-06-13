// ignore_for_file: invalid_use_of_protected_member, prefer_null_aware_operators

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/module/user/controller/user_home_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_list_tile.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';
import 'package:map_together/widget/button_profile.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/button_round.dart';
import 'package:map_together/widget/image_round.dart';

class UserHomeScreen extends GetView<UserHomeX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
        title: controller.user?.value != null ? controller.user?.value.nickname ?? '' : '',
        titleWeight: FontWeight.bold,
        centerTitle: false,
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1),
        ),
        actions: [
          BaseButton.iconButton(
            iconData: Icons.menu,
            onPressed: () => BottomSheetModal.showList(
              context: context,
              listTiles: _listTiles(context)
            )
          )
        ]
      ).init(),
      body: SafeArea(
        child: Column(
          children: [
            _profile(),
            _userMap()
          ],
        ),
      )
    ));
  }

  Widget _profile() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
          child: Row(
            children: [
              ImageRound(
                imagePath: controller.user?.value != null ? controller.user?.value.profileImg : null
              ),
              Container(
                height: 115,
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        controller.user?.value != null ? controller.user?.value.name ?? '' : '',
                        style: TextStyle(
                          fontSize: FontSize.large,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        controller.user?.value != null ? controller.user?.value.introduce ?? '' : '',
                        style: TextStyle(
                          height: 1.1
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: MtColor.paleGrey,
                width: 0.5
              )
            )
          ),
          child: Row(
            children: [
              ButtonProfile(
                title: '장소',
                number: controller.placeList.value.length
              ),
              ButtonProfile(
                title: '팔로잉',
                number: 0
              ),
              ButtonProfile(
                title: '팔로워',
                number: 0 
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _userMap() {
    return Expanded(
      child: controller.position?.value != null ? NaverMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            controller.position!.value.latitude,
            controller.position!.value.longitude,
          ),
          zoom: controller.zoom.value
        ),
        locationButtonEnable: true,
        onMapCreated: controller.onMapCreated,
        onMapTap: controller.onMapTap,
        onSymbolTap: controller.onSymbolTap,
        markers: controller.markers.value
      ) : Container(),
    );
  }

  List<BaseListTile> _listTiles(BuildContext context) {
    return [
      BaseListTile(
        title: '카테고리 필터',
        onTap: () {showCategoryModal(context);},
        icon: Icons.filter_alt_outlined,
      )
    ];
  }

  void showCategoryModal(BuildContext context) {
    Get.close(1);
    controller.placeCategoryList.isNotEmpty ?
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          child: Container(
            width: Get.width * 0.5,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: controller.placeCategoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _imageTextField(index);
                    }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ButtonRound(
                        label: '완료',
                        onTap: controller.setSelectedPlaceCategory
                      ).marginOnly(left: 10, right: 5)
                    ),
                    Expanded(
                      child: ButtonRound(
                        label: '취소',
                        onTap: () {
                          Get.close(1);
                        },
                        buttonColor: MtColor.paleGrey,
                        textColor: MtColor.grey,
                      ).marginOnly(left: 5, right: 10)
                    )
                  ]
                )
              ]
            )
          )
        );
      }
    ).then((_) => {
      controller.tempSelectedPlaceCategory.value = controller.selectedPlaceCategory.value
    })
    : Utils.showToast('카테고리가 존재하지 않습니다.');
  }

  Widget _imageTextField(int index) {
    return Obx(() =>InkWell(
      onTap: () {controller.setTempSelectedPlaceCategory(index);},
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset().getMarker(controller.placeCategoryList[index].type.getValue()))
                )
              )
            ),
            Expanded(
              child: Text(
                controller.placeCategoryList[index].name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            index == controller.tempSelectedPlaceCategory.value ? Icon(
              Icons.check,
              color: MtColor.signature
            ) : Container()
          ],
        ),
      ),
    ));
  }
}
