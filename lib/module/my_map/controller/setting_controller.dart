import 'package:get/get.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingX extends GetxController {
  static SettingX get to => Get.find();

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt', '');
    Utils.showToast('로그아웃이 완료되었습니다.');
    UiLogic.changeUiState(UiState.LOGIN);
  }
}