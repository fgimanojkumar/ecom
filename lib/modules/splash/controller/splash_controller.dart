import 'package:get/get.dart';
import '../../../shared/widgets/app_update_dialog.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(milliseconds: 700), () async {
      await AppUpdateDialog.checkAndShow();
      Get.offNamed('/onboarding');
    });
  }
}
