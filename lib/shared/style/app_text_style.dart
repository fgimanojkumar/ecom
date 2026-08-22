import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._internal();

  static final AppTextStyle _instance = AppTextStyle._internal();

  factory AppTextStyle() {
    return _instance;
  }

  static TextStyle headingH1(heading, {bool mutedText = false}) {
    double headingFontSize = 12.0;
    switch (heading) {
      case 'H1':
        headingFontSize = 18.0;
        break;
      case 'H2':
        headingFontSize = 16.0;
        break;
      case 'H3':
        headingFontSize = 14.0;
        break;
      case 'H4':
        headingFontSize = 12.0;
        break;
      case 'H5':
        headingFontSize = 10.0;
        break;
    }
    return TextStyle(
      fontSize: headingFontSize,
      fontWeight: FontWeight.w600,
      color: (mutedText) ? AppColors.black2 : AppColors.blackHeading,
    );
  }

  static TextStyle mutedTextLabel({
    double? headingFontSize,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontSize: headingFontSize ?? 9,
      fontWeight: fontWeight,
      color: AppColors.black2,
    );
  }

  static TextStyle radioButtonTextLabel() {
    return const TextStyle(
      color: AppColors.primary1,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle tableCellTextStyle({double? headingFontSize}) {
    return TextStyle(
      fontSize: headingFontSize ?? 10,
      fontWeight: FontWeight.w500,
      color: AppColors.black2,
    );
  }

  static TextStyle drawerMenuStyle() {
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white1);
  }

  static TextStyle bottomSheetMenuStyle() {
    return const TextStyle(
      color: AppColors.blackHeading,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle claimDashboardMenuStyle() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.black1,
    );
  }

  static TextStyle rowTitleValueTextStyle({
    double? fontSize,
    Color color = AppColors.black,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 11.5,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle cardTitleTextStyle({
    Color color = AppColors.primary1,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle rowTitleValueTextStyleSummaryTable({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      color: color,
      fontSize: 10,
      fontWeight: fontWeight,
    );
  }

  static TextStyle textStyleForNote() {
    return const TextStyle(
      color: AppColors.primary1,
      fontSize: 10,
    );
  }

  final formInputStyle = const TextStyle(
    color: AppColors.blackHeading,
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );

  static TextStyle cardTitleStyle() {
    return const TextStyle(
      color: AppColors.primary1,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle bottomSheetTitleStyle() {
    return const TextStyle(
      color: AppColors.primary1,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle surveyPhotoTitleStyle() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.deepBlueColor,
    );
  }

  static TextStyle btnTextStyleWhite({
    double? fontSize,
    Color color = AppColors.white,
  }) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 12,
    );
  }

  static elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.primary2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }

  static TextStyle claimCardMutedLabel(context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return TextStyle(
      color: AppColors.black2,
      fontSize: screenWidth > 600 ? 11 : 10,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle claimCardValue(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      color: AppColors.black2,
      fontSize: screenWidth > 600 ? 12 : 11,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle fs12Black600() {
    return const TextStyle(
      color: AppColors.black1,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textFieldTextStyle({isFreeze = false}) {
    return TextStyle(
      color: isFreeze ? AppColors.black.withOpacity(0.87) : AppColors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle dropdownTextStyle({isFreeze = false}) {
    return TextStyle(
      color: isFreeze ? AppColors.black.withOpacity(0.87) : AppColors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }
}
