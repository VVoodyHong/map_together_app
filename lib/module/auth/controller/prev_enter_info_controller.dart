import 'package:get/get.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/utils/utils.dart';

class PrevEnterInfoX extends GetxController {
  static PrevEnterInfoX get to => Get.find();

  void moveToFirstScreen() {
    Utils.moveTo(UiState.ENTER_INFO_FIRST);
  }
}