import 'package:flutter/material.dart';
import '../style/app_colors.dart';
import 'responsive_extension.dart';

/// Responsive typography styles that scale with device
class ResponsiveTextStyle {
  static TextStyle headline1(BuildContext context) {
    final screenSize = context.screenSize;
    double fontSize = 28;
    if (screenSize.isTablet) fontSize = 32;
    if (screenSize.isDesktop) fontSize = 36;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      color: AppColors.black1,
      height: 1.2,
    );
  }

  static TextStyle headline2(BuildContext context) {
    final screenSize = context.screenSize;
    double fontSize = 20;
    if (screenSize.isTablet) fontSize = 24;
    if (screenSize.isDesktop) fontSize = 28;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.black1,
      height: 1.3,
    );
  }

  static TextStyle headline3(BuildContext context) {
    final screenSize = context.screenSize;
    double fontSize = 18;
    if (screenSize.isTablet) fontSize = 20;
    if (screenSize.isDesktop) fontSize = 24;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.black1,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    final screenSize = context.screenSize;
    double fontSize = 16;
    if (screenSize.isTablet) fontSize = 17;
    if (screenSize.isDesktop) fontSize = 18;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.black1,
      height: 1.5,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    final screenSize = context.screenSize;
    double fontSize = 14;
    if (screenSize.isTablet) fontSize = 15;
    if (screenSize.isDesktop) fontSize = 16;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.black1,
      height: 1.5,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    final screenSize = context.screenSize;
    double fontSize = 12;
    if (screenSize.isTablet) fontSize = 13;
    if (screenSize.isDesktop) fontSize = 14;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.black2,
      height: 1.4,
    );
  }

  static TextStyle caption(BuildContext context) {
    final screenSize = context.screenSize;
    double fontSize = 10;
    if (screenSize.isTablet) fontSize = 11;
    if (screenSize.isDesktop) fontSize = 12;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.black2,
    );
  }

  static TextStyle label(BuildContext context) {
    final screenSize = context.screenSize;
    double fontSize = 12;
    if (screenSize.isTablet) fontSize = 13;
    if (screenSize.isDesktop) fontSize = 14;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.black1,
      letterSpacing: 0.5,
    );
  }
}

/// Responsive text widget that auto-scales with device
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool isHeading;
  final double? customFontSize;

  const ResponsiveText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.isHeading = false,
    this.customFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle finalStyle = style ??
        (isHeading
            ? ResponsiveTextStyle.headline2(context)
            : ResponsiveTextStyle.bodyMedium(context));

    if (customFontSize != null) {
      finalStyle = finalStyle.copyWith(fontSize: customFontSize);
    }

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive heading widget
class ResponsiveHeading extends StatelessWidget {
  final String text;
  final int level; // 1-3 (H1, H2, H3)
  final TextAlign textAlign;
  final Color? color;

  const ResponsiveHeading(
    this.text, {
    Key? key,
    this.level = 2,
    this.textAlign = TextAlign.left,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style;
    switch (level) {
      case 1:
        style = ResponsiveTextStyle.headline1(context);
        break;
      case 3:
        style = ResponsiveTextStyle.headline3(context);
        break;
      default:
        style = ResponsiveTextStyle.headline2(context);
    }

    if (color != null) {
      style = style.copyWith(color: color);
    }

    return Text(
      text,
      style: style,
      textAlign: textAlign,
    );
  }
}
