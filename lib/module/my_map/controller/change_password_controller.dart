import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/user/user.dart';
import 'package:map_together/model/user/user_password.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';

class ChangePasswordX extends GetxController {
  static ChangePasswordX get to => Get.find();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void updatePassword() async {
    RegExp regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,}$');
    if(!regExp.hasMatch(newPasswordController.text)) {
      Utils.showToast('비밀번호 형식이 맞지 않습니다.');
      return;
    }
    UserPassword userPassword = UserPassword(
      currentPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
      confirmNewPassword: confirmNewPasswordController.text,
    );
    ApiResponse<User> response = await API.to.updatePassword(userPassword);
    if(response.success) {
      Utils.showToast('비밀번호가 변경되었습니다');
      Get.close(1);
    } else {
      print("updatePassword error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }
}