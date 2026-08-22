import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../style/app_style.dart';

class AppLoader {
  AppLoader._();

  static void popUpLoader(context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: AppColors.black.withValues(alpha: 0.18),
      context: context,
      builder: (_) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: LoadingAnimationWidget.inkDrop(
              size: 40,
              color: AppColors.primary1,
            ),
          ),
        );
      },
    );
  }

  static Widget onScreenLoader() {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        size: 40,
        color: AppColors.primary1,
      ),
    );
  }

  static Widget onScreenLoaderWithScaffold() {
    return Scaffold(
      backgroundColor: AppColors.body,
      body: Center(
        child: LoadingAnimationWidget.inkDrop(
          size: 40,
          color: AppColors.primary1,
        ),
      ),
    );
  }
}
