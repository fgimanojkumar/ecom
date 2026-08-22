import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/style/app_colors.dart';

class OnboardingController extends GetxController {
  final currentPage = 0.obs;
  final pageController = PageController();

  final List<OnboardingData> pages = [
    OnboardingData(
      title: 'Welcome to ShopHub',
      description: 'Discover the best products at unbeatable prices',
      icon: Icons.shopping_bag_rounded,
      color: AppColors.info,
    ),
    OnboardingData(
      title: 'Fast Delivery',
      description: 'Get your products delivered right to your doorstep',
      icon: Icons.local_shipping,
      color: AppColors.success,
    ),
    OnboardingData(
      title: 'Secure Payment',
      description: 'Shop with confidence with secure payment options',
      icon: Icons.security,
      color: AppColors.warning,
    ),
    OnboardingData(
      title: '24/7 Support',
      description: 'Get help anytime with our customer support team',
      icon: Icons.headset_mic,
      color: AppColors.primary1,
    ),
  ];

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offNamed('/login');
    }
  }

  void skipOnboarding() {
    Get.offNamed('/login');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
