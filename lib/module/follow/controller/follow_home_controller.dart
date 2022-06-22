import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map_together/model/follow/follow_search.dart';
import 'package:map_together/model/follow/follow_simple.dart';
import 'package:map_together/model/follow/follows.dart';
import 'package:map_together/model/page/request_page.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/model/type/follow_type.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/utils/utils.dart';

class FollowHomeX extends GetxController {
  static FollowHomeX get to => Get.find();

  RxInt? userIdx = (null as int).obs;
  RxString userNickname = ''.obs;
  Rx<UiState> currentTab = UiState.FOLLOW_FOLLOWER.obs;
  RxBool isLoading = false.obs;
  RxInt followerCount = (null as int).obs;
  RxInt followingCount = (null as int).obs;

  // search follower
  RxBool followerHasValue = false.obs;
  TextEditingController followerSearchController = TextEditingController();
  RxInt followerPage = 1.obs;
  RxBool isLastFollower = false.obs;
  RxBool isSearchedFollower = false.obs;
  RxList<FollowSimple> followerList = <FollowSimple>[].obs;
  ScrollController followerScrollController = ScrollController();

  // search following
  RxBool followingHasValue = false.obs;
  TextEditingController followingSearchController = TextEditingController();
  RxInt followingPage = 1.obs;
  RxBool isLastFollowing = false.obs;
  RxBool isSearchedFollowing = false.obs;
  RxList<FollowSimple> followingList = <FollowSimple>[].obs;
  ScrollController followingScrollController = ScrollController();

  @override
  void onInit() async {
    userIdx!.value = Get.arguments['userIdx'];
    userNickname.value = Get.arguments['userNickname'];
    currentTab.value = Get.arguments['currentTab'];
    followerCount.value = Get.arguments['followerCount'];
    followingCount.value = Get.arguments['followingCount'];
    followerScrollController.addListener(listenScrolling);
    followingScrollController.addListener(listenScrolling);
    await searchFollow();
    super.onInit();
  }

  void listenScrolling() async {
    if(currentTab.value == UiState.FOLLOW_FOLLOWER) {
      if (followerScrollController.hasClients && followerScrollController.position.atEdge) {
        bool isTop = followerScrollController.position.pixels == 0;
        if (!isTop && !isLastFollower.value) {
          followerPage++;
          await searchFollow();   
        }
      }
    } else {
      if (followingScrollController.hasClients && followingScrollController.position.atEdge) {
        bool isTop = followingScrollController.position.pixels == 0;
        if (!isTop && !isLastFollowing.value) {
          followingPage++;
          await searchFollow(); 
        }
      }
    }
  }

  Future<void> searchFollow() async {
    RequestPage requestPage = RequestPage(
      page: currentTab.value == UiState.FOLLOW_FOLLOWER ? followerPage.value : followingPage.value,
      size: DefaultPage.size
    );
    FollowSearch followSearch = FollowSearch(
      keyword: currentTab.value == UiState.FOLLOW_FOLLOWER ? followerSearchController.text : followingSearchController.text,
      requestPage: requestPage,
      followType: currentTab.value == UiState.FOLLOW_FOLLOWER ? FollowType.FOLLOWER : FollowType.FOLLOWING,
      userIdx: userIdx!.value
    );
    isLoading.value = true;
    ApiResponse<Follows> response = await API.to.searchFollow(followSearch);
    if(response.success) {
      if(currentTab.value == UiState.FOLLOW_FOLLOWER) {
        followerList.addAll(response.data?.list ?? []);
        isLastFollower.value = response.data!.last;
        isSearchedFollower.value = true;
      } else {
        followingList.addAll(response.data?.list ?? []);
        isLastFollowing.value = response.data!.last;
        isSearchedFollowing.value = true;
      }
    } else {
      print("searchFollow error:: ${response.code} ${response.message}");
      Utils.showToast(response.message);
    }
    isLoading.value = false;
  }

  void onChangeTab(UiState state) async {
    currentTab.value = state;
    if(!isSearchedFollower.value) {
      await searchFollow();
    }
    if(!isSearchedFollowing.value) {
      await searchFollow();
    }
  }

  void doSearch() async {
    if(currentTab.value == UiState.FOLLOW_FOLLOWER) {
      if(followerSearchController.text.trim().isEmpty) {
        Utils.showToast('검색어를 입력해주세요');
        return;
      }
    } else {
      if(followingSearchController.text.trim().isEmpty) {
        Utils.showToast('검색어를 입력해주세요');
        return;
      }
    }
    
    if(currentTab.value == UiState.FOLLOW_FOLLOWER) {
      followerList.clear();
      followerPage.value = 1;
      isLastFollower.value = false;
    } else {
      followingList.clear();
      followingPage.value = 1;
      isLastFollowing.value = false;
    }
    await searchFollow();
  }

  void onChangeSearch(String value) {
    if(currentTab.value == UiState.FOLLOW_FOLLOWER) {
      followerHasValue.value = followerSearchController.text.isNotEmpty;
    } else {
      followingHasValue.value = followingSearchController.text.isNotEmpty;
    }
  }

  void clearSearch() async {
    if(currentTab.value == UiState.FOLLOW_FOLLOWER) {
      followerSearchController.clear();
      followerHasValue.value = false;
      followerList.clear();
      followerPage.value = 1;
      isLastFollower.value = false;
    } else {
      followingSearchController.clear();
      followingHasValue.value = false;
      followingList.clear();
      followingPage.value = 1;
      isLastFollowing.value = false;
    }
    await searchFollow();
  }

  void moveToUserHome(int userIdx) {
    Utils.moveTo(
      UiState.USER_HOME_SCREEN,
      arg: {
        'userIdx': userIdx
      }
    );
  }
}