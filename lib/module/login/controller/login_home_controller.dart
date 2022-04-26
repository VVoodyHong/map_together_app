import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginHomeX extends GetxController {
  static LoginHomeX get to => Get.find();

  TextEditingController loginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

}