import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  static IconButton iconButton({required IconData iconData, required Function() onPressed}) {
    return IconButton(
      icon: Icon(
        iconData,
        color: MtColor.black,
      ),
      splashRadius: 24,
      onPressed: onPressed,
    );
  }

  static IconButton textButton({required String text, required Function() onPressed}) {
    return IconButton(
      icon: Text(
        text,
        style: TextStyle(
          color: MtColor.black,
        )
      ),
      splashRadius: 24,
      onPressed: onPressed,
    );
  }
}