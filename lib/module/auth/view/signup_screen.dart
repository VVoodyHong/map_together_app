import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/auth/controller/signup_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_tff.dart';
import 'package:map_together/widget/button_round.dart';

class SignupScreen extends GetView<SignupX> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        GestureDetector(
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: BaseAppBar(
              title: '회원가입',
              leading: BaseButton.iconButton(
                iconData: Icons.arrow_back,
                onPressed: () => Get.close(1)
              )
            ).init(),
            body: _body(),
          ),
        ),
        Utils.showLoading(isLoading: controller.isLoading.value)
      ],
    ));
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: BaseTextFormField(
                    controller: controller.loginIdController,
                    label: '아이디',
                    maxLength: 64,
                    allowWhiteSpace: false,
                    onChanged: (value) => controller.onChangeLoginId(value),
                  ),
                ),
                ButtonRound(
                  label: '중복확인',
                  onTap: controller.isValidLoginId.value ? controller.checkExistUser : () {},
                  buttonColor: controller.isValidLoginId.value ? MtColor.signature : MtColor.paleGrey,
                  textColor: controller.isValidLoginId.value ? MtColor.white : MtColor.grey
                )
              ],
            ).marginOnly(left: 15, right: 15, bottom: 20),
            controller.availableLoginId.value ?
              !controller.isVaildAuthCode.value ?
                Row(
                  children: [
                    Flexible(
                      child: BaseTextFormField(
                        controller: controller.authEmailController,
                        label: '인증번호',
                        maxLength: 64,
                        allowWhiteSpace: false,
                        onChanged: (value) {}
                      ),
                    ),
                    !controller.isSend.value ? ButtonRound(
                      label: '인증번호 전송',
                      onTap: controller.authEmail,
                    ) : ButtonRound(
                      label: '인증하기',
                      onTap: controller.checkAuthCode,
                    )
                  ],
                ).marginOnly(left: 15, right: 15, bottom: 20)
              : Container()
            : Container(),
            BaseTextFormField(
              controller: controller.passwordController,
              label: '비밀번호',
              obscureText: true,
              allowWhiteSpace: false,
              maxLength: 64,
              onChanged: (value) => controller.onChangePassword(value),
            ).marginSymmetric(horizontal: 15),
            BaseTextFormField(
              controller: controller.confirmPasswordController,
              label: '비밀번호 확인',
              obscureText: true,
              allowWhiteSpace: false,
              maxLength: 64,
              onChanged: (value) => controller.onChangeConfirmPassword(value),
            ).marginSymmetric(horizontal: 15),
            _confirmText(
              text: '아이디는 이메일 형식으로 입력해주세요.',
              isValid: controller.isValidLoginId.value
            ),
            _confirmText(
              text: '아이디 중복체크를 해주세요.',
              isValid: controller.availableLoginId.value
            ),
            _confirmText(
              text: '이메일 인증을 완료해주세요.',
              isValid: controller.isVaildAuthCode.value
            ),
            _confirmText(
              text: '문자, 숫자, 특수문자 포함 8자 이상으로 입력해주세요.',
              isValid: controller.isValidPassword.value
            ),
            _confirmText(
              text: '비밀번호를 한번 더 입력해여 확인해주세요.',
              isValid: controller.isValidConfirmPassword.value
            ),
            ButtonRound(
              label: '회원가입',
              onTap: controller.isValidLoginId.value && controller.isValidPassword.value && controller.isVaildAuthCode.value && controller.isValidConfirmPassword.value && controller.availableLoginId.value ? controller.signUp : () {},
              buttonColor: controller.isValidLoginId.value && controller.isValidPassword.value && controller.isVaildAuthCode.value && controller.isValidConfirmPassword.value && controller.availableLoginId.value ? MtColor.signature : MtColor.paleGrey,
              textColor: controller.isValidLoginId.value && controller.isValidPassword.value && controller.isVaildAuthCode.value && controller.isValidConfirmPassword.value && controller.availableLoginId.value ? MtColor.white : MtColor.grey
            ).marginAll(15),
          ],
        ),
      )
    );
  }

  Widget _confirmText({required String text, required bool isValid}) {
    return Row(
      children: [
        Icon(
          Icons.check,
          color: isValid ? MtColor.signature : MtColor.grey
        ).marginOnly(right: 5),
        Expanded(
          child: AutoSizeText(
            text,
            style: TextStyle(
              color: isValid ? MtColor.black : MtColor.grey
            ),
            maxLines: 1,
          ),
        )
      ],
    ).marginOnly(left: 15, bottom: 5);
  }
}