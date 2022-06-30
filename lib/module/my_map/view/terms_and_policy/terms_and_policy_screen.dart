import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/terms_and_policy_controller.dart';
import 'package:map_together/module/my_map/view/terms_and_policy/opensource_license_screen.dart';
import 'package:map_together/module/my_map/view/terms_and_policy/privacy_statement_screen.dart';
import 'package:map_together/module/my_map/view/terms_and_policy/terms_of_location_service_screen.dart';
import 'package:map_together/module/my_map/view/terms_and_policy/terms_of_service_screen.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';

class TermsAndPolicyScreen extends GetView<TermsAndPolicyX> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '약관 및 정책',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        ),

      ).init(),
      body: _body(context)
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _tile(
              title: '개인정보 처리방침',
              context: context,
              widget: PrivacyStatementScreen()
            ),
            _tile(
              title: '서비스 이용 약관',
              context: context,
              widget: TermsOfServiceScreen()
            ),
            _tile(
              title: '위치 기반 서비스 이용 약관',
              context: context,
              widget: TermsOfLocationServiceScreen()
            ),
            _tile(
              title: '오픈소스 라이선스',
              context: context,
              widget: OpensourceLicenseScreen()
            ),
          ],
        ).marginSymmetric(horizontal: 15)
      )
    );
  }

  Widget _tile({
    required String title,
    required BuildContext context,
    required Widget widget,
  }) {
    return InkWell(
      onTap: () {
        BottomSheetModal.showWidget(
          context: context,
          widget: widget
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}