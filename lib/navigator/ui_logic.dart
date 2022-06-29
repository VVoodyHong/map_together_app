import 'package:get/get.dart';
import 'package:map_together/module/auth/controller/enter_info_controller.dart';
import 'package:map_together/module/auth/controller/login_controller.dart';
import 'package:map_together/module/auth/controller/signup_controller.dart';
import 'package:map_together/module/auth/view/enter_info_fifth_screen.dart';
import 'package:map_together/module/auth/view/enter_info_first_screen.dart';
import 'package:map_together/module/auth/view/enter_info_fourth_screen.dart';
import 'package:map_together/module/auth/view/enter_info_second_screen.dart';
import 'package:map_together/module/auth/view/enter_info_third_screen.dart';
import 'package:map_together/module/auth/view/login_screen.dart';
import 'package:map_together/module/auth/view/signup_screen.dart';
import 'package:map_together/module/auth/view/splash_screen.dart';
import 'package:map_together/module/follow/controller/follow_home_controller.dart';
import 'package:map_together/module/follow/view/follow_home_screen.dart';
import 'package:map_together/module/my_map/controller/change_password_controller.dart';
import 'package:map_together/module/my_map/controller/setting_controller.dart';
import 'package:map_together/module/my_map/view/change_password_screen.dart';
import 'package:map_together/module/my_map/view/setting_screen.dart';
import 'package:map_together/module/news/controller/news_home_controller.dart';
import 'package:map_together/module/news/controller/select_place_controller.dart';
import 'package:map_together/module/news/view/news_home_screen.dart';
import 'package:map_together/module/news/view/select_place_screen.dart';
import 'package:map_together/module/place/controller/place_category_controller.dart';
import 'package:map_together/module/my_map/controller/map_setting_controller.dart';
import 'package:map_together/module/place/controller/place_update_controller.dart';
import 'package:map_together/module/place/view/place_category_screen.dart';
import 'package:map_together/module/my_map/view/map_setting_screen.dart';
import 'package:map_together/module/place/controller/place_controller.dart';
import 'package:map_together/module/place/view/place_screen.dart';
import 'package:map_together/module/place/view/place_update_screen.dart';
import 'package:map_together/module/root/controller/root_controller.dart';
import 'package:map_together/module/root/view/root_screen.dart';
import 'package:map_together/module/search/controller/search_place_list_controller.dart';
import 'package:map_together/module/search/view/search_place_list_screen.dart';
import 'package:map_together/module/user/controller/profile_controller.dart';
import 'package:map_together/module/user/controller/user_home_controller.dart';
import 'package:map_together/module/user/view/profile_screen.dart';
import 'package:map_together/module/place/controller/place_create_controller.dart';
import 'package:map_together/module/my_map/controller/my_map_home_controller.dart';
import 'package:map_together/module/place/view/place_create_screen.dart';
import 'package:map_together/module/my_map/view/my_map_home_screen.dart';
import 'package:map_together/module/search/controller/search_home_controller.dart';
import 'package:map_together/module/search/view/search_home_screen.dart';
import 'package:map_together/module/user/view/user_home_screen.dart';
import 'package:map_together/navigator/ui_state.dart';

class UiLogic {
  static UiState _uiState = UiState.NONE;
  static UiState _currentScreen = UiState.NONE;
  static UiState _rootScreen = UiState.NONE;
  static var _parameters;
  static int seq = 0;

  static void changeUiState(UiState newState, {
    UiState? prevState,
    bool goRoot = false,
    Map<String, dynamic>? arg
  }) {
    seq++;
    _uiState = newState;
    _parameters = arg;
  
    // Screen을 공통으로 사용하는 State 처리
    switch(newState) {
      default: _currentScreen = newState;
    }

    //Navigator Root 상태 처리
    switch(newState){
      case UiState.ROOT:
        goRoot = true;
        _rootScreen = newState;
        break;
      case UiState.LOGIN:
        goRoot = true;
        _rootScreen = newState;
        break;
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
      name: UiState.ROOT.toString(),
      page: () { return RootScreen(); },
      binding: BindingsBuilder(() { Get.put(RootX());}),
      transition: Transition.fadeIn
  ),
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
      name: UiState.ENTER_INFO_FOURTH.toString(),
      page: () { return EnterInfoFourthScreen(); },
      binding: BindingsBuilder(() { Get.put(EnterInfoX());})
    ),
    GetPage(
      name: UiState.ENTER_INFO_FIFTH.toString(),
      page: () { return EnterInfoFifthScreen(); },
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
      transition: Transition.fadeIn
    ),
    GetPage(
      name: UiState.PLACE_CREATE.toString(),
      page: () { return PlaceCreateScreen(); },
      binding: BindingsBuilder(() { Get.put(PlaceCreateX());})
    ),
    GetPage(
      name: UiState.PLACE_UPDATE.toString(),
      page: () { return PlaceUpdateScreen(); },
      binding: BindingsBuilder(() { Get.put(PlaceUpdateX());})
    ),
    GetPage(
      name: UiState.PLACE_CATEGORY.toString(),
      page: () { return PlaceCategoryScreen(); },
      binding: BindingsBuilder(() { Get.put(PlaceCategoryX());})
    ),
    GetPage(
      name: UiState.MAP_SETTING.toString(),
      page: () { return MapSettingScreen(); },
      binding: BindingsBuilder(() { Get.put(MapSettingX());})
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
      transition: Transition.fadeIn
    ),
    GetPage(
      name: UiState.SEARCH_PLACE_LIST.toString(),
      page: () { return SearchPlaceListScreen(); },
      binding: BindingsBuilder(() { Get.put(SearchPlaceListX());}),
    ),
    GetPage(
      name: UiState.PLACE.toString(),
      page: () { return PlaceScreen(seq.toString()); },
      binding: BindingsBuilder(() { Get.put(PlaceX(), tag: seq.toString());}),
    ),
    GetPage(
      name: UiState.USER_HOME_SCREEN.toString(),
      page: () { return UserHomeScreen(seq.toString()); },
      binding: BindingsBuilder(() { Get.put(UserHomeX(), tag: seq.toString());}),
    ),
    GetPage(
      name: UiState.SETTING.toString(),
      page: () { return SettingScreen(); },
      binding: BindingsBuilder(() { Get.put(SettingX());}),
    ),
    GetPage(
      name: UiState.FOLLOW_HOME.toString(),
      page: () { return FollowHomeScreen(seq.toString()); },
      binding: BindingsBuilder(() { Get.put(FollowHomeX(), tag: seq.toString());}),
    ),
    GetPage(
      name: UiState.NEWS_HOME.toString(),
      page: () { return NewsHomeScreen(); },
      binding: BindingsBuilder(() { Get.put(NewsHomeX());}),
      transition: Transition.fadeIn
    ),
    GetPage(
      name: UiState.SELECT_PLACE.toString(),
      page: () { return SelectPlaceScreen(); },
      binding: BindingsBuilder(() { Get.put(SelectPlaceX());}),
    ),
    GetPage(
      name: UiState.CHANGE_PASSWORD.toString(),
      page: () { return ChangePasswordScreen(); },
      binding: BindingsBuilder(() { Get.put(ChangePasswordX());}),
    ),
  ];
}