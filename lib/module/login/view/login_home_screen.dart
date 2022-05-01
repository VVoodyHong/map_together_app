import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/login/controller/login_home_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/button_round.dart';
import 'package:map_together/widget/button_text.dart';
import 'package:map_together/widget/login_ttf.dart';

class LoginHomeScreen extends GetView<LoginHomeX> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: WillPopScope(
          onWillPop: App.to.exitApp,
          child: _body()
        )
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
            hintText: "이메일",
          ).marginOnly(left: 30, right: 30, top: 10),
          LoginTextFormField(
            controller: controller.passwordController,
            hintText: "비밀번호",
            obscureText: true
          ).marginOnly(left: 30, right: 30, top: 10),
          ButtonRound(
            label: "로그인",
            onTap: controller.defaultLogin,
          ).marginOnly(left: 30, right: 30, top: 30),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  label: "회원가입",
                  onTap: () {}
                )
              ],
            ).marginOnly(right: 30),
          ),
          ButtonRound(
            label: "카카오 계정으로 간편 로그인",
            onTap: controller.kakaoLogin,
            buttonColor: MtColor.kakao,
            textColor: MtColor.black,
          ).marginOnly(left: 30, right: 30, top: 30),
          // Row(
          //   children: [
          //     Expanded(
          //       child: ButtonText(
          //         label: "아이디 찾기",
          //         onTap: () {}
          //       ),
          //     ),
          //     Expanded(
          //       child: ButtonText(
          //         label: "비밀번호 찾기",
          //         onTap: () {}
          //       ),
          //     ),
          //     Expanded(
          //       child: ButtonText(
          //         label: "간편 회원가입",
          //         onTap: () {}
          //       ),
          //     )
          //   ],
          // ).marginOnly(left: 30, right: 30),
        ],
      )
    );
  }
}
