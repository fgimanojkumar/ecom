import 'package:flutter/material.dart';

import '../widgets/common_input_field.dart';
import '../style/app_colors.dart';
import 'responsive_extension.dart';

/// Modern Minimalist Card Component
class ModernCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? elevation;
  final BoxBorder? border;

  const ModernCard({
    Key? key,
    required this.child,
    this.onTap,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.elevation = 1,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultRadius = borderRadius ?? context.responsiveRadius;
    final defaultPadding = padding ?? EdgeInsets.all(context.responsivePadding);
    final defaultBgColor = backgroundColor ?? AppColors.white;

    final card = Container(
      padding: defaultPadding,
      decoration: BoxDecoration(
        color: defaultBgColor,
        borderRadius: BorderRadius.circular(defaultRadius),
        border: border ??
            Border.all(
              color: AppColors.white2,
              width: 1,
            ),
        boxShadow: elevation != null && elevation! > 0
            ? [
                BoxShadow(
                  color: AppColors.boxShadowColor,
                  blurRadius: elevation! * 2,
                  offset: Offset(0, elevation! * 1.5),
                ),
              ]
            : [],
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card,
      );
    }
    return card;
  }
}

/// Modern Gradient Button
class ModernButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final double? customHeight;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ButtonSize size;

  const ModernButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customHeight,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.size = ButtonSize.medium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = customHeight ?? _getHeight(context);
    final padding = _getPadding(context);

    return SizedBox(
      height: height,
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary1,
          foregroundColor: foregroundColor ?? AppColors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.responsiveRadius),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? SizedBox(
                height: height * 0.5,
                width: height * 0.5,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    foregroundColor ?? AppColors.white,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: context.responsiveIconSize),
                    SizedBox(width: context.responsivePadding * 0.5),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _getFontSize(context),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  double _getHeight(BuildContext context) {
    switch (size) {
      case ButtonSize.small:
        return context.isMobile ? 36 : 40;
      case ButtonSize.medium:
        return context.isMobile ? 44 : 48;
      case ButtonSize.large:
        return context.isMobile ? 52 : 56;
    }
  }

  EdgeInsets _getPadding(BuildContext context) {
    switch (size) {
      case ButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: context.responsivePadding,
          vertical: context.responsivePadding * 0.5,
        );
      case ButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: context.responsivePadding * 1.5,
          vertical: context.responsivePadding,
        );
      case ButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: context.responsivePadding * 2,
          vertical: context.responsivePadding * 1.5,
        );
    }
  }

  double _getFontSize(BuildContext context) {
    if (context.isMobile) return 14;
    if (context.isTablet) return 15;
    return 16;
  }
}

enum ButtonSize { small, medium, large }

/// Modern Outlined Button
class ModernOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? borderColor;
  final Color? textColor;
  final bool isFullWidth;
  final IconData? icon;

  const ModernOutlinedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.borderColor,
    this.textColor,
    this.isFullWidth = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: context.isMobile ? 44 : 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: borderColor ?? AppColors.primary1,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.responsiveRadius),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: context.responsiveIconSize, color: textColor),
              SizedBox(width: context.responsivePadding * 0.5),
            ],
            Text(
              label,
              style: TextStyle(
                color: textColor ?? AppColors.primary1,
                fontWeight: FontWeight.w600,
                fontSize: context.isMobile ? 14 : 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modern Input Field
class ModernInput extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final int maxLines;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const ModernInput({
    Key? key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: context.isMobile ? 14 : 15,
            color: AppColors.black1,
          ),
        ),
        SizedBox(height: context.responsivePadding * 0.5),
        CommonInputField.formField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword,
          maxLines: isPassword ? 1 : maxLines,
          validator: validator,
          onChanged: onChanged,
          prefixWidget: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixWidget: suffixIcon != null
              ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(suffixIcon),
                )
              : null,
          radius: context.responsiveRadius,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.responsivePadding,
            vertical: context.responsivePadding,
          ),
          decorationOverride: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.black2.withOpacity(0.5)),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onSuffixTap,
                    child: Icon(suffixIcon),
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.responsivePadding,
              vertical: context.responsivePadding,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.responsiveRadius),
              borderSide: BorderSide(color: AppColors.white2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.responsiveRadius),
              borderSide: BorderSide(color: AppColors.white2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.responsiveRadius),
              borderSide: BorderSide(color: AppColors.primary1, width: 2),
            ),
            filled: true,
            fillColor: AppColors.white1,
          ),
        ),
      ],
    );
  }
}

/// Modern Info Card
class ModernInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? backgroundColor;
  final Color? iconColor;

  const ModernInfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      backgroundColor: backgroundColor ?? AppColors.white1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: context.responsiveIconSize * 1.5,
            color: iconColor ?? AppColors.primary1,
          ),
          SizedBox(height: context.responsivePadding),
          Text(
            title,
            style: TextStyle(
              fontSize: context.isMobile ? 14 : 16,
              fontWeight: FontWeight.w700,
              color: AppColors.black1,
            ),
          ),
          SizedBox(height: context.responsivePadding * 0.5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: context.isMobile ? 12 : 13,
              color: AppColors.black2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Modern Badge/Chip
class ModernBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onClose;
  final double? fontSize;

  const ModernBadge({
    Key? key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.onClose,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding,
        vertical: context.responsivePadding * 0.5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary1.withOpacity(0.1),
        borderRadius: BorderRadius.circular(context.responsiveRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor ?? AppColors.primary1,
              fontWeight: FontWeight.w600,
              fontSize: fontSize ?? (context.isMobile ? 12 : 13),
            ),
          ),
          if (onClose != null) ...[
            SizedBox(width: 4),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                size: 16,
                color: textColor ?? AppColors.primary1,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
