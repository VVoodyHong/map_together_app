import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/utils/constants.dart';

class Utils {

  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: MtColor.paleBlack,
      textColor: MtColor.white,
      fontSize: FontSize.medium
    );
  }

  static void moveTo(UiState state, {dynamic arg}) {
    UiLogic.changeUiState(
      state,
      prevState: UiLogic.getUiState(),
      arg: arg
    );
  }

  static IconButton appBarBackButton({Color? color, VoidCallback? onPressed}) {
    return IconButton(
      onPressed: onPressed ?? () => Get.close(1),
      color: color ?? MtColor.black,
      icon: Icon(Icons.arrow_back),
      splashRadius: 24,
    );
  }
}