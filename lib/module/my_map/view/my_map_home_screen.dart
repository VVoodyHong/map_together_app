// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/my_map/controller/my_map_home_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_list_tile.dart';
import 'package:map_together/widget/bottom_nav.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';
import 'package:map_together/widget/button_profile.dart';
import 'package:map_together/widget/base_app_bar.dart';
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
              listTiles: _listTiles()
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
                number: '0'
              ),
              ButtonProfile(
                title: '팔로잉',
                number: '0'
              ),
              ButtonProfile(
                title: '팔로워',
                number: '0'
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

  List<BaseListTile> _listTiles() {
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
      )
    ];
  }
}
