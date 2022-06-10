import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/model/type/place_category_type.dart';
import 'package:map_together/module/place/controller/place_category_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_tff.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';
import 'package:map_together/widget/button_round.dart';

class PlaceCategoryScreen extends GetView<PlaceCategoryX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: BaseAppBar(
        title: controller.deleteMode.value ? '카테고리 삭제' : '카테고리 선택',
        leading: BaseButton.iconButton(
          iconData: Icons.arrow_back,
          onPressed: () => Get.close(1)
        ),
        actions: [
          controller.deleteMode.value ? Container() : BaseButton.iconButton(
            iconData: Icons.add,
            onPressed: () {_showModal(context);}
          ),
          BaseButton.iconButton(
            iconData: controller.deleteMode.value ? Icons.close : Icons.delete,
            onPressed: controller.changeDeleteMode
          ),
        ]
      ).init(),
      body: _body()
    ));
  }
  
  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Obx(() => Dialog(
          elevation: 0,
          child: Container(
            width: Get.width * 0.5,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '카테고리 추가',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  )
                ),
                BaseTextFormField(
                  controller: controller.nameController,
                  hintText: '카테고리명 입력',
                  maxLength: 20,
                ).marginSymmetric(horizontal: 15),
                GestureDetector(
                  onTap: () {
                    BottomSheetModal.showWidget(
                      context: context,
                      widget: _gridMarkers()
                    );
                  },
                  child: Container(
                    color: MtColor.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          controller.selectedMarker.value == PlaceCategoryType.NONE ? '마커 선택' : '선택된 마커',
                          style: TextStyle(
                            fontSize: 18,
                          )
                        ),
                        Spacer(),
                        controller.selectedMarker.value == PlaceCategoryType.NONE ? Icon(
                          Icons.keyboard_arrow_down
                        ) : Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Asset().getMarker(controller.selectedMarker.value.getValue()))
                            )
                          )
                        )
                      ],
                    ).marginOnly(left: 15, right: 15, top: 15, bottom: 30),
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ButtonRound(
                        label: '완료',
                        onTap: controller.createPlaceCategory
                      ).marginOnly(left: 10, right: 5)
                    ),
                    Expanded(
                      child: ButtonRound(
                        label: '취소',
                        onTap: () {
                          Get.close(1);
                          controller.nameController.clear();
                          controller.selectedMarker.value = PlaceCategoryType.NONE;
                        },
                        buttonColor: MtColor.paleGrey,
                        textColor: MtColor.grey,
                      ).marginOnly(left: 5, right: 10)
                    )
                  ]
                )
              ]
            )
          )
        ));
      }
    ).then((_) => {
      controller.nameController.clear(),
      controller.selectedMarker.value = PlaceCategoryType.NONE
    });
  }

  Widget _gridMarkers() {
    return Container(
      padding: EdgeInsets.all(30),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1.0,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ),
        itemCount: Asset.markers.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              controller.setSelectedMarker(Asset.markers[index]);
              Get.close(1);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset().getMarker(Asset.markers[index].getValue()))
                )
              )
            ),
          );
        }
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (BuildContext context, int index) {
                return _imageTextField(index);
              }
            ),
          ),
          controller.deleteMode.value ? ButtonRound(
            label: '삭제',
            onTap: controller.deletePlaceCategory,
            buttonColor: controller.deleteList.isEmpty ? MtColor.paleGrey : null,
            textColor: controller.deleteList.isEmpty ? MtColor.grey : null,
          ).marginAll(15) : ButtonRound(
            label: '완료',
            onTap: controller.selectedCategory.value != -1 ? controller.setCategory : () {},
            buttonColor: controller.selectedCategory.value == -1 ? MtColor.paleGrey : null,
            textColor: controller.selectedCategory.value == -1 ? MtColor.grey : null,
          ).marginAll(15),
        ],
      )
    );
  }

  Widget _imageTextField(int index) {
    return Obx(() =>InkWell(
      onTap: () {controller.deleteMode.value ? controller.setDeleteList(index) : controller.setSelectedCategory(index);},
      child: Container(
        padding: EdgeInsets.all(15),
        color: controller.deleteMode.value ?
          controller.deleteList.contains(index) ?
          MtColor.paleGrey.withOpacity(0.3) :
            null :
          controller.selectedCategory.value == index ?
          MtColor.paleGrey.withOpacity(0.3) :
            null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Asset().getMarker(controller.list[index].type.getValue()))
                )
              )
            ),
            Expanded(
              child: Text(
                controller.list[index].name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            controller.deleteMode.value ?
              controller.deleteList.contains(index) ?
                Icon(
                  Icons.check,
                  color: MtColor.signature
                ) :
                Container() :
              index == controller.selectedCategory.value ?
              Icon(
                Icons.check,
                color: MtColor.signature
              ) :
              Container()
          ],
        ),
      ),
    ));
  }
}