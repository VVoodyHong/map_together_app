import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/common/photo_uploader.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/type/exist_type.dart';
import 'package:map_together/model/user/user.dart';
import 'package:map_together/model/user/user_update.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';

class EnterInfoX extends GetxController {
  static EnterInfoX get to => Get.find();

  RxBool isCheckedPrivacyStatement = false.obs;
  RxBool isCheckedTermsOfService = false.obs;
  RxBool isCheckedTermsOfLocationService = false.obs;

  RxBool isValidNickname = false.obs;
  RxBool availableNickname = false.obs;
  RxBool isEmptyName = true.obs;
  RxBool isEmptyIntroduce = true.obs;

  TextEditingController nicknameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController introduceController = TextEditingController();
  Rx<PhotoType> photoType = PhotoType.NONE.obs;

  Completer<NaverMapController> mapController = Completer();
  Rx<LatLng> position = (null as LatLng).obs;
  RxDouble zoom = (null as double).obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    PhotoUploader.to.init();
    position.value = LatLng(DefaultPosition.lat, DefaultPosition.lng);
    zoom.value = DefaultPosition.zoom;
    super.onInit();
  }

  void onChangePrivacyStatement() {
    isCheckedPrivacyStatement.value = !isCheckedPrivacyStatement.value;
  }

  void onChangeTermsOfService() {
    isCheckedTermsOfService.value = !isCheckedTermsOfService.value;
  }

  void onChangeTermsOfLocationService() {
    isCheckedTermsOfLocationService.value = !isCheckedTermsOfLocationService.value;
  }

  void onChangeNickname(String nickname) {
    availableNickname.value = false;
    RegExp regExp = RegExp(r'^[0-9a-zA-Z\s+._]{6,}$');
    if(regExp.hasMatch(nickname)) {
      isValidNickname.value = true;
    } else {
      if(isValidNickname.value) isValidNickname.value = false;
    }
  }

  void onChangeName(String value) {
    isEmptyName.value = nameController.text.isEmpty;
  }

  void onChangeIntroduce(String value) {
    isEmptyIntroduce.value = introduceController.text.isEmpty;
  }

  void showDialog(BuildContext context) {
    FocusScope.of(context).unfocus();
    PhotoUploader.to.showDialog(context).then((photoType) => {
      if(photoType != null) {
        this.photoType.value = photoType,
      }
    });
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void onCameraIdle() {
    mapController.future.then((value) {
      value.getCameraPosition().then((value) {
        position.value = value.target;
        zoom.value = value.zoom;
      });
    });
  }

  void onChangeZoom(double _zoom) async {
    zoom.value = _zoom;
    await (await mapController.future).moveCamera(
      CameraUpdate.toCameraPosition(
        CameraPosition(
          target: position.value,
          zoom: _zoom
        )
      )
    );
  }

  void checkExistUser() async {
    ApiResponse<void> response = await API.to.checkExistUser(nicknameController.text, ExistType.NICKNAME);
    if(response.success) {
      availableNickname.value = true;
      Utils.showToast('사용 가능한 닉네임입니다.');
    } else {
      availableNickname.value = false;
      Exception("checkExistUser error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
  }

  void updateUser() async {
    UserUpdate userUpdate = UserUpdate(
      nickname: nicknameController.text,
      name: nameController.text,
      introduce: introduceController.text,
      lat: position.value.latitude,
      lng: position.value.longitude,
      zoom: zoom.value
    );
    File? file = photoType.value == PhotoType.DEFAULT || photoType.value == PhotoType.NONE ? null : File(PhotoUploader.to.uploadPath.value);
    isLoading.value = true;
    ApiResponse<User> response = await API.to.updateUser(userUpdate, file);
    if(response.success) {
      App.to.user.value = response.data!;
      UiLogic.changeUiState(UiState.ROOT);
    } else {
      print("updateUser error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }

  void moveToSecondScreen() {
    Utils.moveTo(UiState.ENTER_INFO_SECOND);
  }

  void moveToThirdScreen() {
    Utils.moveTo(UiState.ENTER_INFO_THIRD);
  }

  void moveToFourthScreen() {
    Utils.moveTo(UiState.ENTER_INFO_FOURTH);
  }

  void moveToFifthScreen() {
    print(photoType.value);
    Utils.moveTo(UiState.ENTER_INFO_FIFTH);
  }
}