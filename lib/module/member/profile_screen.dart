import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/member/profile_controller.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_tff.dart';

class ProfileScreen extends GetView<ProfileX> {
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: BaseAppBar(
          title: controller.editMode.value ? '프로필 수정' : '프로필 정보',
          leading: Utils.iconButton(
            iconData: controller.editMode.value ? Icons.close : Icons.arrow_back,
            onPressed: controller.editMode.value ? controller.changeEditMode : () => Get.close(1)
          ),
          actions: [
            Utils.iconButton(
              iconData: controller.editMode.value ? Icons.check : Icons.edit,
              onPressed: controller.editMode.value ? () => print('등록') : controller.changeEditMode
            )
          ]
    
        ).init(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _image(),
                _inputs()
              ],
            )
          )
        )
      ),
    ));
  }

  Widget _image() {
    return Container();
  }

  Widget _inputs() {
    return Column(
      children: [
        BaseTextFormField(
          controller: controller.nickNameController,
          label: '닉네임',
          enabled: controller.editMode.value,
        ).marginSymmetric(horizontal: 15),
        BaseTextFormField(
          controller: controller.nameController,
          label: '이름',
          enabled: controller.editMode.value,
        ).marginSymmetric(horizontal: 15),
        BaseTextFormField(
          controller: controller.introduceController,
          label: '소개',
          enabled: controller.editMode.value,
        ).marginSymmetric(horizontal: 15)
      ],
    );
  }
}