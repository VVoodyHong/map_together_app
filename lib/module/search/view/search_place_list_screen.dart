import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/model/place/place_simple.dart';
import 'package:map_together/module/search/controller/search_place_list_controller.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';
import 'package:map_together/widget/base_app_bar.dart';
import 'package:map_together/widget/base_button.dart';
import 'package:map_together/widget/empty_view.dart';
import 'package:map_together/widget/rating_bar.dart';

class SearchPlaceListScreen extends GetView<SearchPlaceListX> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: BaseAppBar(
            title: '검색  "${controller.keyword.value}"',
            leading: BaseButton.iconButton(
              iconData: Icons.arrow_back,
              onPressed: () => Get.close(1)
            ),
          ).init(),
          body: SafeArea(
            child: _body()
          )
        ),
        Utils.showLoading(isLoading: controller.isLoading.value)
      ],
    ));
  }

  Widget _body() {
    return SafeArea(
      child: controller.placeList.isNotEmpty ? GridView.builder(
        controller: controller.scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.75,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: controller.placeList.length,
        itemBuilder: (BuildContext context, int index) {
          PlaceSimple place = controller.placeList[index];
          String distance = Utils.getDistance(
            controller.currentPlace.value.latitude,
            controller.currentPlace.value.longitude,
            place.lat,
            place.lng
          );
          String address = place.address.split(' ')[0] + ' ' + place.address.split(' ')[1];
          return InkWell(
            onTap: () {controller.moveToPlace(place.userIdx, place.userNickname, place);},
            child: Column(
              children: [
                Container(
                  height: Get.width / 2 - 22.5,
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _imageProvider(place.representImg)
                    )
                  ),
                ),
                SizedBox(
                  height: (Get.width / 2 - 22.5) * 0.75,
                  width: Get.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: TextStyle(
                          fontSize: Get.width / 24,
                          fontWeight: FontWeight.w600
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).marginOnly(top: Get.width / 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: Get.width / 28,
                              color: MtColor.grey,
                              fontWeight: FontWeight.w600
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            distance,
                            style: TextStyle(
                              fontSize: Get.width / 28,
                              color: MtColor.grey,
                              fontWeight: FontWeight.w600
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ).marginOnly(top: Get.width / 100),
                      RatingBar(
                        initialRating: place.favorite,
                        onRatingUpdate: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: MtColor.signature,
                        ),
                        itemSize: Get.width / 20,
                        horizonItemPadding: 0
                      ).marginOnly(top: Get.width / 100),
                      Text(
                        place.description ?? '',
                        style: TextStyle(
                          fontSize: Get.width / 28,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).marginOnly(top: Get.width / 100)
                    ],
                  )
                ),
              ],
            ),
          );
        }
      ).marginSymmetric(horizontal: 15) : EmptyView(text: '검색 결과가 존재하지 않습니다.')
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