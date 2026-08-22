import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import '../style/app_style.dart';

class AppButton {
  AppButton._();

  static Widget smallActionButton({
    required String title,
    Color? buttonColor,
    void Function()? onPressed,
    bool showIcon = true,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding:
            const EdgeInsets.only(left: 7, right: 7, top: 3.5, bottom: 3.5),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) ...[
              Icon(icon, size: 9, color: AppColors.white),
              gapW4,
            ],
            Text(
              title,
              style: const TextStyle(color: AppColors.white, fontSize: 11.0),
            )
          ],
        ),
      ),
    );
  }

  static Widget outlineButton({
    required String title,
    void Function()? onPressed,
    bool disable = false,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary1),
          color: (disable) ? AppColors.greyLight : AppColors.white,
        ),
        child: Text(
          title,
          style: AppTextStyle.cardTitleTextStyle(),
        ),
      ),
    );
  }

  static Widget solidButton({
    required String title,
    void Function()? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(13),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary1),
          color: AppColors.primary1,
        ),
        child: Text(
          title,
          style: AppTextStyle.cardTitleTextStyle(
            color: AppColors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  static Widget textAndIconButton({
    required Icon icon,
    required String title,
    void Function()? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: AppColors.opacityColor),
        ),
        child: Row(
          children: [
            icon,
            Text(title, style: AppTextStyle.cardTitleTextStyle()),
          ],
        ),
      ),
    );
  }
}



