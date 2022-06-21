import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/auth/controller/enter_info_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_tff.dart';
import 'package:map_together/widget/button_round.dart';

class EnterInfoSecondScreen extends GetView<EnterInfoX> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: BaseAppBar(
          title: '닉네임 입력 (1/4)',
        ).init(),
        body: WillPopScope(
          onWillPop: App.to.exitApp,
          child: _body()
        )
      ),
    ));
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LinearProgressIndicator(
            value: 0.25,
            backgroundColor: MtColor.paleGrey,
            valueColor: AlwaysStoppedAnimation<Color>(MtColor.signature),
            minHeight: 5,
          ),
          Row(
            children: [
              Flexible(
                child: BaseTextFormField(
                  controller: controller.nicknameController,
                  hintText: '닉네임은 6자 이상이어야 합니다.',
                  maxLength: 16,
                  allowWhiteSpace: false,
                  onChanged: (value) => controller.onChangeNickname(value),
                ),
              ),
              ButtonRound(
                label: '중복확인',
                onTap: controller.isValidNickname.value ? controller.checkExistUser : () {},
                buttonColor: controller.isValidNickname.value ? MtColor.signature : MtColor.paleGrey,
                textColor: controller.isValidNickname.value ? MtColor.white : MtColor.grey
              )
            ],
          ).marginOnly(left: 15, right: 15, bottom: 20),
          ButtonRound(
          label: '다음',
          onTap: controller.isValidNickname.value && controller.availableNickname.value ? controller.moveToThirdScreen : () {},
          buttonColor: controller.isValidNickname.value && controller.availableNickname.value ? MtColor.signature : MtColor.paleGrey,
          textColor: controller.isValidNickname.value && controller.availableNickname.value ? MtColor.white : MtColor.grey
        ).marginAll(15),
        ],
      ),
    );
  }
}