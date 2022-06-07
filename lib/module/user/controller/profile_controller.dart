import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/type/exist_type.dart';
import 'package:map_together/model/user/user.dart';
import 'package:map_together/model/user/user_update.dart';
import 'package:map_together/module/common/photo_uploader.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';

class ProfileX extends GetxController {
  static ProfileX get to => Get.find();

  Rx<PhotoType> photoType = PhotoType.NONE.obs;

  RxBool isValidNickname = false.obs;
  RxBool availableNickname = false.obs;
  RxBool isChangedNickname = false.obs;
  RxBool isChangedOption = false.obs;

  RxBool isLoading = false.obs;

  TextEditingController nicknameController = TextEditingController(text: App.to.user.value.nickname);
  TextEditingController nameController = TextEditingController(text: App.to.user.value.name);
  TextEditingController introduceController = TextEditingController(text: App.to.user.value.introduce);

  @override
  void onInit() {
    super.onInit();
    PhotoUploader.to.init();
  }

  void onChangeNickname(String nickName) {
    availableNickname.value = false;
    isChangedNickname.value = true;
    if(nickName ==  App.to.user.value.nickname) {
      isValidNickname.value = false;
      isChangedNickname.value = false;
      return;
    }
    RegExp regExp = RegExp(r'^[0-9a-zA-Z\s+._]{6,16}$');
    if(regExp.hasMatch(nickName)) {
      isValidNickname.value = true;
    } else {
      if(isValidNickname.value) isValidNickname.value = false;
    }
  }

  void onChangeName(String name) {
    if(name ==  App.to.user.value.name && introduceController.text == App.to.user.value.introduce) {
      isChangedOption.value = false;
      return;
    }
    isChangedOption.value = true;
  }

  void onChangeIntroduce(String introduce) {
    if(introduce ==  App.to.user.value.introduce && nameController.text == App.to.user.value.name) {
      isChangedOption.value = false;
      return;
    }
    isChangedOption.value = true;
  }

  void showDialog(BuildContext context) {
    FocusScope.of(context).unfocus();
    PhotoUploader.to.showDialog(context).then((photoType) => {
      if(photoType != null) {
        this.photoType.value = photoType,
        isChangedOption.value = true
      }
    });
  }

  void checkExistUser() async {
    isLoading.value = true;
    ApiResponse<void> response = await API.to.checkExistUser(nicknameController.text, ExistType.NICKNAME);
    if(response.success) {
      availableNickname.value = true;
      Utils.showToast('사용 가능한 닉네임입니다.');
    } else {
      availableNickname.value = false;
      Exception("checkExistUser error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }

   void updateUser() async {
    String? profileImg = photoType.value == PhotoType.DEFAULT ? "default" : null;
    UserUpdate userUpdate = UserUpdate(
      nickname: nicknameController.text,
      name: nameController.text,
      profileImg: profileImg,
      introduce: introduceController.text
    );
    File? file = photoType.value == PhotoType.DEFAULT || photoType.value == PhotoType.NONE ? null : File(PhotoUploader.to.uploadPath.value);
    isLoading.value = true;
    ApiResponse<User> response = await API.to.updateUser(userUpdate, file);
    if(response.success) {
      App.to.user.value = response.data!;
      Utils.showToast('프로필 수정이 완료되었습니다.');
      Get.close(1);
    } else {
      print("signUp error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }
}