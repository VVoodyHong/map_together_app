import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/auth/controller/enter_info_controller.dart';
import 'package:map_together/utils/constants.dart';

class EnterInfoFirstScreen extends GetView<EnterInfoX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: App.to.exitApp,
        child: _body()
      )
    );
  }

  Widget _body() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText(
                  '안녕하세요.',
                  textStyle: TextStyle(
                    fontSize: 25,
                    color: MtColor.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TypewriterAnimatedText(
                  '맵투게더',
                  textStyle: TextStyle(
                    fontSize: 25,
                    color: MtColor.signature,
                    fontWeight: FontWeight.w500,
                  ),
                  cursor: '',
                  speed: Duration(milliseconds: 100),
                ),
                FadeAnimatedText(
                  '입니다.',
                  textStyle: TextStyle(
                    fontSize: 25,
                    color: MtColor.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FadeAnimatedText(
                  '맵투게더 이용을 위해',
                  textStyle: TextStyle(
                    fontSize: 25,
                    color: MtColor.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FadeAnimatedText(
                  '간단한 기본정보를 입력할게요.',
                  textStyle: TextStyle(
                    fontSize: 25,
                    color: MtColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                WavyAnimatedText(
                  '30초면 끝나요!',
                  speed: Duration(milliseconds: 200),
                  textStyle: TextStyle(
                    fontSize: 25,
                    color: MtColor.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  )
                )
              ],
              pause: Duration(milliseconds: 0),
              totalRepeatCount: 1,
              onFinished: controller.moveToSecondScreen
            ),
          ],
        ),
      )
    );
  }
}