import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';
import 'package:map_together/model/file/file.dart';
import 'package:map_together/model/file/files.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';

class PlaceX extends GetxController {
  static PlaceX get to => Get.find();
  
  Rx<Place> place = (null as Place).obs;
  RxList<File> fileList = <File>[].obs;
  RxInt currentImage = 1.obs;

  @override
  void onInit() async {
    place.value = Get.arguments['place'];
    await getPlaceImage();
    super.onInit();
  }

  Future<void> getPlaceImage() async {
    ApiResponse<Files> response =  await API.to.getPlaceImage(place.value.idx);
    if(response.success) {
      fileList.addAll(response.data?.list ?? []);
    } else {
      print("getPlaceFile error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void onImageChanged(int index, CarouselPageChangedReason reason) {
    currentImage.value = index + 1;
  }
}