import 'package:fluttertoast/fluttertoast.dart';

import '../style/app_colors.dart';

class AppToast {
  AppToast._();

  static void successToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColors.black,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }

  static void errorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColors.primary1,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }
}



