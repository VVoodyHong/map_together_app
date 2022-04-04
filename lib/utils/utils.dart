import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_together/utils/constants.dart';

class Utils {

  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: MtColor.paleBlack,
      textColor: MtColor.white,
      fontSize: FontSize.medium
    );
  }
}