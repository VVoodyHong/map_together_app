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

  void onChangeNickname(String nickname) {
    availableNickname.value = false;
    RegExp regExp = RegExp(r'^[0-9a-zA-Z\s+._]{6,}$');
    if(regExp.hasMatch(nickname)) {
      isValidNickname.value = true;
    } else {
      if(isValidNickname.value) isValidNickname.value = false;
    }
  }

  void checkExistUser() async {
    ApiResponse<void> response = await API.to.checkExistUser(nicknameController.text, ExistType.NICKNAME);
    if(response.success) {
      availableNickname.value = true;
      Utils.showToast('사용 가능한 닉네임입니다.');
    } else {
      availableNickname.value = false;
      Exception("checkExistUser error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void updateUser() async {
    UserUpdate userUpdate = UserUpdate(
      nickname: nicknameController.text
    );
    ApiResponse<User> response = await API.to.updateUser(userUpdate, null);
    if(response.success) {
      App.to.user.value = response.data!;
      UiLogic.changeUiState(UiState.MYMAP_HOME);
    } else {
      print("updateUser error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void moveToSecondScreen() {
    Utils.moveTo(UiState.ENTER_INFO_SECOND);
  }

  void moveToThirdScreen() {
    Utils.moveTo(UiState.ENTER_INFO_THIRD);
  }
}