import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/common/photo_uploader.dart';
import 'package:map_together/module/auth/controller/enter_info_controller.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/button_round.dart';
import 'package:map_together/widget/image_round.dart';
import 'package:map_together/widget/step_progress_indicator.dart';

class EnterInfoFourthScreen extends GetView<EnterInfoX> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
        title: '프로필 사진 선택',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        )
      ).init(),
      body: _body(context)
    ));
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StepProgressIndicator(
            currentLevel: 3,
            totalLevel: 4
          ).marginSymmetric(horizontal: 40, vertical: 20),
          _image(context),
          ButtonRound(
          label: controller.photoType.value == PhotoType.DEFAULT || controller.photoType.value == PhotoType.NONE ? '건너뛰기' : '다음',
          onTap: controller.moveToFifthScreen,
        ).marginAll(15),
        ],
      ),
    );
  }

  Widget _image(BuildContext context) {
    switch(controller.photoType.value) {
      case PhotoType.CAMERA:
      case PhotoType.GALLERY:
        return ImageRound(
          file: File(PhotoUploader.to.uploadPath.value),
          imageSize: 150,
          editMode: true,
          onTap: () => controller.showDialog(context)
        );
      case PhotoType.DEFAULT:
        return ImageRound(
          editMode: true,
          imageSize: 150,
          onTap: () => controller.showDialog(context)
        );
      case PhotoType.NONE:
        return ImageRound(
          imageSize: 150,
          editMode: true,
          onTap: () => controller.showDialog(context)
        );
    }
  }
}