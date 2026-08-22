import 'package:flutter/widgets.dart';

abstract class AppColors {
  static const Color body = Color(0xFFF4FBF7);
  static const Color appBarColor = Color(0xFF0F6B43);
  static const Color appDrawerColor = Color(0xFF0A5234);
  static const Color deepBlueColor = Color(0xFF1E2F45);

  // Brand / action colors
  static const Color primary1 = Color(0xFF0F6B43);
  static const Color primary2 = primary1;
  static const Color buttonColor = Color(0xFF0F6B43);
  static const Color opacityColor = Color(0x330F6B43);

  // Gradient helpers (use as list in LinearGradient)
  static const Color gradientStart = Color(0xFF0F6B43);
  static const Color gradientEnd = Color(0xFF37C87A);

  // Text / neutral colors
  static const Color black = Color(0xFF111111);
  static const Color black1 = Color(0xFF1F2937);
  static const Color black2 = Color(0xFF6B7280);
  static const Color blackHeading = Color(0xFF111827);

  static const Color white = Color(0xFFFFFFFF);
  static const Color white1 = Color(0xFFF9FAFB);
  static const Color white2 = Color(0xFFE5E7EB);

  static const Color greyLight = Color(0xFFD1D5DB);

  static const Color boxShadowColor = Color(0x1A0F6B43);
  static const Color muteIconColor = Color(0xFF9CA3AF);

  static const Color yellowStarColor = Color(0xFFF5B301);

  // Status colors
  static const Color statusBtnGreen = Color(0xFF0F6B43);
  static const Color statusBtnYellow = Color(0xFFF5B301);

  // Additional semantic theme colors
  static const Color success = Color(0xFF0F6B43);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFB42318);
  static const Color info = Color(0xFF2563EB);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color cardBackground = Color(0xFFFFFFFF);
}
