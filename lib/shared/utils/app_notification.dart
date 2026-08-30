import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/app_colors.dart';

/// Single entry-point for all in-app notifications — replaces the mix of
/// AppToast, Get.snackbar, and raw SnackBar calls across the project.
abstract class AppNotification {
  static void success(String message, {String title = 'Success'}) {
    _show(
      title: title,
      message: message,
      color: AppColors.success,
      icon: Icons.check_circle_rounded,
    );
  }

  static void error(String message, {String title = 'Error'}) {
    _show(
      title: title,
      message: message,
      color: AppColors.error,
      icon: Icons.error_rounded,
    );
  }

  static void info(String message, {String title = 'Info'}) {
    _show(
      title: title,
      message: message,
      color: AppColors.info,
      icon: Icons.info_rounded,
    );
  }

  static void warning(String message, {String title = 'Warning'}) {
    _show(
      title: title,
      message: message,
      color: AppColors.warning,
      icon: Icons.warning_rounded,
    );
  }

  static void _show({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      colorText: AppColors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      icon: Icon(icon, color: AppColors.white, size: 22),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      boxShadows: [
        BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
