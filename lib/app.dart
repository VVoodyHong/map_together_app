import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:map_together/auth/secrets.dart';
import 'package:map_together/model/api_response.dart';
import 'package:map_together/model/jwt_authentication_response.dart';
import 'package:map_together/model/request/login.dart';
import 'package:map_together/model/type/os_type.dart';
import 'package:map_together/model/type/user_type.dart';
import 'package:map_together/model/user.dart' as mapto;
import 'package:map_together/module/sqlite/db_helper.dart';
import 'package:map_together/module/sqlite/db_jwt.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends GetxController {
  
  static App get to => Get.find();

  Login loginData = Login();
  DBHelper db = DBHelper();
  late SharedPreferences prefs;

  // 전역변수
  Rx<mapto.User> user = mapto.User().obs;

  // TODO: min version set
  int minAndroidSdk = 0;
  double minIosSdk = 0;
  String minAppVersion = "1.0.0";

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 1000), () {
      _startProcess().then((_) {
        _autoLogin();
      }).catchError((onError) {
        print("_startProcess error:: $onError");
      });
    });
  }

  /* ========================================================*/
  /* ============ Init application start process ============*/
  /* ========================================================*/

  Future<void> _startProcess() async {
    KakaoContext.clientId = SdkKeys.kakaoClientId;

    prefs = await SharedPreferences.getInstance();
    
    // 1. device check
    Map<String, dynamic> deviceInfo = await _getDeviceInfo();
    switch(deviceInfo['os']) {
      case 'Android':
        int deviceSdk = int.parse(deviceInfo['sdk'].toString());
        int minSdk = minAndroidSdk;
        if (_checkSdkVersion(deviceSdk, minSdk)) {
          return Utils.showToast("안드로이드 최소 SDK 버전이 맞지 않습니다.");
        }
        loginData.osType = OsType.ANDROID;
        loginData.osVersion = deviceSdk;
        loginData.deviceId = deviceInfo['id'];
        break;
      case 'iOS':
      String tempSdk = deviceInfo['sdk'].toString();
      List<String> sdkList = tempSdk.split('.');
      double deviceSdk = double.parse('${sdkList[0]}.${sdkList[1]}');
      double minSdk = minIosSdk;
      if(_checkSdkVersion(deviceSdk, minSdk)) {
        return Utils.showToast("iOS 최소 시스템 버전이 맞지 않습니다.");
      }
      loginData.osType = OsType.IOS;
      loginData.osVersion = deviceSdk.toInt();
      loginData.deviceId = deviceInfo['id'];
      break;
    }

    // 2. app version check
    await PackageInfo.fromPlatform().then((appInfo) {
      loginData.appVersion = appInfo.version;
      if(_checkAppVersion(appInfo.version, minAppVersion)) {
        return Utils.showToast("앱 업데이트를 해주세요.");
      }
    });
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = {};
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceData = {
          'os': 'Android',
          'sdk': androidInfo.version.sdkInt,
          'id': androidInfo.androidId
        };
      } else if (Platform.isIOS) {
        IosDeviceInfo iOSInfo = await deviceInfoPlugin.iosInfo;
        deviceData = {
          'os': iOSInfo.systemName,
          'sdk': iOSInfo.systemVersion,
          'id': iOSInfo.identifierForVendor
        };
      }
    } on Exception catch (e) {
      print("Exception:: $e");
    }

    return deviceData;
  }

  bool _checkSdkVersion(num deviceSdk, num minSdk) {
    return deviceSdk < minSdk;

  }
  bool _checkAppVersion(String appVersion, String minAppVersion) {
    List<String> appVerList = appVersion.split('.');
    List<String> minAppVerList = minAppVersion.split('.');
    for(int i = 0; i < minAppVerList.length; i++) {
      if(int.parse(appVerList[i]) < int.parse(minAppVerList[i])) {
        return true;
      }
    }
    return false;
  }

  /* ========================================================*/
  /* ================== Init login process ==================*/
  /* ========================================================*/

  void _autoLogin() async {
    loginData.userType = UserType.USER;
    // Fetching jwt from local storage
    String? jwt = prefs.getString('jwt');
    // If there is no jwt, go to the login page
    if(jwt == null || jwt == "") {
      return UiLogic.changeUiState(UiState.LOGIN);
    } else {
      DBJwt dbJwt = DBJwt.fromJson(json.decode(jwt));
      // Set jwt to API
      API.to.token = dbJwt.accessToken;
      // Check jwt remmain time
      Duration remainJwtTime = JwtDecoder.getRemainingTime(dbJwt.accessToken);
      int jwtRemainHours = int.parse(remainJwtTime.toString().split(':')[0]);
      // When the jwt is expired
      if(JwtDecoder.isExpired(dbJwt.accessToken)) {
        bool success = await _getNewAccessToken(dbJwt);
        if(success) moveToMain();
      // One day before expiry
      } else if(jwtRemainHours < 24) {
        bool success = await _refreshJwt();
        if(success) moveToMain();
      // default
      } else {
        moveToMain();
      }
    }
  }

  Future<bool> _getNewAccessToken(DBJwt dbJwt) {
    return API.to.getNewAccessToken(dbJwt.refreshToken).then((response) {
      // When the refresh token has not expired
      if(response.code != 653) {
        if(response.success) {
          dbJwt.accessToken = response.data?.accessToken ?? '';
          _setToken(dbJwt);
          return true;
        } else {
          print("_getNewAccessToken error:: ${response.code} ${response.message}");
          Utils.showToast(response.message);
          return false;
        }
      // When the refresh token has expired
      } else if(response.code == 653) {
        prefs.setString('jwt', "");
        UiLogic.changeUiState(UiState.LOGIN);
        return false;
      } else {
        print("_getNewAccessToken error:: ${response.code} ${response.message}");
        Utils.showToast("서버 통신 중 오류가 발생했습니다.");
        UiLogic.changeUiState(UiState.LOGIN);
        return false;
      }
    });
  }

  Future<bool> _refreshJwt() {
    return API.to.refreshJwt().then((response) {
      if(response.success) {
        DBJwt dbJwt = DBJwt.fromJson(response.data!.toJson());
        _setToken(dbJwt);
        return true;
      } else {
        print("refreshJwt error:: ${response.code} ${response.message}");
        Utils.showToast(response.message);
        return false;
      }
    });
  }

  Future<bool> _getUser() {
    return API.to.getUser().then((response) {
      if(response.success) {
        user.value = response.data!;
        return true;
      } else {
        print("_getUser error:: ${response.code} ${response.message}");
        Utils.showToast(response.message);
        return false;
      }
    });
  }

  void moveToMain() async {
    bool success = await _getUser();
    if(success) {
      if(user.value.nickname!.isEmpty) { // first login
        UiLogic.changeUiState(UiState.ENTER_INFO_FIRST);
      } else {
        UiLogic.changeUiState(UiState.MYMAP_HOME);
      }
    }
  }

  Future<bool> requestLogin() {
    return API.to.signIn(loginData).then((response) {
      if(response.success) {
        DBJwt dbJwt = DBJwt.fromJson(response.data!.toJson());
        _setToken(dbJwt);
        return true;
      } else {
        print("_signIn error:: ${response.code} ${response.message}");
        Utils.showToast(response.message);
        return false;
      }
    });
  }

  void _setToken(DBJwt dbJwt) {
    String jwt = json.encode(dbJwt);
    prefs.setString('jwt', jwt);
    API.to.token = dbJwt.accessToken;
  }

  DateTime? _currentBackPressTime;
  Future<bool> exitApp() {
    var now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Utils.showToast('뒤로가기 버튼을 한번 더 누르면 종료됩니다.');
      return Future.value(false);
    }
    return Future.value(true);
  }
}