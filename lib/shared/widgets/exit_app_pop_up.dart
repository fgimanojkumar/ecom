import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/app/controller/app_controller.dart';
import '../style/app_colors.dart';

Future exitApp(BuildContext context) {
  final AppController appController = Get.put(AppController());
  return showDialog(
    context: context,
    barrierColor: AppColors.black.withValues(alpha: 0.22),
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
                color: AppColors.body,
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'resources/images/login_img.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.exit_to_app_rounded,
                  color: AppColors.primary1,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Exit Application',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.black1,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to exit/close the application?',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.muteIconColor,
            height: 1.4,
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.black1,
                    side: const BorderSide(color: AppColors.white2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: Get.back,
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary1,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  onPressed: () => (!kIsWeb) ? exit(0) : appController.logout(),
                  child: const Text('Exit'),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
