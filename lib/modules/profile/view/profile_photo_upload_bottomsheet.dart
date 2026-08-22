import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/style/app_style.dart';
import '../controller/profile_controller.dart';

class ProfilePhotoBottomSheet extends GetView<ProfileController> {
  const ProfilePhotoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          topDashLineForBottomSheet(),
          Text(
            'Upload Profile Photo',
            style: AppTextStyle.cardTitleStyle(),
          ),
          gapH24,
          uploadOptions(),
          gapH48,
        ],
      ),
    );
  }

  uploadOptions() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              controller.getImageFromCamera();
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.muteIconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 32,
                    color: AppColors.primary1,
                  ),
                  gapW12,
                  Expanded(
                    child: Text(
                      'Camera Capture',
                      style: AppTextStyle.headingH1('H3'),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        gapW16,
        Expanded(
          child: GestureDetector(
            onTap: () {
              controller.getImageFromGallery();

              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.muteIconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.photo,
                    size: 32,
                    color: AppColors.primary1,
                  ),
                  gapW12,
                  Expanded(
                    child: Text(
                      'Upload From Gallery',
                      style: AppTextStyle.headingH1('H3'),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget topDashLineForBottomSheet() {
    return Container(
      width: 60,
      height: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: ShapeDecoration(
        color: AppColors.black2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        shadows: const [
          BoxShadow(
            color: AppColors.opacityColor,
            blurRadius: 40.50,
            offset: Offset(-3, 4),
            spreadRadius: 0,
          )
        ],
      ),
    );
  }
}



