import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/view/my_map_home_screen.dart';
import 'package:map_together/module/news/view/news_home_screen.dart';
import 'package:map_together/module/root/controller/root_controller.dart';
import 'package:map_together/module/search/view/search_home_screen.dart';
import 'package:map_together/widget/bottom_nav.dart';

class RootScreen extends GetView<RootX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: IndexedStack(
        index: NavigatorX.to.currentIndex.value,
        children: [
          NewsHomeScreen(),
          SearchHomeScreen(),
          MyMapHomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    ));
  }
}