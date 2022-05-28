import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/api_response.dart';
import 'package:map_together/model/request/user_update.dart';
import 'package:map_together/model/type/exist_type.dart';
import 'package:map_together/model/user.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';

class ProfileX extends GetxController {
  static ProfileX get to => Get.find();

  RxBool isValidNickname = false.obs;
  RxBool availableNickname = false.obs;
  RxBool isChangedNickname = false.obs;
  RxBool isChangedOption = false.obs;

  TextEditingController nicknameController = TextEditingController(text: App.to.user.value.nickname);
  TextEditingController nameController = TextEditingController(text: App.to.user.value.name);
  TextEditingController introduceController = TextEditingController(text: App.to.user.value.introduce);

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

  void checkExistUser() async {
    await API.to.checkExistUser(nicknameController.text, ExistType.NICKNAME).then((res) {
      ApiResponse<void>? response = res.body;
      if(response != null) {
        if(response.success) {
          availableNickname.value = true;
          Utils.showToast('사용 가능한 닉네임입니다.');
        } else {
          availableNickname.value = false;
          Exception("checkExistUser error:: ${response.code} ${response.message}");
          Utils.showToast(response.message);
        }
      } else {
        print("checkExistUser error:: ${res.statusCode} ${res.statusText}");
        Utils.showToast("서버 통신 중 오류가 발생했습니다.");
      }
    });
  }

   void updateUser() async {
    UserUpdate userUpdate = UserUpdate(
      nickname: nicknameController.text,
      name: nameController.text,
      introduce: introduceController.text
    );
    await API.to.updateUser(App.to.user.value.idx!, userUpdate).then((res) {
      ApiResponse<User>? response = res.body;
      if(response != null) {
        if(response.success) {
          App.to.user.value = response.data!;
          Utils.showToast('프로필 수정이 완료되었습니다.');
          Get.close(1);
        } else {
          print("signUp error:: ${response.code} ${response.message}");
          Utils.showToast(response.message);
        }
      } else {
        print("signUp error:: ${res.statusCode} ${res.statusText}");
        Utils.showToast("서버 통신 중 오류가 발생했습니다.");
      }
    });
  }
}