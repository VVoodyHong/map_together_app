import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/my_map_home_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/bottom_nav.dart';
import 'package:map_together/widget/btn_profile.dart';
import 'package:map_together/widget/base_app_bar.dart';

class MyMapHomeScreen extends GetView<MyMapHomeX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
        title: 'w8kjeong',
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            splashRadius: 24,
            onPressed: () {_onPressMenu(context);},
          )
        ]
      ).init(),
      body: SafeArea(
        child: Column(
          children: [
            _profile(),
            _myMap()
          ],
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
              ClipOval(
                child: SizedBox(
                  height: 110,
                  width: 110,
                  child: Image.asset(
                    Asset.profile,
                    fit: BoxFit.cover
                  ),
                )
              ),
              Expanded(
                child: Container(
                  height: 110,
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: 5 ),
                        child: Text(
                          '홍정욱',
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
                          '반갑습니다😄\n나만의 여행일지✈\nhju4287@naver.com',
                          style: TextStyle(
                            height: 1.3
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
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
              BtnProfile(
                title: 'place',
                number: '0'
              ),
              BtnProfile(
                title: 'following',
                number: '0'
              ),
              BtnProfile(
                title: 'follower',
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
        initialCameraPosition: controller.cameraPosition.value,
        locationButtonEnable: true,
        onMapCreated: controller.onMapCreated,
        onMapTap: controller.onMapTap,
        onSymbolTap: controller.onSymbolTap,
      ),
    );
  }

  void _onPressMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20)
        )
      ),
      builder: (context) {
        return Container(
          height: 180,
          color: Colors.transparent,
          child: _buildBottomNavigationMenu()
        );
      }
    );
  }

  Widget _buildBottomNavigationMenu() {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.person_outline,
            color: MtColor.black
          ),
          title: Text(
            '프로필 편집',
            style: TextStyle(
              fontWeight: FontWeight.w500
            )
          ),
          onTap: () => Get.close(1),
        ),
        ListTile(
          leading: Icon(
            Icons.map_outlined,
            color: MtColor.black
          ),
          title: Text(
            '나의 맵 설정',
            style: TextStyle(
              fontWeight: FontWeight.w500
            )
          ),
          onTap: () => Get.close(1),
        ),
        ListTile(
          leading: Icon(
            Icons.star_outline,
            color: MtColor.black
          ),
          title: Text(
            '즐겨찾기',
            style: TextStyle(
              fontWeight: FontWeight.w500
            )
          ),
          onTap: () => Get.close(1),
        ),
      ]
    );
  }
}
