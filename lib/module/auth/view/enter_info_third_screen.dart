import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/auth/controller/enter_info_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/button_round.dart';

class EnterInfoThirdScreen extends GetView<EnterInfoX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '완료 (2/2)',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        )
      ).init(),
      body: _body()
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LinearProgressIndicator(
            value: 1.0,
            backgroundColor: MtColor.paleGrey,
            valueColor: AlwaysStoppedAnimation<Color>(MtColor.signature),
            minHeight: 5,
          ),
          ButtonRound(
              label: '완료',
              onTap: controller.updateUser,
              buttonColor: MtColor.signature,
              textColor: MtColor.white
            ).marginAll(15),
        ],
      ),
    );
  }
}