import 'package:get/get.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/navigator/ui_state.dart';

class App extends GetxController {
  
  static App get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 1500), () {
      UiLogic.changeUiState(UiState.MYMAP_HOME);
    });
  }
}