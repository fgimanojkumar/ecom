import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;
  final agreeToTerms = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.toggle();
  }

  bool validateForm() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your name');
      return false;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return false;
    }
    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your phone number');
      return false;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your password');
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return false;
    }
    if (!agreeToTerms.value) {
      Get.snackbar('Error', 'Please agree to terms and conditions');
      return false;
    }
    return true;
  }

  Future<void> signUp() async {
    if (!validateForm()) return;

    isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar('Success', 'Account created successfully');
      Get.offNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create account');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
