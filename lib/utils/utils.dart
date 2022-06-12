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

  static Visibility showLoading({
    required bool isLoading
  }) {
    return Visibility(
      visible: isLoading,
      child: Container(
        alignment: Alignment.center,
        color: MtColor.transparent,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: CircularProgressIndicator(
            color: MtColor.signature
          ),
        ),
      )
    );
  }

  static void moveTo(UiState state, {dynamic arg}) {
    UiLogic.changeUiState(
      state,
      prevState: UiLogic.getUiState(),
      arg: arg
    );
  }

  static String trimDate(DateTime date) {
    DateTime now = DateTime.now();
    int difference = int.parse(now.difference(date).inSeconds.toString());
    if(difference < 60) {
      return '방금 전';
    } else if(difference < 60 * 60) {
      return '${difference ~/ 60}분 전';
    } else if(difference < 60 * 60 * 24) {
      return '${difference ~/ (60 * 60)}시간 전';
    } else if(difference < 60 * 60 * 24 * 7) {
      return '${difference ~/ (60 * 60 * 24)}일 전';
    } else {
      return '${date.year}년 ${date.month}월 ${date.day}일';
    }
  }
}