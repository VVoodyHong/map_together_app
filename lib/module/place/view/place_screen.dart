import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/model/file/file.dart';
import 'package:map_together/module/place/controller/place_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';

class PlaceScreen extends GetView<PlaceX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
        title: '장소',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        ),
      ).init(),
      body: _body(),
    ));
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            controller.fileList.isNotEmpty ? Stack(
              children: [
                CarouselSlider(
                  items: _carouselItems(),
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    aspectRatio: 1,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    onPageChanged: controller.onImageChanged
                  )
                ),
                controller.fileList.length > 1 ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: MtColor.black.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Text(
                      '${controller.currentImage} / ${controller.fileList.length}',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ) : Container()
              ],
            ) : Container(),
          ],
        ),
      ),
    );
  }

  List<Widget> _carouselItems() {
    List<Widget> _list = [];
    for (File file in controller.fileList) {
      _list.add(
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(file.url)
            )
          ),
        )
      );
    }
    return _list;
  }
}