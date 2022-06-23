import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/common/photo_uploader.dart';
import 'package:map_together/model/file/file.dart';
import 'package:map_together/model/file/files.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/place/place_update.dart';
import 'package:map_together/model/place_category/place_category.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/tag/tag.dart';
import 'package:map_together/model/tag/tags.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/text_field_tags_controller.dart';

class PlaceUpdateX extends GetxController {

  static PlaceUpdateX get to => Get.find();

  Completer<NaverMapController> mapController = Completer();
  Rx<LatLng> position = (null as LatLng).obs;
  Rx<Marker> marker = (null as Marker).obs;
  RxList<Marker> markers = <Marker>[].obs;

  Rx<PhotoType> photoType = PhotoType.NONE.obs;
  RxList<Tag> tagList = <Tag>[].obs;
  RxList<File> fileList = <File>[].obs;
  RxList<PlaceCategory> placeCategoryList = <PlaceCategory>[].obs;
  RxBool isNameEmpty = false.obs;
  RxBool isAddressEmpty = false.obs;
  RxInt categoryIdx = (-1).obs;
  RxDouble favorite = (0.0).obs;
  Function? addMarker;
  RxBool isLoading = false.obs;
  RxInt placeIdx = (null as int).obs;
  RxList<Tag> deleteTags = <Tag>[].obs;
  RxList<File> deleteFiles = <File>[].obs;
  Rx<Place> place = (null as Place).obs;

  Rx<PlaceCategoryType> categoryType = PlaceCategoryType.MARKER.obs;
  TextEditingController categoryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextfieldTagsController tagsController = TextfieldTagsController();

  Function(Place place)? placeUpdate;

  @override
  void onInit() async {
    PhotoUploader.to.init();
    position.value = Get.arguments['position'];
    place = Get.arguments['place'];
    placeCategoryList = Get.arguments['placeCategoryList'];
    placeUpdate = Get.arguments['placeUpdate'];
    nameController.value = TextEditingValue(text: (place.value.name).replaceAll('\n', ' '));
    addressController.value = TextEditingValue(text: place.value.address);
    descriptionController.value = TextEditingValue(text: place.value.description ?? '');
    categoryController.value = TextEditingValue(text: place.value.category.name);
    categoryType.value = place.value.category.type;
    favorite.value = place.value.favorite;
    placeIdx.value = place.value.idx;
    categoryIdx.value = place.value.category.idx;
    await getPlaceImage();
    await getPlaceTag();
    await setMarker();
    markers.add(marker.value);
    super.onInit();
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void onMapTap(LatLng _position) async {
    position.value = _position;
    nameController.value = TextEditingValue(text: '');
    checkName(isEmpty: nameController.value.text.isEmpty);
    bool isNotEmptyAddress = await searchAddress();
    checkAddress(isNotEmpty: isNotEmptyAddress);
    await moveMap(_position);
  }

  void onSymbolTap(LatLng? _position, String? caption) async {
    position.value = _position!;
    nameController.value = TextEditingValue(text: (caption ?? '').replaceAll('\n', ' '));
    checkName(isEmpty: nameController.value.text.isEmpty);
    bool isNotEmptyAddress = await searchAddress();
    checkAddress(isNotEmpty: isNotEmptyAddress);
    await moveMap(_position);
  }

  Future<void> moveMap(LatLng _position) async {
    double _zoom = await mapController.future.then((value) => value.getCameraPosition().then((value) => value.zoom));
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: _position,
          zoom: _zoom
        )
      )
    );
    markers.clear();
    await setMarker();
    markers.add(marker.value);
  }

  Future<void> setMarker() async {
    marker.value = Marker(
      markerId: position.value.json.toString(),
      position: position.value,
      height: 20,
      width: 20,
      icon: await OverlayImage.fromAssetImage(assetName: Asset().getMarker(categoryType.value.getValue()))
    );
  }

  void onChangeName(String text) {
    isNameEmpty.value = text.isEmpty;
  }

  void onChangeAddress(String text) {
    isAddressEmpty.value = text.isEmpty;
  }

  void onChangeFavorite(double value) {
    favorite.value = value;
  }

  void checkName({required bool isEmpty}) {
    if(isEmpty) {
      isNameEmpty.value = true;
    } else {
      isNameEmpty.value = false;
    }
  }

  void checkAddress({required bool isNotEmpty}) {
    if(isNotEmpty) {
      isAddressEmpty.value = false;
    } else {
      isAddressEmpty.value = true;
    }
  }

  void deleteImage(int index) {
    deleteFiles.add(fileList[index]);
    fileList.removeAt(index);
  }

  Future<void> getPlaceTag() async {
    ApiResponse<Tags> response =  await API.to.getPlaceTag(placeIdx.value);
    if(response.success) {
      List<String> tagNameList = [];
      for (Tag tag in response.data!.list) {
        tagList.add(tag);
        tagNameList.add(tag.name ?? '');
      }
      tagsController.setTags(tagNameList);
    } else {
      print("getPlaceTag error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void onTagDelete(String tag) {
    for (Tag _tag in tagList) {
      if(_tag.name == tag) {
        deleteTags.add(_tag);
        tagList.remove(_tag);
        break;
      }
    }
  }

  Future<void> getPlaceImage() async {
    ApiResponse<Files> response =  await API.to.getPlaceImage(placeIdx.value);
    if(response.success) {
      fileList.addAll(response.data?.list ?? []);
    } else {
      print("getPlaceFile error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void updatePlace() async {
    if(nameController.text.isEmpty) {
      Utils.showToast('장소명을 입력해주세요.');
    }else if(addressController.text.isEmpty) {
      Utils.showToast('주소를 입력해주세요.');
    } else if(categoryIdx.value == -1) {
      Utils.showToast('카테고리를 선택해주세요.');
    }
    List<Tag> addTags = <Tag>[];
    for(String tagName in tagsController.getTags ?? []) {
      if(!tagList.map((tag) => tag.name).contains(tagName)) {
        addTags.add(Tag(name: tagName));
      }
    }
    PlaceUpdate _placeUpdate = PlaceUpdate(
        idx: placeIdx.value,
        categoryIdx: categoryIdx.value,
        name: nameController.text,
        address: addressController.text,
        description: descriptionController.text,
        addTags: addTags,
        deleteTags: deleteTags,
        deleteFiles: deleteFiles,
        favorite: favorite.value,
        lat: position.value.latitude,
        lng: position.value.longitude
    );
    isLoading.value = true;
    
    ApiResponse<Place> response = await API.to.updatePlace(_placeUpdate);
    if(response.success) {
      if(placeUpdate != null) {
        placeUpdate!(response.data!);
        Get.close(1);
        Utils.showToast('수정이 완료되었습니다.');
      }
    } else {
      print("updatePlace error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }


  Future<bool> searchAddress() async {
    dynamic res = await API.to.reverseGeocoding(position.value.longitude, position.value.latitude);
    if(res['status']['code'] == 3) {
      Utils.showToast('정상적인 위치가 아니거나 상세주소를 찾을 수 없습니다.');
      return false;
    } else if(res['status']['code'] == 0) {
      String tempAddress = '';
      for(int i = 1; i < res['results'][0]['region'].length; i++) {
        if(res['results'][0]['region']['area$i']['name'] != '') {
          tempAddress += (res['results'][0]['region']['area$i']['name'] + ' ');
        }
      }
      tempAddress += res['results'][0]['land']['number1'];
      if(res['results'][0]['land']['number2'] != '') {
        tempAddress += '-' + res['results'][0]['land']['number2'];
      }
      addressController.value = TextEditingValue(text: tempAddress);
      return true;
    } else {
      Utils.showToast('서버 통신 중 오류가 발생했습니다.');
      return false;
    }
  }

  void moveToCategory() {
    Utils.moveTo(UiState.PLACE_CATEGORY, arg: {
      'setCategory': setCategory,
      'placeCategoryList': placeCategoryList,
    });
  }

  void setCategory(int idx, PlaceCategoryType type, String name) async {
    categoryIdx.value = idx;
    categoryType.value = type;
    categoryController.value = TextEditingValue(text: name);
    markers.clear();
    await setMarker();
    markers.add(marker.value);
  }
}