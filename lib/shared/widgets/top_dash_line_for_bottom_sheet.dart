import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';

import '../style/app_style.dart';

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
      shadows: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.19),
          blurRadius: 40.50,
          offset: Offset(-3, 4),
          spreadRadius: 0,
        )
      ],
    ),
  );
}
