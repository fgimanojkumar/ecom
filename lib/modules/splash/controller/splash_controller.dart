import 'package:get/get.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(milliseconds: 700), () {
      // Navigate to onboarding flow first.
      Get.offNamed('/onboarding');
    });
  }
}
