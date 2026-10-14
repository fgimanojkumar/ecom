import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../style/app_colors.dart';
import '../style/app_style.dart';

class CommonInputField {
  static TextField field({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    int? maxLength,
    int? minLines,
    int? maxLines = 1,
    TextInputType? keyboardType,
    bool readOnly = false,
    bool obscureText = false,
    bool enabled = true,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    Widget? prefixWidget,
    Widget? suffixWidget,
    List<TextInputFormatter>? inputFormatters,
    TextAlign textAlign = TextAlign.start,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    GestureTapCallback? onTap,
    FocusNode? focusNode,
    TextStyle? textStyle,
    InputDecoration? decorationOverride,
    bool showCounter = false,
    Color fillColor = AppColors.white1,
    double radius = 14,
    EdgeInsetsGeometry? contentPadding,
    BoxConstraints? prefixIconConstraints,
    BoxConstraints? suffixIconConstraints,
    bool showFocusedBorder = true,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      style: textStyle ?? AppTextStyle.textFieldTextStyle(),
      decoration: decorationOverride ??
          decoration(
            hintText: hintText,
            labelText: labelText,
            prefixWidget: prefixWidget,
            suffixWidget: suffixWidget,
            fillColor: fillColor,
            radius: radius,
            contentPadding: contentPadding,
            prefixIconConstraints: prefixIconConstraints,
            suffixIconConstraints: suffixIconConstraints,
            showFocusedBorder: showFocusedBorder,
            showCounter: showCounter,
          ),
    );
  }

  static TextFormField formField({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    int? maxLength,
    int? minLines,
    int? maxLines = 1,
    TextInputType? keyboardType,
    bool readOnly = false,
    bool obscureText = false,
    bool enabled = true,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    Widget? prefixWidget,
    Widget? suffixWidget,
    List<TextInputFormatter>? inputFormatters,
    TextAlign textAlign = TextAlign.start,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    GestureTapCallback? onTap,
    FocusNode? focusNode,
    TextStyle? textStyle,
    String? Function(String?)? validator,
    InputDecoration? decorationOverride,
    bool showCounter = false,
    Color fillColor = AppColors.white1,
    double radius = 14,
    EdgeInsetsGeometry? contentPadding,
    BoxConstraints? prefixIconConstraints,
    BoxConstraints? suffixIconConstraints,
    bool showFocusedBorder = true,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      validator: validator,
      style: textStyle ?? AppTextStyle.textFieldTextStyle(),
      decoration: decorationOverride ??
          decoration(
            hintText: hintText,
            labelText: labelText,
            prefixWidget: prefixWidget,
            suffixWidget: suffixWidget,
            fillColor: fillColor,
            radius: radius,
            contentPadding: contentPadding,
            prefixIconConstraints: prefixIconConstraints,
            suffixIconConstraints: suffixIconConstraints,
            showFocusedBorder: showFocusedBorder,
            showCounter: showCounter,
          ),
    );
  }

  static InputDecoration decoration({
    String? hintText,
    String? labelText,
    Widget? prefixWidget,
    Widget? suffixWidget,
    Color fillColor = AppColors.white1,
    double radius = 14,
    EdgeInsetsGeometry? contentPadding,
    BoxConstraints? prefixIconConstraints,
    BoxConstraints? suffixIconConstraints,
    bool showFocusedBorder = true,
    bool showCounter = false,
  }) {
    return InputDecoration(
      counterText: showCounter ? null : '',
      hintText: hintText,
      labelText: labelText,
      hintStyle: const TextStyle(
        color: AppColors.muteIconColor,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: const TextStyle(
        color: AppColors.black2,
        fontWeight: FontWeight.w600,
      ),
      prefixIcon: prefixWidget,
      suffixIcon: suffixWidget,
      prefixIconConstraints: prefixIconConstraints,
      suffixIconConstraints: suffixIconConstraints,
      filled: true,
      fillColor: fillColor,
      contentPadding: contentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      focusedBorder: showFocusedBorder
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(
                color: AppColors.primary2,
                width: 1.6,
              ),
            )
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
    );
  }
}

class AppInputTextField {
  static TextField appTextFormField({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    int? maxLength,
    TextInputType? keyBoardType,
    bool? readOnly,
    Widget? prefixWidget,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return CommonInputField.field(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      maxLength: maxLength,
      keyboardType: keyBoardType,
      readOnly: readOnly ?? false,
      prefixWidget: prefixWidget,
      inputFormatters: inputFormatters,
    );
  }

  static InputDecoration appInputDecoration({
    String? hintText,
    Widget? prefixWidget,
  }) {
    return CommonInputField.decoration(
      hintText: hintText,
      prefixWidget: prefixWidget,
    );
  }
}
