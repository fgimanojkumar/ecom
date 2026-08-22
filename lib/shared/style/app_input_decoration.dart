import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'app_style.dart';

abstract class AppInputDecoration {
  static InputDecoration inputDecorationFormWithBorder({
    String labelText = '',
    String hintText = '',
    bool isFreeze = false,
  }) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      fillColor: isFreeze ? AppColors.white1 : AppColors.white,
      contentPadding: AppPadding().inputContentPadding,
      labelText: labelText,
      counterText: '',
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppColors.muteIconColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: const TextStyle(
        color: AppColors.primary1,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.black.withOpacity(0.12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.black.withOpacity(0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isFreeze
              ? AppColors.black.withOpacity(0.12)
              : AppColors.black.withOpacity(0.54),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.black.withOpacity(0.12)),
      ),
    );
  }

  static PinTheme pinFieldDecorationNew() {
    return PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 40,
      fieldWidth: 40,
      activeFillColor: AppColors.greyLight.withOpacity(0.30),
      inactiveFillColor: AppColors.greyLight.withOpacity(0.30),
      selectedFillColor: AppColors.greyLight.withOpacity(0.30),
      activeColor: AppColors.greyLight.withOpacity(0.30),
      inactiveColor: AppColors.greyLight.withOpacity(0.30),
      selectedColor: AppColors.greyLight.withOpacity(0.30),
      errorBorderColor: AppColors.greyLight.withOpacity(0.30),
      borderWidth: 0,
      inactiveBorderWidth: 0,
      activeBorderWidth: 0,
      selectedBorderWidth: 0,
      errorBorderWidth: 0,
    );
  }
}
