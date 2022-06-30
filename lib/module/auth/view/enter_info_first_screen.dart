import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/auth/controller/enter_info_controller.dart';
import 'package:map_together/module/my_map/view/terms_and_policy/privacy_statement_screen.dart';
import 'package:map_together/module/my_map/view/terms_and_policy/terms_of_location_service_screen.dart';
import 'package:map_together/module/my_map/view/terms_and_policy/terms_of_service_screen.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';
import 'package:map_together/widget/button_round.dart';

class EnterInfoFirstScreen extends GetView<EnterInfoX> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
          title: '',
        ).init(),
      body: WillPopScope(
        onWillPop: App.to.exitApp,
        child: _body(context)
      )
    ));
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '맵투게더',
                    style: TextStyle(
                      fontSize: 25,
                      color: MtColor.signature,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '에',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ).marginOnly(bottom: 10),
              Text(
                '오신 것을 환영합니다!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ).marginOnly(bottom: 20),
              Text(
                '맵투게더를 이용하기 위해 다음 약관에 동의해주세요.',
                style: TextStyle(
                  fontSize: 16,
                  color: MtColor.paleBlack,
                  fontWeight: FontWeight.w500,
                ),
              ).marginOnly(bottom: 40),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                decoration: BoxDecoration(
                  color: MtColor.paleGrey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _checkWidget(
                      title: '개인정보 처리방침 (필수)',
                      checked: controller.isCheckedPrivacyStatement.value,
                      onPressedIcon: controller.onChangePrivacyStatement,
                      onPressedTitle: () {
                        BottomSheetModal.showWidget(
                          context: context,
                          widget: PrivacyStatementScreen()
                        );
                      },
                    ).marginOnly(bottom: 40),
                    _checkWidget(
                      title: '서비스 이용 약관 (필수)',
                      checked: controller.isCheckedTermsOfService.value,
                      onPressedIcon: controller.onChangeTermsOfService,
                      onPressedTitle: () {
                        BottomSheetModal.showWidget(
                          context: context,
                          widget: TermsOfServiceScreen()
                        );
                      },
                    ).marginOnly(bottom: 40),
                    _checkWidget(
                      title: '위치 기반 서비스 이용 약관 (필수)',
                      checked: controller.isCheckedTermsOfLocationService.value,
                      onPressedIcon: controller.onChangeTermsOfLocationService,
                      onPressedTitle: () {
                        BottomSheetModal.showWidget(
                          context: context,
                          widget: TermsOfLocationServiceScreen()
                        );
                      },
                    )
                  ],
                )
              )
            ],
          ).marginSymmetric(horizontal: 15),
          ButtonRound(
            label: '다음',
            textColor: controller.isCheckedPrivacyStatement.value && controller.isCheckedTermsOfService.value && controller.isCheckedTermsOfLocationService.value ? MtColor.white : MtColor.grey,
            buttonColor: controller.isCheckedPrivacyStatement.value && controller.isCheckedTermsOfService.value && controller.isCheckedTermsOfLocationService.value ? MtColor.signature : MtColor.paleGrey,
            onTap: controller.isCheckedPrivacyStatement.value && controller.isCheckedTermsOfService.value && controller.isCheckedTermsOfLocationService.value ? controller.moveToSecondScreen : () {},
          ).marginAll(15),
        ],
      ),
    );
  }

  Widget _checkWidget({
    required String title,
    required bool checked,
    required Function() onPressedTitle,
    required Function() onPressedIcon
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onPressedTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                )
              ).marginOnly(bottom: 5),
              Text(
                '약관보기',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                  color: MtColor.grey,
                  fontWeight: FontWeight.w500,
                )
              )
            ],
          ),
        ),
        BaseButton.iconButton(
          iconData: checked ? Icons.check_circle : Icons.check_circle_outline,
          size: 30,
          color: checked ? MtColor.signature : MtColor.grey,
          onPressed: onPressedIcon
        )
      ],
    );
  }
}