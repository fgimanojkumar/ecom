import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/dialogs.dart';

class SettingsController extends GetxController {
  final Dialogs _dialogs = Dialogs();

  final isDarkMode = false.obs;
  final selectedLanguage = 'English'.obs;
  final notificationsEnabled = true.obs;
  final emailNotifications = true.obs;
  final smsNotifications = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isDarkMode;
    selectedLanguage.value = _labelFromLocale(Get.locale);
  }

  void toggleDarkMode() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications() => notificationsEnabled.toggle();
  void toggleEmailNotifications() => emailNotifications.toggle();
  void toggleSmsNotifications() => smsNotifications.toggle();

  void changeLanguage(String language) {
    selectedLanguage.value = language;
    final locale = _localeFromLabel(language);
    Get.updateLocale(locale);
    Get.snackbar('Language', 'Language changed to $language');
  }

  Locale _localeFromLabel(String language) {
    switch (language) {
      case 'Hindi':
        return const Locale('hi', 'IN');
      case 'Spanish':
        return const Locale('es', 'ES');
      case 'English':
      default:
        return const Locale('en', 'US');
    }
  }

  String _labelFromLocale(Locale? locale) {
    switch (locale?.languageCode) {
      case 'hi':
        return 'Hindi';
      case 'es':
        return 'Spanish';
      case 'en':
      default:
        return 'English';
    }
  }

  Future<void> logout() async {
    Get.offNamed('/login');
  }

  void showLogoutConfirmation() {
    _dialogs.logoutConfirm(
      'Logout from account?',
      'You can login again anytime with your credentials.',
    );
  }

  Future<void> deleteAccount() async {
    Get.offNamed('/login');
  }
}
