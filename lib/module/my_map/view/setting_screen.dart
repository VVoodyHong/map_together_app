import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/type/login_type.dart';
import 'package:map_together/module/my_map/controller/setting_controller.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';

class SettingScreen extends GetView<SettingX> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '설정',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        ),

      ).init(),
      body: _body()
    );
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            App.to.user.value.loginType != LoginType.KAKAO ?
            _tile(
              title: '비밀번호 변경',
              icon: Icons.lock_outline,
              onTap: controller.moveToChangePassword
            ) : Container(),
            _tile(
              title: '문의하기',
              icon: Icons.contact_support_outlined,
              onTap: controller.contact
            ),
            _tile(
              title: '로그아웃',
              icon: Icons.logout,
              onTap: controller.logout
            ),
            _tile(
              title: '회원탈퇴',
              icon: Icons.person_off_outlined,
              onTap: controller.deleteUser
            ),
          ],
        ).marginSymmetric(horizontal: 15)
      )
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required Function() onTap
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon
          ).marginOnly(right: 15),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}