import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/change_password_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_tff.dart';
import 'package:map_together/widget/button_round.dart';

class ChangePasswordScreen extends GetView<ChangePasswordX> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: BaseAppBar(
          title: '비밀번호 변경',
          leading: BaseButton.iconButton(
            iconData: Icons.arrow_back,
            onPressed: () => Get.close(1)
          ),
    
        ).init(),
        body: _body()
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextFormField(
              controller: controller.currentPasswordController,
              label: '현재 비밀번호',
              obscureText: true,
              allowWhiteSpace: false,
              maxLength: 64,
            ).marginSymmetric(horizontal: 15),
            SizedBox(height: 20),
            BaseTextFormField(
              controller: controller.newPasswordController,
              label: '새 비밀번호',
              obscureText: true,
              allowWhiteSpace: false,
              maxLength: 64,
            ).marginSymmetric(horizontal: 15),
            SizedBox(height: 20),
            BaseTextFormField(
              controller: controller.confirmNewPasswordController,
              label: '새 비밀번호 확인',
              obscureText: true,
              allowWhiteSpace: false,
              maxLength: 64,
            ).marginSymmetric(horizontal: 15),
            SizedBox(height: 10),
            AutoSizeText(
              '문자, 숫자, 특수문자 포함 8자 이상으로 입력해주세요.',
              style: TextStyle(
                color: MtColor.paleBlack
              ),
              maxLines: 1,
            ).marginSymmetric(horizontal: 15),
            SizedBox(height: 20),
            ButtonRound(
              label: '변경',
              onTap: controller.updatePassword
            ).marginAll(15),
          ],
        ),
      )
    );
  }
}