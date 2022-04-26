import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/login/controller/login_home_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/button_round.dart';
import 'package:map_together/widget/login_ttf.dart';

class LoginHomeScreen extends GetView<LoginHomeX> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: _body()
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "MAP TOGETHER",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: MtColor.signature
            )
          ),
          SizedBox(height: 50),
          LoginTextFormField(
            controller: controller.loginIdController,
            hintText: "아이디",
          ).marginOnly(left: 30, right: 30, top: 10),
          LoginTextFormField(
            controller: controller.passwordController,
            hintText: "비밀번호",
            obscureText: true
          ).marginOnly(left: 30, right: 30, top: 10),
          ButtonRound(
            label: "로그인",
            onTap: () {print('로그인');}
          ).marginOnly(left: 30, right: 30, top: 30),
        ],
      )
    );
  }
}
