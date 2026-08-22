import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/app_toast.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isOldVisible = false.obs;
  final isNewVisible = false.obs;
  final isConfirmVisible = false.obs;
  final isSaving = false.obs;

  void toggleOldVisibility() => isOldVisible.toggle();
  void toggleNewVisibility() => isNewVisible.toggle();
  void toggleConfirmVisibility() => isConfirmVisible.toggle();

  bool get _hasStrongPassword {
    final pass = newPasswordController.text.trim();
    final hasLength = pass.length >= 8;
    final hasUpper = RegExp(r'[A-Z]').hasMatch(pass);
    final hasDigit = RegExp(r'\d').hasMatch(pass);
    return hasLength && hasUpper && hasDigit;
  }

  Future<void> updatePassword() async {
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      AppToast.errorToast('Please fill all password fields');
      return;
    }

    if (!_hasStrongPassword) {
      AppToast.errorToast('Use 8+ chars with 1 uppercase and 1 number');
      return;
    }

    if (newPass != confirmPass) {
      AppToast.errorToast('New password and confirm password must match');
      return;
    }

    isSaving.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    isSaving.value = false;

    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();

    AppToast.successToast('Password changed successfully');
    Get.back();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
