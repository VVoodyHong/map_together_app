import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileX extends GetxController {
  static ProfileX get to => Get.find();

  RxBool editMode = false.obs;

  TextEditingController nickNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController introduceController = TextEditingController();

  void changeEditMode() {
    editMode.value = !editMode.value;
  }

  void onPressEditClose() {
    editMode.value = false;
  }
}