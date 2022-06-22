import 'package:get/get.dart';
import 'package:map_together/module/my_map/controller/my_map_home_controller.dart';
import 'package:map_together/module/news/controller/news_home_controller.dart';
import 'package:map_together/module/search/controller/search_home_controller.dart';

class RootX extends GetxController {
  static RootX get to => Get.find();

  @override
  void onInit() {
    Get.put(MyMapHomeX());
    Get.put(SearchHomeX());
    Get.put(NewsHomeX());
    super.onInit();
  }
}