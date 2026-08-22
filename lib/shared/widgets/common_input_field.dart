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
    TextInputType? keyboardType,
    bool readOnly = false,
    bool obscureText = false,
    Widget? prefixWidget,
    Widget? suffixWidget,
    List<TextInputFormatter>? inputFormatters,
    TextAlign textAlign = TextAlign.start,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    FocusNode? focusNode,
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
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      onChanged: onChanged,
      onTap: onTap,
      style: AppTextStyle.textFieldTextStyle(),
      decoration: decoration(
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
  }) {
    return InputDecoration(
      counterText: '',
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
