import 'package:get/get.dart';
import 'package:map_together/module/auth/controller/enter_info_controller.dart';
import 'package:map_together/module/auth/controller/login_controller.dart';
import 'package:map_together/module/auth/controller/signup_controller.dart';
import 'package:map_together/module/auth/view/enter_info_first_screen.dart';
import 'package:map_together/module/auth/view/enter_info_second_screen.dart';
import 'package:map_together/module/auth/view/enter_info_third_screen.dart';
import 'package:map_together/module/auth/view/login_screen.dart';
import 'package:map_together/module/auth/view/signup_screen.dart';
import 'package:map_together/module/auth/view/splash_screen.dart';
import 'package:map_together/module/place/controller/place_category_controller.dart';
import 'package:map_together/module/my_map/controller/my_map_setting_controller.dart';
import 'package:map_together/module/place/view/place_category_screen.dart';
import 'package:map_together/module/my_map/view/my_map_setting_screen.dart';
import 'package:map_together/module/place/controller/place_controller.dart';
import 'package:map_together/module/place/view/place_screen.dart';
import 'package:map_together/module/user/controller/profile_controller.dart';
import 'package:map_together/module/user/view/profile_screen.dart';
import 'package:map_together/module/place/controller/place_create_controller.dart';
import 'package:map_together/module/my_map/controller/my_map_home_controller.dart';
import 'package:map_together/module/place/view/place_create_screen.dart';
import 'package:map_together/module/my_map/view/my_map_home_screen.dart';
import 'package:map_together/module/search/controller/search_home_controller.dart';
import 'package:map_together/module/search/view/search_home_screen.dart';
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
  
    // Screen을 공통으로 사용하는 State 처리
    switch(newState) {
      default: _currentScreen = newState;
    }

    //Navigator Root 상태 처리
    switch(newState){
      case UiState.MYMAP_HOME:
        goRoot = true;
        _rootScreen = newState;
        break;
      case UiState.SEARCH_HOME:
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
      name: UiState.LOGIN.toString(),
      page: () { return LoginScreen(); },
      binding: BindingsBuilder(() { Get.put(LoginX());})
    ),
    GetPage(
      name: UiState.ENTER_INFO_FIRST.toString(),
      page: () { return EnterInfoFirstScreen(); },
      binding: BindingsBuilder(() { Get.put(EnterInfoX());})
    ),
    GetPage(
      name: UiState.ENTER_INFO_SECOND.toString(),
      page: () { return EnterInfoSecondScreen(); },
      binding: BindingsBuilder(() { Get.put(EnterInfoX());})
    ),
    GetPage(
      name: UiState.ENTER_INFO_THIRD.toString(),
      page: () { return EnterInfoThirdScreen(); },
      binding: BindingsBuilder(() { Get.put(EnterInfoX());})
    ),
    GetPage(
      name: UiState.SIGNUP.toString(),
      page: () { return SignupScreen(); },
      binding: BindingsBuilder(() { Get.put(SignupX());})
    ),
    GetPage(
      name: UiState.MYMAP_HOME.toString(),
      page: () { return MyMapHomeScreen(); },
      binding: BindingsBuilder(() { Get.put(MyMapHomeX());}),
      transition: Transition.noTransition
    ),
    GetPage(
      name: UiState.PLACE_CREATE.toString(),
      page: () { return PlaceCreateScreen(); },
      binding: BindingsBuilder(() { Get.put(PlaceCreateX());})
    ),
    GetPage(
      name: UiState.PLACE_CATEGORY.toString(),
      page: () { return PlaceCategoryScreen(); },
      binding: BindingsBuilder(() { Get.put(PlaceCategoryX());})
    ),
    GetPage(
      name: UiState.MYMAP_SETTING.toString(),
      page: () { return MyMapSettingScreen(); },
      binding: BindingsBuilder(() { Get.put(MyMapSettingX());})
    ),
    GetPage(
      name: UiState.PROFILE.toString(),
      page: () { return ProfileScreen(); },
      binding: BindingsBuilder(() { Get.put(ProfileX());})
    ),
    GetPage(
      name: UiState.SEARCH_HOME.toString(),
      page: () { return SearchHomeScreen(); },
      binding: BindingsBuilder(() { Get.put(SearchHomeX());}),
      transition: Transition.noTransition
    ),
    GetPage(
      name: UiState.PLACE.toString(),
      page: () { return PlaceScreen(); },
      binding: BindingsBuilder(() { Get.put(PlaceX());}),
    )
  ];
}