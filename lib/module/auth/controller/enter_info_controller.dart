import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/api_response.dart';
import 'package:map_together/model/request/user_update.dart';
import 'package:map_together/model/type/exist_type.dart';
import 'package:map_together/model/user.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';

class EnterInfoX extends GetxController {
  static EnterInfoX get to => Get.find();


  RxBool isValidNickname = false.obs;
  RxBool availableNickname = false.obs;

  TextEditingController nicknameController = TextEditingController();

  void onChangeNickname(String loginId) {
    availableNickname.value = false;
    RegExp regExp = RegExp(r'^[0-9a-zA-Z\s+._]{6,}$');
    if(regExp.hasMatch(loginId)) {
      isValidNickname.value = true;
    } else {
      if(isValidNickname.value) isValidNickname.value = false;
    }
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
      nickname: nicknameController.text
    );
    await API.to.updateUser(App.to.user.value.idx!, userUpdate).then((res) {
      ApiResponse<User>? response = res.body;
      if(response != null) {
        if(response.success) {
          App.to.user.value = response.data!;
          UiLogic.changeUiState(UiState.MYMAP_HOME);
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

  void moveToSecondScreen() {
    Utils.moveTo(UiState.ENTER_INFO_SECOND);
  }

  void moveToThirdScreen() {
    Utils.moveTo(UiState.ENTER_INFO_THIRD);
  }
}