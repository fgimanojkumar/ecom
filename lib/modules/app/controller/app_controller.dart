import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/demo/demo_account_store.dart';
import '../../../shared/widgets/dialogs.dart';

class AppController extends GetxController {
  Dialogs dialogs = Dialogs();

  logoutConfirm() {
    dialogs.logoutConfirm(
      'Are you sure want to logout',
      'Are you sure you want to log out from this device?',
    );
  }

  Future<void> logout() async {
    await DemoAccountStore.signOut();
    Get.offAllNamed(AppRoutes().login);
  }
}
