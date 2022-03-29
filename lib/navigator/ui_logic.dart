import 'package:get/get.dart';
import 'package:map_together/module/login/splash_screen.dart';
import 'package:map_together/module/my_map/controller/my_map_home_controller.dart';
import 'package:map_together/module/my_map/view/my_map_home_screen.dart';
import 'package:map_together/navigator/ui_state.dart';

class UiLogic {
  static UiState _uiState = UiState.NONE;
  static UiState _currentScreen = UiState.NONE;
  static UiState _rootScreen = UiState.NONE;
  static var _parameters;

  static void changeUiState(UiState newState, {
    UiState? prevState,
    bool goRoot = false,
    Map<String, dynamic>? arg
  }) {
    _uiState = newState;
    _parameters = arg;

    switch(newState){
      case UiState.MYMAP_HOME:
        goRoot = true;
        _rootScreen = newState;
        break;
      default: break; 
    }

    /**
     * Get.offNamed : 현재 screen 삭제하고 이동
     * Get.toNamed : 현재 screen 위로 이동
     * Get.offAllNamed : 모든 screen 삭제하고 이동
     */
    if(goRoot) {
      Get.offAllNamed(_rootScreen.toString(), arguments: _parameters);
    } else {
      prevState == null ?
      Get.offNamed(_currentScreen.toString(), arguments: _parameters) :
      Get.toNamed(_currentScreen.toString(), arguments: _parameters);
    }
  }

  static UiState getUiState() { return _uiState; }
  static UiState getRootScreen() { return _rootScreen; }

  static final route = [
    GetPage(
      name: UiState.SPLASH.toString(),
      page: () { return SplashScreen(); }
    ),
    GetPage(
      name: UiState.MYMAP_HOME.toString(),
      page: () { return MyMapHomeScreen(); },
      binding: BindingsBuilder(() { Get.put(MyMapHomeX());})
      
    )
  ];
}