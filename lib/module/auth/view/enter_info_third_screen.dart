import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/auth/controller/enter_info_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_tff.dart';
import 'package:map_together/widget/button_round.dart';

class EnterInfoThirdScreen extends GetView<EnterInfoX> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: BaseAppBar(
          title: '이름 및 소개 입력 (2/4)',
          leading: BaseButton.iconButton(
            iconData: Icons.arrow_back,
            onPressed: () => Get.close(1)
          )
        ).init(),
        body: _body()
      ),
    ));
  }

   Widget _body() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: MtColor.paleGrey,
            valueColor: AlwaysStoppedAnimation<Color>(MtColor.signature),
            minHeight: 5,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseTextFormField(
                controller: controller.nameController,
                label: '이름',
                maxLength: 16,
                allowWhiteSpace: false,
                onChanged: (value) => controller.onChangeName(value),
                enabled: true,
              ).marginOnly(left: 15, right: 15, bottom: 20),
              BaseTextFormField(
                controller: controller.introduceController,
                label: '소개',
                maxLength: 250,
                maxLines: 5,
                multiline: true,
                onChanged: (value) => controller.onChangeIntroduce(value),
                enabled: true,
              ).marginOnly(left: 15, right: 15, bottom: 20),
            ],
          ),
          ButtonRound(
          label: controller.isEmptyName.value && controller.isEmptyIntroduce.value ? '건너뛰기' : '다음',
          onTap: controller.moveToFourthScreen,
        ).marginAll(15),
        ],
      ),
    );
  }
}