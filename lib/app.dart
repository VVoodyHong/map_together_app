import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:map_together/auth/secrets.dart';
import 'package:map_together/model/api_response.dart';
import 'package:map_together/model/jwt_authentication_response.dart';
import 'package:map_together/model/request/login.dart';
import 'package:map_together/model/type/os_type.dart';
import 'package:map_together/module/sqlite/db_helper.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends GetxController {
  
  static App get to => Get.find();

  Login loginData = Login();
  DBHelper db = DBHelper();

  // TODO: min version set
  int minAndroidSdk = 0;
  double minIosSdk = 0;
  String minAppVersion = "1.0.0";

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 1500), () {
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

  bool _checkSdkVersion(deviceSdk, minSdk) {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    requestLogin();
    // if (userData != null) {
    //   return Utils.moveTo(UiState.LOGIN);
    // } else {
    //   Map<String, dynamic> userDataJson = json.decode(userData!);
    // }
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool loggedIn = prefs.getBool(Prefs.KEY_LOGGED_IN) ?? false;
    // if(!loggedIn) {
    //   return Utils.moveTo(UiState.LOGIN);
    // } else {
    //   await db.getLoginData().then((data) {
    //     if(data == null) {
    //       return Utils.moveTo(UiState.LOGIN);
    //     } else {
    //       requestLogin();
    //     }
    //   });
    // }
  }

  void requestLogin() async {
    loginData.loginId = "test";
    loginData.password = "af";
    await API.to.signIn(loginData).then((res) async {
      ApiResponse<JwtAuthenticationResponse>? response = res.body;
      if(response == null) {
        print("requestLogin error:: ${res.statusCode} ${res.statusText}");
        return Utils.showToast("서버 통신 중 오류가 발생했습니다.");
      } else {
          if(response.success) {
          } else {
            print("requestLogin error:: ${response.code} ${response.message}");
            return Utils.showToast("서버 통신 중 오류가 발생했습니다.");
          }
      }
    });
  }
}