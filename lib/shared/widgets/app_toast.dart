import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';

class AppToast {
  AppToast._();

  static void successToast(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: AppColors.black.withValues(alpha: 0.75),
      colorText: AppColors.white,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.check_circle_rounded, color: AppColors.white),
      shouldIconPulse: false,
    );
  }

  static void errorToast(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: AppColors.primary1.withValues(alpha: 0.9),
      colorText: AppColors.white,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.error_rounded, color: AppColors.white),
      shouldIconPulse: false,
    );
  }
}
