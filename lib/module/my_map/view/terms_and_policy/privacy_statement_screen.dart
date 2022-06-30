import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/terms_and_policy.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';

class PrivacyStatementScreen extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '개인정보 처리방침',
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
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            privacyStatement.content,
            style: TextStyle(fontSize: 16)
          ),
        ),
      ),
    );
  }
}