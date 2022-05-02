import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/model/request/user_create.dart';
import 'package:map_together/rest/api.dart';

class SignupX extends GetxController {
  static SignupX get to => Get.find();

  RxBool isValidLoginId = false.obs;
  RxBool isValidPassword = false.obs;
  RxBool isValidConfirmPassword = false.obs;

  TextEditingController loginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void onChangeLoginId(String loginId) {
    RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(regExp.hasMatch(loginId)) {
      isValidLoginId.value = true;
    } else {
      if(isValidLoginId.value) isValidLoginId.value = false;
    }
  }

  void onChangePassword(String password) {
    RegExp regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,}$');
    if(regExp.hasMatch(password)) {
      isValidPassword.value = true;
    } else {
      if(isValidPassword.value) isValidPassword.value = false;
    }
  }

  void onChangeConfirmPassword(String confirmPassword) {
    print(passwordController.text.compareTo(confirmPasswordController.text));
    if(passwordController.text.compareTo(confirmPasswordController.text) == 0) {
      isValidConfirmPassword.value = true;
    } else {
      if(isValidConfirmPassword.value) isValidConfirmPassword.value = false;
    }
  }

  void signUp() async {
    UserCreate userCreate = UserCreate(
      loginId: loginIdController.text,
      nickname: loginIdController.text,
      password: passwordController.text,
    );
    await API.to.signUp(userCreate).then((res) {
      print(res.body);
    });
  }
}