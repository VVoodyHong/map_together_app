// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_together/widget/base_list_tile.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';

enum PhotoType { GALLERY, CAMERA, DEFAULT, NONE }

class PhotoUploader {
  static PhotoUploader get to => Get.find();

  RxString uploadPath = ''.obs;
  RxBool isDefaultImage = false.obs;
  RxList<String> uploadPathList = <String>[].obs;

  void init() {
    uploadPath.value ='';
    isDefaultImage.value = false;
    uploadPathList.clear();
  }

  Future<PhotoType?> showDialog(BuildContext context, {bool? multiImage}) async {
    PhotoType? photoType;
    await BottomSheetModal.showList(
      context: context,
      listTiles: !(multiImage ?? false) ? [
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
            getImageFromFile(multiImage ?? false).then((value) {
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
      ] : [
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
            getImageFromFile(multiImage ?? false).then((value) {
              Get.close(1);
              if(value) photoType = PhotoType.GALLERY;
            });
          },
        ),
      ]
    );
    return photoType;
  }

  Future<bool> getImageFromFile(bool multiImage) async {
    try {
      if(multiImage) {
        List<PickedFile>? pickedFile = await ImagePicker.platform.pickMultiImage();
        if(pickedFile != null) {
          for (PickedFile file in pickedFile) {
            CroppedFile? croppedFile = await PhotoUploader.to.resizeImage(file.path);
            if(croppedFile != null) {
              uploadPathList.add(croppedFile.path);
            }
          }
          return true;
        } else {
          return false;
        }
      } else {
        PickedFile? pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          CroppedFile? croppedFile = await PhotoUploader.to.resizeImage(pickedFile.path);
          if(croppedFile != null) {
            uploadPath.value = croppedFile.path;
            isDefaultImage.value = false;
          }
          return true;
        } else {
          return false;
        } 
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
        CroppedFile? croppedFile = await PhotoUploader.to.resizeImage(pickedFile.path);
        if(croppedFile != null) {
          uploadPath.value = croppedFile.path;
          isDefaultImage.value = false;
        }
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print("getImageFromCamera error:: $e");
      return false;
    }
  }

  Future<CroppedFile?> resizeImage(String sourcePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '사진 편집',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        IOSUiSettings(
          title: '',
        ),
      ],
    );
    return croppedFile;
  }

  void changeDefaultImage() {
    uploadPath.value = '';
    isDefaultImage.value = true;
  }
}