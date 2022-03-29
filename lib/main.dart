import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/login/splash_screen.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/widget/bottom_nav.dart';

void main() {
  runApp(MapTogether());
}

class MapTogether extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: BindingsBuilder(() {
          Get.put(App());
          Get.put(NavigatorX());
        }),
        home: SplashScreen(),
        getPages: UiLogic.route,
        debugShowCheckedModeBanner: false);
  }
}
