import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/app.dart';
import 'package:map_together/model/place/place_simple.dart';
import 'package:map_together/module/news/controller/news_home_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/empty_view.dart';
import 'package:map_together/widget/image_round.dart';
import 'package:map_together/widget/rating_bar.dart';

class NewsHomeScreen extends GetView<NewsHomeX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: BaseAppBar(
            title: 'MapTogether',
            titleColor: MtColor.signature,
            titleWeight: FontWeight.bold,
            centerTitle: false,
            actions: _actions()
          ).init(),
          body: WillPopScope(
            onWillPop: App.to.exitApp,
            child: _body()
          )
        ),
        Utils.showLoading(isLoading: controller.isLoading.value)
      ],
    ));
  }

  List<Widget> _actions() {
    return [
      GestureDetector(
        onTap: controller.moveToSelectPlace,
        child: Container(
          color:Colors.white,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.address.value.isEmpty ? '전체' : controller.address.value,
                    style: TextStyle(
                      color: MtColor.black,
                      fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: MtColor.black
              )
            ],
          ).marginSymmetric(horizontal: 15),
        ),
      ),
    ];
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              color: MtColor.signature,
              onRefresh: () async {await controller.onRefresh();},
              child: controller.placeList.isNotEmpty ? ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.placeList.length,
                itemBuilder: (context, index) {
                  return _item(controller.placeList[index]).marginOnly(bottom: 15);
                },
              ) : !controller.isLoading.value ? EmptyView(text: '게시물이 존재하지 않습니다.') : Container(),
            )
          )
        ],
      )
    );
  }

  Widget _item(PlaceSimple place) {
    String distance = Utils.getDistance(
      controller.currentPlace.value.latitude,
      controller.currentPlace.value.longitude,
      place.lat,
      place.lng
    );
    return InkWell(
      onTap: () {controller.moveToPlace(place);},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {controller.moveToUserHome(place.userIdx);},
            child: Row(
              children: [
                ImageRound(
                  imagePath: place.userProfileImg,
                  imageSize: 40
                ).marginOnly(right: 10),
                Text(
                  place.userNickname,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                ),
              ],
            ).marginOnly(bottom: 10),
          ),
          Container(
            height: Get.width - 30,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _imageProvider(place.representImg)
              )
            ),
          ).marginOnly(bottom: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  place.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              Text(
                  place.placeCategoryName,
                  style: TextStyle(
                    fontSize: 15,
                    color: MtColor.grey,
                    fontWeight: FontWeight.w600
                  ),
                )
            ],
          ).marginOnly(bottom: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  place.address,
                  style: TextStyle(
                    fontSize: 15,
                    color: MtColor.grey,
                    fontWeight: FontWeight.w600
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                distance,
                style: TextStyle(
                  fontSize: 15,
                  color: MtColor.grey,
                  fontWeight: FontWeight.w600
                ),
              )
            ],
          ).marginOnly(bottom: 5),
          RatingBar(
            initialRating: place.favorite,
            onRatingUpdate: () {},
            icon: Icon(
              Icons.favorite,
              color: MtColor.signature,
            ),
            itemSize: 20,
            horizonItemPadding: 0
          ).marginOnly(bottom: 5),
          place.description != '' ? Text(
            place.description ?? '',
            style: TextStyle(
              fontSize: 16,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ).marginOnly(bottom: 5) : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  place.likeCount != null ? Row(
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        color: MtColor.signature,
                        size: 25,
                      ).marginOnly(right: 5),
                      Text(
                        '${place.likeCount}',
                        style: TextStyle(
                          color: MtColor.paleBlack,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ).marginOnly(right: 10) : Container(),
                  place.replyCount != null ? Row(
                    children: [
                      Icon(
                        Icons.mode_comment_outlined,
                        color: MtColor.signature,
                        size: 25,
                      ).marginOnly(right: 5, top: 2),
                      Text(
                        '${place.replyCount}',
                        style: TextStyle(
                          color: MtColor.paleBlack,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ) : Container(),
                ],
              ),
              Text(
                Utils.trimDate(place.createAt),
                style: TextStyle(
                  color: MtColor.grey
                ),
              )
            ],
          ),
        ]
      ).marginSymmetric(horizontal: 15),
    );
  }

  ImageProvider _imageProvider(String? imagePath){
    if(imagePath != null) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage(Asset.defaultProfile);
    }
  }
}