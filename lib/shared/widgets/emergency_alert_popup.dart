import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';

/// Shows an emergency alert dialog with an image and acknowledgement action.
Future<void> showEmergencyAlertDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: AppColors.black.withValues(alpha: 0.35),
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'resources/images/bottle.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.error,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Emergency Alert',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.black1,
              ),
            ),
          ],
        ),
        content: const Text(
          'This is a test emergency alert. Please stay calm and follow the safety instructions provided by the app.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.muteIconColor,
            height: 1.4,
          ),
        ),
        actions: <Widget>[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
              ),
              onPressed: Get.back,
              child: const Text('OK, Got it'),
            ),
          ),
        ],
      );
    },
  );
}
