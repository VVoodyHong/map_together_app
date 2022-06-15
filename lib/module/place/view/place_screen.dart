// ignore_for_file: invalid_use_of_protected_member

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/file/file.dart';
import 'package:map_together/model/tag/tag.dart';
import 'package:map_together/module/place/controller/place_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/base_list_tile.dart';
import 'package:map_together/widget/bottom_sheet_modal.dart';
import 'package:map_together/widget/image_round.dart';
import 'package:map_together/widget/rating_bar.dart';

class PlaceScreen extends GetView<PlaceX> {

  late final String? uniqueTag;

  @override
  String? get tag => uniqueTag;

  PlaceScreen(String tag) {
    uniqueTag = tag;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: BaseAppBar(
          title: controller.userNickName?.value ?? '',
          leading: BaseButton.iconButton(
            iconData: Icons.arrow_back,
            onPressed: () => Get.close(1)
          ),
          centerTitle: false,
          onPressedTitle: controller.onPressedTitle
        ).init(),
        body: Column(
          children: [
            Expanded(child: _body()),
            _replyBar()
          ],
        ),
      ),
    ));
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _naverMap(),
          _contents()
        ],
      ),
    );
  }

  Widget _naverMap() {
    return SizedBox(
      height: controller.mapHeight.value,
      child: NaverMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            controller.place.value.lat,
            controller.place.value.lng
          ),
          zoom: 15,
        ),
        markers: controller.markers.value
      )
    );
  }

  Widget _contents() {
    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          controller: controller.bodyScrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200 - controller.mapHeight.value
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      controller.place.value.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                  BaseButton.iconButton(
                    iconData: controller.isLike.value ? Icons.favorite : Icons.favorite_outline,
                    color: MtColor.red.withOpacity(0.8),
                    size: 30,
                    boxConstraints: BoxConstraints(
                      minWidth: 30,
                      minHeight: 30
                    ),
                    onPressed: () {
                      controller.isLike.value ? controller.deletePlaceLike() : controller.createPlaceLike();
                    }
                  ),
                ],
              ).marginOnly(top: 15),
              Row(
                children: [
                  RatingBar(
                    initialRating: controller.place.value.favorite,
                    onRatingUpdate: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: MtColor.signature,
                    ),
                    itemSize: 20,
                    horizonItemPadding: 0,
                  ),
                  Text(
                    Utils.trimDate(controller.place.value.createAt),
                    style: TextStyle(
                      color: MtColor.grey
                    ),
                  ).marginOnly(left: 5)
                ],
              ).marginOnly(top: 10),
              Text(
                controller.place.value.address,
                style: TextStyle(
                  color: MtColor.paleBlack,
                  fontSize: 16
                )
              ).marginOnly(top: 10),
              (controller.place.value.description ?? '').isNotEmpty ? Text(
                controller.place.value.description ?? '',
                style: TextStyle(
                  fontSize: 16
                )
              ).marginOnly(top: 15) : Container(),
              _images(),
              _tags(),
              controller.totalLike.value != 0 ? Row(
                children: [
                  Text(
                    '${controller.totalLike.value}명',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    '이 좋아합니다.',
                    style: TextStyle(
                      fontSize: 16,
                    )
                  )
                ],
              ).marginOnly(top: 15, bottom: 15) : Container().marginOnly(top: 15, bottom: 15),
              _replys()
            ],
          ).marginSymmetric(horizontal: 15),
        ),
      ),
    );
  }

  Widget _images() {
    return controller.fileList.isNotEmpty ? Stack(
      children: [
        CarouselSlider(
          items: _carouselItems(),
          options: CarouselOptions(
            viewportFraction: 1.0,
            aspectRatio: 1,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            onPageChanged: controller.onImageChanged
          )
        ),
        controller.fileList.length > 1 ? Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MtColor.black.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Text(
              '${controller.currentImage} / ${controller.fileList.length}',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ) : Container()
      ],
    ).marginOnly(top: 15) : Container();
  }

  Widget _tags() {
    List<Widget> _list = [];
    for (Tag tag in controller.tagList) {
      _list.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.only(right: 10, top: 5),
          decoration: BoxDecoration(
            color: MtColor.signature,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Text(
            tag.name ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
          ),
        )
      );
    }
    return controller.tagList.isNotEmpty ? Wrap(
      children: _list,
    ).marginOnly(top: 10) : Container();
  }

  List<Widget> _carouselItems() {
    List<Widget> _list = [];
    for (File file in controller.fileList) {
      _list.add(
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(file.url)
              )
            ),
          ),
        )
      );
    }
    return _list;
  }

  Widget _replys() {
    return SizedBox(
      height: controller.replyList.isNotEmpty ? 300 : 0,
      child: Stack(
        children: [
          ListView.builder(
            controller: controller.replyScrollController,
            shrinkWrap: true,
            itemCount: controller.replyList.length,
            itemBuilder: (BuildContext context, int index) {
              return _replyCard(context, index).marginOnly(bottom: 15);
            },
          ),
          Utils.showLoading(isLoading: controller.isLoading.value)
        ],
      ),
    );
  }

  Widget _replyCard(BuildContext context, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {controller.onPressedReply(controller.replyList[index].userIdx);},
          child: ImageRound(
            imagePath: controller.replyList[index].userProfileImg,
            imageSize: 60
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {controller.onPressedReply(controller.replyList[index].userIdx);},
                child: Text(
                  controller.replyList[index].userNickname,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                Utils.trimDate(controller.replyList[index].createAt),
                style: TextStyle(
                  color: MtColor.grey
                ),
              ).marginOnly(top: 5),
              Text(
                controller.replyList[index].reply,
                style: TextStyle(
                  fontSize: 16
                ),
              ).marginOnly(top: 5),
            ],
          ).marginOnly(left: 10),
        ),
        App.to.user.value.idx == controller.replyList[index].userIdx ? BaseButton.iconButton(
          iconData: Icons.more_vert,
          onPressed: () => BottomSheetModal.showList(
            context: context,
            listTiles: _listTiles(context, index)
          )
        ) : Container()
      ],
    );
  }

  List<BaseListTile> _listTiles(BuildContext context, int index) {
    return [
      BaseListTile(
        title: '삭제',
        onTap: () {controller.deletePlaceReply(index);},
        icon: Icons.delete
      ),
    ];
  }

  Widget _replyBar() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.replyController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              maxLength: 500,
              autofocus: false,
              decoration: InputDecoration(
                counterText: ''     ,
                focusColor: MtColor.white,
                hintText: '댓글 쓰기',
                hintStyle: TextStyle(
                    color: MtColor.grey,
                    fontSize: 16
                ),
                filled: true,
                fillColor: MtColor.paleGrey,
                enabledBorder: _border(),
                focusedBorder: _border(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              onFieldSubmitted: (value) {controller.createPlaceReply();},
            ),
          ),
          BaseButton.iconButton(
            iconData: Icons.send,
            color: MtColor.signature,
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              controller.createPlaceReply();
            },
          )
        ],
      ),
    );
  }

  OutlineInputBorder _border(){
    return OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(6)
    );
  }
}