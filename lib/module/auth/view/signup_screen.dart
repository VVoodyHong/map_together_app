import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/auth/controller/signup_controller.dart';

class SignupScreen extends GetView<SignupX> {
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
    return Container();
  }
}