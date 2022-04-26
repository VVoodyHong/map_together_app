import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/member/controller/profile_controller.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_list_tile.dart';
import 'package:map_together/widget/base_tff.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';
import 'package:map_together/widget/image_round.dart';

class ProfileScreen extends GetView<ProfileX> {
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          if(controller.editMode.value) {
            controller.editMode.value = false;
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          appBar: BaseAppBar(
            title: controller.editMode.value ? '프로필 수정' : '프로필 정보',
            leading: BaseButton.iconButton(
              iconData: controller.editMode.value ? Icons.close : Icons.arrow_back,
              onPressed: controller.editMode.value ? controller.changeEditMode : () => Get.close(1)
            ),
            actions: [
              BaseButton.iconButton(
                iconData: controller.editMode.value ? Icons.check : Icons.edit,
                onPressed: controller.editMode.value ? () => print('등록') : controller.changeEditMode
              )
            ]
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
      ),
    ));
  }

  Widget _image(BuildContext context) {
    return ImageRound(
      editMode: controller.editMode.value,
      onTap: () => BottomSheetModal.show(
        context: context,
        listTiles: _listTiles()
      )
    );
  }

  Widget _inputs() {
    return Column(
      children: [
        BaseTextFormField(
          controller: controller.nickNameController,
          label: '닉네임',
          enabled: controller.editMode.value,
        ).marginOnly(left: 15, right: 15, top: 10),
        BaseTextFormField(
          controller: controller.nameController,
          label: '이름',
          enabled: controller.editMode.value,
        ).marginOnly(left: 15, right: 15, top: 10),
        BaseTextFormField(
          controller: controller.introduceController,
          label: '소개',
          enabled: controller.editMode.value,
        ).marginOnly(left: 15, right: 15, top: 10),
      ],
    );
  }

  List<BaseListTile> _listTiles() {
    return [
      BaseListTile(
        title: '앨범에서 사진 선택',
        onTap: () => Get.close(1),
      ),
      BaseListTile(
        title: '카메라 촬영',
        onTap: () => Get.close(1),
      ),
      BaseListTile(
        title: '기본 이미지로 변경',
        onTap: () => Get.close(1),
      )
    ];
  }
}