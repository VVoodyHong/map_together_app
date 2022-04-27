import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/search/controller/search_home_controller.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/bottom_nav.dart';

class SearchHomeScreen extends GetView<SearchHomeX> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '검색',
        titleWeight: FontWeight.bold,
        centerTitle: false,
      ).init(),
      body: SafeArea(
        child: Container()
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}