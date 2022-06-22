import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/module/news/controller/news_home_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';

class NewsHomeScreen extends GetView<NewsHomeX> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'MapTogether',
        titleColor: MtColor.signature,
        titleWeight: FontWeight.bold,
        centerTitle: false,
      ).init(),
      body: WillPopScope(
        onWillPop: App.to.exitApp,
        child: _body()
      )
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        
      )
    );
  }
}