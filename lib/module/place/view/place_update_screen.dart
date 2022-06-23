// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/module/place/controller/place_update_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_tff.dart';
import 'package:map_together/widget/button_round.dart';
import 'package:map_together/widget/image_uploader.dart';
import 'package:map_together/widget/rating_bar.dart';
import 'package:map_together/widget/tag_field.dart';

class PlaceUpdateScreen extends GetView<PlaceUpdateX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: BaseAppBar(
              title: '장소 수정',
              leading: BaseButton.iconButton(
                iconData: Icons.arrow_back,
                onPressed: () => Get.close(1)
              )
            ).init(),
            body: SafeArea(
              child: Column(
                children: [
                  _naverMap(),
                  _body(context),
                  _bottomButton()
                ]
              )
            )
          ),
          Utils.showLoading(isLoading: controller.isLoading.value)
        ],
        
      )
    ));
  }

  Widget _naverMap() {
    return SizedBox(
      height: 200,
      child: NaverMap(
        initialCameraPosition: CameraPosition(
          target: controller.position.value,
          zoom: 15,
        ),
        onMapCreated: controller.onMapCreated,
        locationButtonEnable: true,
        onMapTap: controller.onMapTap,
        onSymbolTap: controller.onSymbolTap,
        markers: controller.markers.value
      )
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BaseTextFormField(
              controller: controller.nameController,
              hintText: '장소명을 입력해주세요.',
              onChanged: controller.onChangeName,
              maxLength: 64,
              enabled: true
            ).marginSymmetric(horizontal: 15),
            BaseTextFormField(
              controller: controller.addressController,
              hintText: '위치를 선택해 주소를 입력해주세요.',
              onChanged: controller.onChangeAddress,
              maxLength: 64,
              enabled: false
            ).marginSymmetric(horizontal: 15),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                controller.moveToCategory();
              },
              child: Container(
                color: MtColor.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    controller.categoryType.value != PlaceCategoryType.MARKER ? Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Asset().getMarker(controller.categoryType.value.getValue()))
                        )
                      )
                    ).marginOnly(right: 5) : Container(),
                    Text(
                      controller.categoryType.value == PlaceCategoryType.MARKER ? '카테고리 선택' : controller.categoryController.text,
                      style: TextStyle(
                        fontSize: 16,
                        color: controller.categoryType.value == PlaceCategoryType.MARKER ? MtColor.grey : MtColor.black
                      )
                    ),
                    Spacer(),
                    controller.categoryType.value == PlaceCategoryType.MARKER ? Icon(
                      Icons.keyboard_arrow_down
                    ) : Container()
                  ],
                ).marginAll(15)
              ),
            ),
            BaseTextFormField(
              controller: controller.descriptionController,
              hintText: '장소에 대한 설명을 입력해주세요.',
              maxLength: 1800,
              multiline: true,
            ).marginSymmetric(horizontal: 15),
            TagField(
              tagsController: controller.tagsController,
              onTagDelete: controller.onTagDelete,
            ).marginAll(15),
            ImageUploader(
              onCreate: () {},
              onDelete: (index) {controller.deleteImage(index);},
              images: controller.fileList.value
            ).marginAll(15),
            RatingBar(
              initialRating: controller.favorite.value,
              onRatingUpdate: (double value) {
                FocusScope.of(context).unfocus();
                controller.onChangeFavorite(value);
              },
              icon: Icon(
                Icons.favorite,
                color: MtColor.signature,
              )
            ),
          ],
        ),
      )
    );
  }

  Widget _bottomButton() {
    return ButtonRound(
      label: '완료',
      onTap: controller.updatePlace,
      buttonColor: !controller.isNameEmpty.value && !controller.isAddressEmpty.value && controller.categoryIdx.value != -1 ?
        MtColor.signature :
        MtColor.paleGrey,
      textColor: !controller.isNameEmpty.value && !controller.isAddressEmpty.value && controller.categoryIdx.value != -1 ?
        MtColor.white :
        MtColor.grey,
    ).marginOnly(left: 15, right: 15, top: 15, bottom: 15);
  }
}