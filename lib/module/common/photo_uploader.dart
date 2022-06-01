import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_together/widget/base_list_tile.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';

enum PhotoType { GALLERY, CAMERA, DEFAULT, NONE }

class PhotoUploader {
  static PhotoUploader get to => Get.find();

  RxString uploadPath = ''.obs;
  RxBool isDefaultImage = false.obs;

  void init() {
    uploadPath.value ='';
    isDefaultImage.value = false;
  }

  Future<PhotoType?> showDialog(BuildContext context) async {
    PhotoType? photoType;
    await BottomSheetModal.show(
      context: context,
      listTiles: [
        BaseListTile(
          title: '카메라 촬영',
          onTap: () {
            getImageFromCamera().then((value) {
              Get.close(1);
              if(value) photoType = PhotoType.CAMERA;
            });
          }
        ),
        BaseListTile(
          title: '앨범에서 사진 선택',
          onTap: ()  {
            getImageFromFile().then((value) {
              Get.close(1);
              if(value) photoType = PhotoType.GALLERY;
            });
          },
        ),
        BaseListTile(
          title: '기본 이미지로 변경',
          onTap: () {
            Get.close(1);
            changeDefaultImage();
            photoType = PhotoType.DEFAULT;
          }
        )
      ]
    );
    return photoType;
  }

  Future<bool> getImageFromFile() async {
    try {
      PickedFile? pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        uploadPath.value = pickedFile.path;
        isDefaultImage.value = false;
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print("getImageFromFile error:: $e");
      return false;
    }
  }

  Future<bool> getImageFromCamera() async {
    try {
      PickedFile? pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        uploadPath.value = pickedFile.path;
        isDefaultImage.value = false;
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print("getImageFromCamera error:: $e");
      return false;
    }
  }

  void changeDefaultImage() {
    uploadPath.value = '';
    isDefaultImage.value = true;
  }
}