// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/module/my_map/controller/my_map_home_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_list_tile.dart';
import 'package:map_together/widget/bottom_nav.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';
import 'package:map_together/widget/button_profile.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/button_round.dart';
import 'package:map_together/widget/image_round.dart';

class MyMapHomeScreen extends GetView<MyMapHomeX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
        title: App.to.user.value.nickname ?? '',
        titleWeight: FontWeight.bold,
        centerTitle: false,
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
      body: WillPopScope(
        onWillPop: App.to.exitApp,
        child: SafeArea(
          child: Column(
            children: [
              _profile(),
              _myMap()
            ],
          ),
        ),
      ),
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: BottomNav(),
    ));
  }

  Widget _floatingActionButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: FloatingActionButton(
        elevation: 2,
        backgroundColor: MtColor.signature,
        child: Icon(
          !controller.createMode.value ? Icons.add : Icons.clear,
          color: MtColor.white,
          size: 35,
        ),
        onPressed: controller.onPressCreate,
      ),
    );
  }

  Widget _profile() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
          child: Row(
            children: [
              ImageRound(
                imagePath: App.to.user.value.profileImg
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
                        App.to.user.value.name ?? '',
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
                        App.to.user.value.introduce ?? '',
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

  Widget _myMap() {
    return Expanded(
      child: NaverMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            controller.position.value.latitude,
            controller.position.value.longitude,
          ),
          zoom: controller.zoom.value
        ),
        locationButtonEnable: true,
        onMapCreated: controller.onMapCreated,
        onMapTap: controller.onMapTap,
        onSymbolTap: controller.onSymbolTap,
        markers: controller.markers.value
      ),
    );
  }

  List<BaseListTile> _listTiles(BuildContext context) {
    return [
      BaseListTile(
        title: '프로필 편집',
        onTap: controller.moveToProfile,
        icon: Icons.person_outline
      ),
      BaseListTile(
        title: '나의 맵 설정',
        onTap: controller.moveToSetting,
        icon: Icons.map_outlined,
      ),
      BaseListTile(
        title: '카테고리 필터',
        onTap: () {showCategoryModal(context);},
        icon: Icons.filter_alt_outlined,
      )
    ];
  }

  void showCategoryModal(BuildContext context) {
    Get.close(1);
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
    });
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
