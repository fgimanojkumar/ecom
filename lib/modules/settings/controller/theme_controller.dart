import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  final isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Sync with current system brightness on first launch
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDark.value = brightness == Brightness.dark;
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
