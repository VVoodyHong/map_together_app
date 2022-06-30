import 'package:get/get.dart';
import 'package:map_together/model/response/api_response.dart';
import 'package:map_together/navigator/ui_logic.dart';
import 'package:map_together/navigator/ui_state.dart';
import 'package:map_together/rest/api.dart';
import 'package:map_together/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingX extends GetxController {
  static SettingX get to => Get.find();

  late SharedPreferences prefs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  void contact() {
    Uri uri = Uri(
      scheme: 'mailto',
      path: 'official.mapto@gmail.com',
      query: encodeQueryParameters({
        'subject': '문의사항'
      })
    );
    launchUrl(uri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void logout() {
    Utils.showDialog(
      message: '로그아웃 하시겠습니까?',
      onConfirm: () {
        prefs.setString('jwt', '');
        Utils.showToast('로그아웃이 완료되었습니다.');
        UiLogic.changeUiState(UiState.LOGIN);
      }
    );
  }

  void deleteUser() {
    Utils.showDialog(
      title: '회원탈퇴 하시겠습니까?',
      message: '데이터는 전부 즉시 삭제되며,\n탈퇴 이후에는 복구할 수 없습니다.',
      onConfirm: () async {
        ApiResponse<void> response = await API.to.deleteUser();
        if(response.success) {
          prefs.setString('jwt', '');
          Utils.showToast('회원탈퇴가 완료되었습니다.');
          UiLogic.changeUiState(UiState.LOGIN);

        } else {
          print("getPlaceCategory error:: ${response.code} ${response.message}");
          Utils.showToast(response.message);
        }  
      }
    );
  }

  void moveToChangePassword() {
    Utils.moveTo(UiState.CHANGE_PASSWORD);
  }

  void moveToTermsAndPolicy() {
    Utils.moveTo(UiState.TERMS_AND_POLICY);
  }
}