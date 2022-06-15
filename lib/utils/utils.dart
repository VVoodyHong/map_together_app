import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
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

  static String getDistance(double startLat, double startLng, double endLat, double endLng) {
    double distance = Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
    if(distance < 1) {
      return '1m 이내';
    } else if(distance < 1000){
      return '${distance.floor()}m';
    } else if(distance < 10000) {
      return '${(distance / 1000).floor()}.${distance.toString().substring(1, 2)}km';
    } else {
      return '${(distance / 1000).floor()}km';
    }
  }
}