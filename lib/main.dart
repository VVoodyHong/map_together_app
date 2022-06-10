import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/auth/view/splash_screen.dart';
import 'package:map_together/common/photo_uploader.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/bottom_nav.dart';

void main() {
  runApp(MapTogether());
  if(Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: MtColor.white,
        statusBarIconBrightness: Brightness.dark
      )
    );
  }
}

class MapTogether extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: MtColor.white
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(API());
        Get.put(App());
        Get.put(NavigatorX());
        Get.put(PhotoUploader());
      }),
      home: SplashScreen(),
      getPages: UiLogic.route,
      debugShowCheckedModeBanner: false
    );
  }
}
