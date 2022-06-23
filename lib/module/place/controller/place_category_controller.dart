import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map_together/model/place_category/place_categories.dart';
import 'package:map_together/model/place_category/place_category.dart';
import 'package:map_together/model/place_category/place_category_create.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';

class PlaceCategoryX extends GetxController {
  static PlaceCategoryX get to => Get.find();

  RxList<PlaceCategory> list = <PlaceCategory>[].obs;
  RxInt selectedCategory = (-1).obs;
  Rx<PlaceCategoryType> selectedMarker = PlaceCategoryType.NONE.obs;
  TextEditingController nameController = TextEditingController();
  Function(int idx, PlaceCategoryType type, String name)? _setCategory;
  RxBool deleteMode = false.obs;
  RxList<int> deleteList = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    list.value = Get.arguments['placeCategoryList'];
    _setCategory = Get.arguments['setCategory'];
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
      print("createPlaceCategory error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void deletePlaceCategory() async {
    List<PlaceCategory> _list = [];
    for(int i = 0; i < deleteList.length; i++) {
      _list.add(
        PlaceCategory(
          idx: list[deleteList[i]].idx,
          name: list[deleteList[i]].name,
          type: list[deleteList[i]].type,
        )
      );
    }
    PlaceCategories deletePlaceCategories = PlaceCategories(list: _list);
    ApiResponse<void> response = await API.to.deletePlaceCategory(deletePlaceCategories);
    if(response.success) {
      deleteList.sort((b, a) => a.compareTo(b));
      for(int idx in deleteList) { list.removeAt(idx); }
      deleteList.clear();
      changeDeleteMode();
      selectedCategory.value = -1;
      Utils.showToast('삭제가 완료되었습니다.');
    } else {
      print("deletePlaceCategory error:: ${response.code} ${response.message}");
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
    if(_setCategory != null) {
      _setCategory!(list[selectedCategory.value].idx, list[selectedCategory.value].type, list[selectedCategory.value].name);
      Get.close(1);
    }
  }

  void changeDeleteMode() {
    deleteMode.value = !deleteMode.value;
  }

  void setDeleteList(int index) {
    if(!deleteList.contains(index)) {
      deleteList.add(index);
    } else {
      deleteList.remove(index);
    }
  }
}