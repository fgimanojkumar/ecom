import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/flutterStorage/flutter_storage_keys.dart';
import '../../../shared/localStorage/local_storage.dart';
import '../../../shared/widgets/dialogs.dart';

class AppController extends GetxController {
  Dialogs dialogs = Dialogs();
  LocalStorage localStorage = LocalStorage();

  logoutConfirm() {
    dialogs.logoutConfirm(
      'Are you sure want to logout',
      'Are you sure you want to log out from this device?',
    );
  }

  logout() {
    localStorage.removeStorageItem(FlutterStorageKeys().userId);
    localStorage.removeStorageItem(FlutterStorageKeys().token);
    Get.offAllNamed(AppRoutes().login);
    Get.back();
  }
}
