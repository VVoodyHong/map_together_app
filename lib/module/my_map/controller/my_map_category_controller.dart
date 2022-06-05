import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map_together/model/place_category/place_categories.dart';
import 'package:map_together/model/place_category/place_category.dart';
import 'package:map_together/model/place_category/place_category_create.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/module/my_map/controller/my_map_create_controller.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';

class MyMapCategoryX extends GetxController {
  static MyMapCategoryX get to => Get.find();

  RxList<PlaceCategory> list = <PlaceCategory>[].obs;
  RxInt selectedCategory = (-1).obs;
  Rx<PlaceCategoryType> selectedMarker = PlaceCategoryType.NONE.obs;
  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getPlaceCategories();
  }

  Future<void> getPlaceCategories() async {
    ApiResponse<PlaceCategories> response = await API.to.getPlaceCategories();
    if(response.success) {
      list.addAll(response.data?.list ?? []);
      nameController.clear();
      selectedMarker.value = PlaceCategoryType.NONE;
    } else {
      print("getCategories error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void createPlaceCategory() async {
    if(nameController.text.isEmpty) {
      Utils.showToast("카테고리명을 입력해주세요.");
      return;
    } else if(selectedMarker.value == PlaceCategoryType.NONE) {
      Utils.showToast("마커를 선택해주세요.");
      return;
    }
    PlaceCategoryCreate placeCategoryCreate = PlaceCategoryCreate(
      name: nameController.text,
      type: selectedMarker.value,
    );
    ApiResponse<PlaceCategory> response = await API.to.createPlaceCategory(placeCategoryCreate);
    if(response.success) {
      if(response.data != null) {
        list.add(response.data!);
        Utils.showToast("카테고리가 추가되었습니다.");
        Get.close(1);
      } else {
        Get.close(1);
      }
    } else {
      print("getCategories error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void setSelectedCategory(int index) {
    selectedCategory.value = index;
  }

  void setSelectedMarker(PlaceCategoryType marker) {
    selectedMarker.value = marker;
  }

  void setCategory() {
    MyMapCreateX.to.setCategory(list[selectedCategory.value].idx, list[selectedCategory.value].type, list[selectedCategory.value].name);
    Get.close(1);
  }
}