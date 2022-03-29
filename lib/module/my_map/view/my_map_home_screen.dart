import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/my_map_home_controller.dart';
import 'package:map_together/widget/bottom_nav.dart';

class MyMapHomeScreen extends GetView<MyMapHomeX> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("My Map")),
      bottomNavigationBar: BottomNav(),
    );
  }
}
