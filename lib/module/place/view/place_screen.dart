import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/module/place/controller/place_controller.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';

class PlaceScreen extends GetView<PlaceX> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '장소',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        ),
      ).init(),
      body: _body(),
    );
  }

  Widget _body() {
      return Container();
    }
}