import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/style/app_colors.dart';

class LoginController extends GetxController {
  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  final identifierController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();
  final otpController = TextEditingController();

  // OTP fields for 4 boxes.
  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isMobileValid = false.obs;
  final loginMode = 'unknown'.obs;
  final selectedLoginPurpose = 'Personal Shopping'.obs;

  final List<String> loginPurposeOptions = const <String>[
    'Personal Shopping',
    'Business Orders',
    'Gift Purchase',
  ];

  final RxList<String> selectedInterests = <String>[].obs;
  final Rxn<DateTime> selectedDemoDate = Rxn<DateTime>();

  final List<String> interestOptions = const <String>[
    'Electronics',
    'Fashion',
    'Home Decor',
    'Beauty',
    'Groceries',
    'Sports',
    'Books',
  ];

  @override
  void onInit() {
    super.onInit();
    otpControllers = List.generate(4, (_) => TextEditingController());
    otpFocusNodes = List.generate(4, (_) => FocusNode());
    identifierController.addListener(_handleIdentifierChanged);
  }

  void _handleIdentifierChanged() {
    final String rawValue = identifierController.text.trim();
    final String digitsOnly = rawValue.replaceAll(RegExp(r'\D'), '');
    final String normalizedMobile = _normalizeMobileDigits(digitsOnly);
    final bool hasEmailPattern = _emailPattern.hasMatch(rawValue);

    final String previousMode = loginMode.value;

    if (hasEmailPattern) {
      loginMode.value = 'email';
      emailController.text = rawValue;
      isMobileValid.value = false;
    } else if (digitsOnly.isNotEmpty && normalizedMobile.isNotEmpty) {
      loginMode.value = 'mobile';
      mobileController.text = normalizedMobile;
      isMobileValid.value = normalizedMobile.length == 10;
    } else {
      loginMode.value = 'unknown';
      emailController.clear();
      mobileController.clear();
      isMobileValid.value = false;
    }

    if (previousMode != loginMode.value) {
      if (loginMode.value != 'mobile') {
        for (final TextEditingController otpFieldController in otpControllers) {
          otpFieldController.clear();
        }
      }
      if (loginMode.value != 'email') {
        passwordController.clear();
      }
    }
  }

  String _normalizeMobileDigits(String digitsOnly) {
    if (digitsOnly.length == 10) {
      return digitsOnly;
    }
    if (digitsOnly.length == 11 && digitsOnly.startsWith('0')) {
      return digitsOnly.substring(1);
    }
    if (digitsOnly.length == 12 && digitsOnly.startsWith('91')) {
      return digitsOnly.substring(2);
    }
    return '';
  }

  @override
  void onClose() {
    identifierController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    otpController.dispose();
    for (final TextEditingController otpFieldController in otpControllers) {
      otpFieldController.dispose();
    }
    for (final FocusNode otpFocusNode in otpFocusNodes) {
      otpFocusNode.dispose();
    }
    super.onClose();
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();

  void handleOtpInput(String value, int index) {
    if (value.length == 1) {
      if (index < 3) {
        otpFocusNodes[index + 1].requestFocus();
      }
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  String getOtp() {
    return otpControllers.map((c) => c.text).join();
  }

  Future<void> submitLogin() async {
    await goToHome();
  }

  Future<void> goToHome() async {
    isLoading.value = true;
    isLoading.value = false;
    Get.offAllNamed('/home');
  }

  Future<void> login() async {
    final String email = identifierController.text.trim();
    final bool isValidEmail = _emailPattern.hasMatch(email);

    if (!isValidEmail || passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a valid email and password.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error.withOpacity(0.12),
      );
      return;
    }

    emailController.text = email;
    isLoading.value = true;
    isLoading.value = false;
    Get.offAllNamed('/home');
  }

  Future<void> loginWithMobile() async {
    final String digitsOnly =
        identifierController.text.trim().replaceAll(RegExp(r'\D'), '');
    final String normalizedMobile = _normalizeMobileDigits(digitsOnly);

    if (normalizedMobile.length != 10 || getOtp().length != 4) {
      Get.snackbar(
        'Error',
        'Please enter a valid mobile number and 4-digit OTP.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error.withOpacity(0.12),
      );
      return;
    }

    mobileController.text = normalizedMobile;
    isLoading.value = true;
    isLoading.value = false;
    Get.offAllNamed('/home');
  }

  void goToSignUp() => Get.toNamed('/signup');
  void goToForgotPassword() => Get.toNamed('/forgotPassword');

  void updateLoginPurpose(String? value) {
    if (value == null || value.isEmpty) {
      return;
    }
    selectedLoginPurpose.value = value;
  }

  void updateSelectedInterests(List<String> values) {
    selectedInterests.assignAll(values);
  }

  void updateSelectedDemoDate(DateTime? date) {
    selectedDemoDate.value = date;
  }
}
