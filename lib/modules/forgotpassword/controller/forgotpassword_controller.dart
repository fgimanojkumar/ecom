import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final currentStep = 0.obs; // 0: Email, 1: OTP, 2: Password
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  Future<void> sendResetCode() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      currentStep.value = 1;
      Get.snackbar('Success', 'OTP sent to your email');
    } catch (e) {
      Get.snackbar('Error', 'Failed to send OTP');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOTP() async {
    if (otpController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter OTP');
      return;
    }
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      currentStep.value = 2;
      Get.snackbar('Success', 'OTP verified');
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    if (newPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter new password');
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar('Success', 'Password reset successfully');
      Get.offNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Failed to reset password');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
