import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            InkWell(
              onTap: controller.logout,
              child: Row(
                children: [
                  Icon(
                    Icons.logout
                  ).marginOnly(right: 15),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        '로그아웃',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ).marginSymmetric(horizontal: 15)
      )
    );
  }
}