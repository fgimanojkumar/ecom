import 'package:flutter/widgets.dart';

/// Matches the hgfedcba admin dashboard's CSS custom properties
/// (src/assets/css/style.css :root) so the seller app mirrors the same UI.
abstract class AppColors {
  // Brand / action colors (--admin-primary / --admin-primary-dark)
  static const Color primary1 = Color(0xFFAC0000);
  static const Color primary2 = primary1;
  static const Color primaryDark = Color(0xFF4C0000);
  static const Color buttonColor = primary1;
  static const Color opacityColor = Color(0x33AC0000);

  // --admin-bg / --admin-surface
  static const Color body = Color(0xFFF5F7FB);
  static const Color surfaceSoft = Color(0xFFF8FAFC);
  static const Color appBarColor = primary1;
  static const Color appDrawerColor = Color(0xFF111827);
  static const Color deepBlueColor = Color(0xFF1E2F45);

  // Brand gradient helpers
  static const Color gradientStart = primary1;
  static const Color gradientEnd = primaryDark;

  // Text / neutral colors (--admin-text / --admin-muted)
  static const Color black = Color(0xFF111111);
  static const Color black1 = Color(0xFF1F2937);
  static const Color black2 = Color(0xFF6B7280);
  static const Color blackHeading = Color(0xFF111827);

  static const Color white = Color(0xFFFFFFFF);
  static const Color white1 = Color(0xFFFEF2F2);
  static const Color white2 = Color(0xFFFECACA);

  // --admin-border
  static const Color greyLight = Color(0xFFA2A2A2);

  static const Color boxShadowColor = Color(0x1AAC0000);
  static const Color muteIconColor = Color(0xFF9CA3AF);

  static const Color yellowStarColor = Color(0xFFF5B301);

  // Status colors
  static const Color statusBtnGreen = primary1;
  static const Color statusBtnYellow = Color(0xFFF5B301);

  // --admin-success / --admin-warning / --admin-danger
  static const Color success = Color(0xFF006B20);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // --admin-sidebar / --admin-sidebar-soft
  static const Color sidebarBg = Color(0xFF111827);
  static const Color sidebarSoft = Color(0xFF1F2937);
  static const Color sidebarText = Color(0xFFD1D5DB);
  static const Color sidebarIconBg = Color(0x14FFFFFF);
}
