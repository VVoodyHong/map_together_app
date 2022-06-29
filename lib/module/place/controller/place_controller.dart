import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/file/file.dart';
import 'package:map_together/model/file/files.dart';
import 'package:map_together/model/page/request_page.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/place_category/place_category.dart';
import 'package:map_together/model/place_like/place_like.dart';
import 'package:map_together/model/place_reply/place_replies.dart';
import 'package:map_together/model/place_reply/place_reply_create.dart';
import 'package:map_together/model/place_reply/place_reply_simple.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/tag/tag.dart';
import 'package:map_together/model/tag/tags.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';

class PlaceX extends GetxController {
  static PlaceX get to => Get.find();

   Completer<NaverMapController> mapController = Completer();
  
  Rx<Place> place = (null as Place).obs;
  RxInt? userIdx = (null as int).obs;
  RxString? userNickName = (null as String).obs;
  RxList<File> fileList = <File>[].obs;
  RxList<Tag> tagList = <Tag>[].obs;
  RxList<PlaceReplySimple> replyList = <PlaceReplySimple>[].obs;
  RxList<Marker> markers = <Marker>[].obs;
  RxInt currentImage = 1.obs;
  RxBool isLoading = false.obs;
  RxBool isLastReply = false.obs;
  RxInt replyPage = 1.obs;
  RxDouble mapHeight = (200.0).obs;
  RxBool isLike = false.obs;
  RxInt totalLike = 0.obs;

  TextEditingController replyController = TextEditingController();
  ScrollController bodyScrollController = ScrollController();
  ScrollController replyScrollController = ScrollController();

  Function(int placeIdx)? _deletePlace;
  Function(Place place)? updatePlace;
  RxList<PlaceCategory> placeCategoryList = <PlaceCategory>[].obs;

  @override
  void onInit() async {
    place.value = Get.arguments['place'];
    userIdx?.value = Get.arguments['userIdx'];
    userNickName?.value = Get.arguments['userNickname'];
    // from my map home
    _deletePlace = Get.arguments['deletePlace'];
    updatePlace = Get.arguments['updatePlace'];
    placeCategoryList = Get.arguments['placeCategoryList'];
    await getPlaceImage();
    await getPlaceTag();
    await getPlaceReply();
    await getPlaceLike();
    await setMarker();
    updatePlaceViewCnt();
    bodyScrollController.addListener(listenScrollingBody);
    replyScrollController.addListener(listenScrollingReply);
    super.onInit();
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void listenScrollingBody() {
    if(bodyScrollController.position.pixels > 0) {
      mapHeight.value = 0;
    } else {
      mapHeight.value = 200;
    }
  }

  void listenScrollingReply() async {
    if (replyScrollController.position.atEdge) {
      bool isTop = replyScrollController.position.pixels == 0;
      if (!isTop && !isLastReply.value) {
        isLoading.value = true;
        await getPlaceReply();
        isLoading.value = false;
      }
    }
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

  Future<void> getPlaceTag() async {
    ApiResponse<Tags> response =  await API.to.getPlaceTag(place.value.idx);
    if(response.success) {
      tagList.addAll(response.data?.list ?? []);
    } else {
      print("getPlaceTag error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  Future<void> createPlaceReply() async {
    if(replyController.text.trim().isEmpty) {
      replyController.clear();
      Utils.showToast('댓글을 입력해주세요.');
      return;
    }
    isLoading.value = true;
    PlaceReplyCreate placeReplyCreate = PlaceReplyCreate(
      reply: replyController.text,
      placeIdx: place.value.idx
    );
    ApiResponse<PlaceReplySimple> response = await API.to.createPlaceReply(placeReplyCreate);
    if(response.success) {
      replyList.add(response.data!);
      replyController.clear();
      scrollToBottom();
    } else {
      print("createPlaceReply error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }

  Future<void> getPlaceReply() async {
    RequestPage requestPage = RequestPage(
      page: replyPage.value,
      size: DefaultPage.size
    );
    ApiResponse<PlaceReplies> response =  await API.to.getPlaceReply(place.value.idx, requestPage);
    if(response.success) {
      replyList.addAll(response.data?.list ?? []);
      replyPage++;
      isLastReply.value = response.data!.last;
    } else {
      print("getPlaceReply error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  Future<void> deletePlaceReply(int index) async {
    ApiResponse<void> response = await API.to.deletePlaceReply(replyList[index].idx);
    if(response.success) {
      replyList.removeAt(index);
      Utils.showToast('삭제가 완료되었습니다');
      Get.close(1);
      bodyScrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      print("deletePlaceReply error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  Future<void> createPlaceLike() async {
    ApiResponse<void> response = await API.to.createPlaceLike(place.value.idx);
    if(response.success) {
      isLike.value = true;
      totalLike.value = totalLike.value + 1;
    } else {
      print("createPlaceLike error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  Future<void> getPlaceLike() async {
    ApiResponse<PlaceLike> response = await API.to.getPlaceLike(place.value.idx);
    if(response.success) {
      isLike.value = response.data!.like;
      totalLike.value = response.data!.totalLike;
    } else {
      print("getPlaceLike error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  Future<void> deletePlaceLike() async {
    ApiResponse<void> response = await API.to.deletePlaceLike(place.value.idx);
    if(response.success) {
      isLike.value = false;
      totalLike.value = totalLike.value - 1;
    } else {
      print("deletePlaceLike error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  Future<void> deletePlace() async {
    ApiResponse<void> response = await API.to.deletePlace(place.value.idx);
    if(response.success) {
      Get.close(2);
      if(_deletePlace != null) {
        _deletePlace!(place.value.idx);
      }
      Utils.showToast('삭제가 완료되었습니다');
    } else {
      print("deletePlace error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void updatePlaceViewCnt() async {
    if(App.to.user.value.idx != userIdx?.value) {
      ApiResponse<void> response = await API.to.updatePlaceViewCnt(place.value.idx);
      if(response.success) {
      } else {
        print("updatePlaceViewCnt error:: ${response.code} ${response.message}");
        Utils.showToast(response.message);
      }
    }
  }

  void scrollToBottom() {
    double replyPosition = replyScrollController.position.maxScrollExtent;
    double bodyPosition = bodyScrollController.position.maxScrollExtent;
    replyScrollController.animateTo(replyPosition + 100, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    bodyScrollController.animateTo(bodyPosition + 100, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void onImageChanged(int index, CarouselPageChangedReason reason) {
    currentImage.value = index + 1;
  }

  Future<void> setMarker() async {
    LatLng position = LatLng(
      place.value.lat,
      place.value.lng
    );
    markers.add(
      Marker(
        markerId: position.json.toString(),
        position: position,
        height: 20,
        width: 20,
        icon: await OverlayImage.fromAssetImage(assetName: Asset().getMarker(place.value.category.type.getValue()))
      )
    );
  }

  void onPressedTitle() {
    if(App.to.user.value.idx != userIdx?.value) {
      Utils.moveTo(
        UiState.USER_HOME_SCREEN,
        arg: {
          'userIdx': userIdx?.value
        }
      );
    }
  }

  void onPressedReply(int _userIdx) async {
    if(_userIdx != App.to.user.value.idx) {
      Utils.moveTo(
        UiState.USER_HOME_SCREEN,
        arg: {
          'userIdx': _userIdx
        }
      );
    }
  }

  void placeUpdate(Place _place) async {
    if(updatePlace != null) {
      updatePlace!(_place);
      place.value = _place;
      fileList.clear();
      await getPlaceImage();
      tagList.clear();
      await getPlaceTag();
      markers.clear();
      currentImage.value = 1;
      await (await mapController.future).moveCamera(
        CameraUpdate.toCameraPosition(
          CameraPosition(
            target: LatLng(
              place.value.lat,
              place.value.lng
            ),
            zoom: 15
          )
        )
      );
      await setMarker();
    }
  }

  void moveToUpdatePlace() {
    Get.close(1);
    LatLng position = LatLng(place.value.lat, place.value.lng);
    Utils.moveTo(UiState.PLACE_UPDATE, arg: {
      'position': position,
      'placeCategoryList': placeCategoryList,
      'place': place,
      'placeUpdate': placeUpdate
    });
  }
}