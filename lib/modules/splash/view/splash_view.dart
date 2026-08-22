import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/style/app_text_style.dart';
import '../../../shared/utils/responsive_util.dart';
import '../controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Center(
          child: ResponsiveContent(
            addHorizontalPadding: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/App Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    size: 80,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 30),
                // App Name
                Text(
                  'ShopHub',
                  style: AppTextStyle.headingH1('H1').copyWith(
                    color: AppColors.white,
                    fontSize: 48,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your Favorite E-Commerce Store',
                  style: AppTextStyle.cardTitleStyle().copyWith(
                    color: AppColors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 60),
                // Loading Indicator
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.white.withOpacity(0.7),
                    ),
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Loading...',
                  style: AppTextStyle.cardTitleStyle().copyWith(
                    color: AppColors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
