import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/common/photo_uploader.dart';
import 'package:map_together/module/user/controller/profile_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_tff.dart';
import 'package:map_together/widget/button_round.dart';
import 'package:map_together/widget/image_round.dart';

class ProfileScreen extends GetView<ProfileX> {
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: BaseAppBar(
              title: '프로필 편집',
              leading: BaseButton.iconButton(
                iconData: Icons.arrow_back,
                onPressed: () => Get.close(1)
              ),

            ).init(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _image(context).marginSymmetric(vertical: 30),
                    _inputs()
                  ],
                )
              )
            )
          ),
          Utils.showLoading(isLoading: controller.isLoading.value)
        ],
      ),
    ));
  }

  Widget _image(BuildContext context) {
    switch(controller.photoType.value) {
      case PhotoType.CAMERA:
      case PhotoType.GALLERY:
        return ImageRound(
          file: File(PhotoUploader.to.uploadPath.value),
          editMode: true,
          onTap: () => controller.showDialog(context)
        );
      case PhotoType.DEFAULT:
        return ImageRound(
          editMode: true,
          onTap: () => controller.showDialog(context)
        );
      case PhotoType.NONE:
        return ImageRound(
          imagePath: App.to.user.value.profileImg,
          editMode: true,
          onTap: () => controller.showDialog(context)
        );
    }
  }

  Widget _inputs() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: BaseTextFormField(
                controller: controller.nicknameController,
                label: '닉네임',
                maxLength: 16,
                enabled: true,
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
        ).marginOnly(left: 15, right: 15, top: 10),
        BaseTextFormField(
          controller: controller.nameController,
          label: '이름',
          maxLength: 16,
          allowWhiteSpace: false,
          onChanged: (value) => controller.onChangeName(value),
          enabled: true,
        ).marginOnly(left: 15, right: 15, top: 10),
        BaseTextFormField(
          controller: controller.introduceController,
          label: '소개',
          maxLength: 250,
          maxLines: 5,
          multiline: true,
          onChanged: (value) => controller.onChangeIntroduce(value),
          enabled: true,
        ).marginOnly(left: 15, right: 15, top: 10, bottom: 30),
        ButtonRound(
          label: '완료',
          onTap: controller.isChangedNickname.value ?
            controller.availableNickname.value ?
              controller.updateUser :
              () {}
            : controller.isChangedOption.value ?
              controller.updateUser :
              () {},
          buttonColor: controller.isChangedNickname.value ?
            controller.availableNickname.value ? 
              MtColor.signature :
              MtColor.paleGrey
            : controller.isChangedOption.value ?
              MtColor.signature :
              MtColor.paleGrey,
          textColor: controller.isChangedNickname.value ?
            controller.availableNickname.value ? 
              MtColor.white :
              MtColor.grey
            : controller.isChangedOption.value ?
              MtColor.white :
              MtColor.grey
        ).marginAll(15),
      ],
    );
  }
}