import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppBoxShadow {
  static BoxDecoration containerBoxDecoration({
    double radius = 15,
    Color color = AppColors.white,
    double blurRadius = 3.0,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
      boxShadow: [
        BoxShadow(
          color: AppColors.boxShadowColor,
          blurRadius: blurRadius,
          spreadRadius: 3.0,
        )
      ],
    );
  }

  static BoxDecoration containerNoBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: AppColors.white,
    );
  }

  static BoxDecoration lightGreyCard() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: AppColors.greyLight,
    );
  }
}
