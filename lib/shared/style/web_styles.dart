
import 'package:flutter/material.dart';

import 'app_colors.dart';

class WebStyle {
  WebStyle._internal();

  static const double inputLabelSize = 15;
  static const double inputFontSize = 13;
  static const double sideMenuIconSize = 18;
  static const double headings = 14;
  static const double cardTitle = 15;
  static const double buttonFont = 14;
  static const FontWeight fontweight = FontWeight.bold;
  static const roboto = 'Roboto';
  static const double letterSpacingSmall = 0.5;
  static const double letterSpacingMedium = 1.0;
  static const double letterSpacingLarge = 1.5;

  static TextStyle buttonTextStyle = const TextStyle(
    fontSize: buttonFont,
    color: AppColors.primary1,
    fontWeight: fontweight,
    fontFamily: roboto,
  );

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

  static ButtonStyle buttonStyles = ButtonStyle(
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(color: AppColors.primary1),
      ),
    ),
    side: WidgetStateProperty.all(
      const BorderSide(
          color: AppColors.primary1, width: 1.0, style: BorderStyle.solid),
    ),
  );

  static ButtonStyle buttonStylesSquare = ButtonStyle(
    side: WidgetStateProperty.all(
      const BorderSide(
        color: AppColors.primary1,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
  );

  static TextStyle cardTitleStyle() {
    return const TextStyle(
      color: AppColors.primary1,
      fontSize: cardTitle,
      fontWeight: FontWeight.w600,
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

  static TextStyle tableCellTextStyle({double? headingFontSize}) {
    return TextStyle(
      fontSize: headingFontSize ?? 11,
      fontWeight: FontWeight.w500,
      color: AppColors.black2,
    );
  }

  static TextStyle headingsTextStyle = const TextStyle(
    fontWeight: fontweight,
    color: AppColors.primary2,
    fontSize: headings,
    fontFamily: roboto,
  );

  static InputDecoration inputdecorations = InputDecoration(
    contentPadding: const EdgeInsets.all(10.0),
    border: textFeildBorder,
    focusedBorder: focusedtextFeildBorder,
  );

  static OutlineInputBorder textFeildBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.black2),
  );

  static OutlineInputBorder focusedtextFeildBorder = const OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: AppColors.primary1),
  );

  static TextStyle inputLabelTextStyle = const TextStyle(
    fontSize: inputLabelSize,
    color: AppColors.black,
    fontFamily: roboto,
  );

  static TextStyle inputboxTextStyle = const TextStyle(
    fontSize: inputFontSize,
    color: AppColors.black1,
    fontWeight: fontweight,
  );

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
}
