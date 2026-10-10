import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/style/app_colors.dart';
import '../../../shared/demo/demo_account_store.dart';

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
  Timer? _otpResendTimer;

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isMobileValid = false.obs;
  final resendOtpCountdown = 0.obs;
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
    identifierController.text = DemoAccountStore.demoMobile;
    const demoOtp = DemoAccountStore.demoOtp;
    for (var index = 0; index < otpControllers.length; index++) {
      if (index < demoOtp.length) {
        otpControllers[index].text = demoOtp[index];
      }
    }
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    try {
      final user = await DemoAccountStore.restoreSession();
      if (user != null) Get.offAllNamed('/home');
    } catch (_) {}
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
        _otpResendTimer?.cancel();
        resendOtpCountdown.value = 0;
        for (final TextEditingController otpFieldController in otpControllers) {
          otpFieldController.clear();
        }
      } else if (isMobileValid.value) {
        _startOtpResendCountdown();
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
    _otpResendTimer?.cancel();
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

  void resendOtp() {
    if (resendOtpCountdown.value > 0 || loginMode.value != 'mobile') return;

    const demoOtp = DemoAccountStore.demoOtp;
    for (var index = 0; index < otpControllers.length; index++) {
      otpControllers[index].text = index < demoOtp.length ? demoOtp[index] : '';
    }
    _startOtpResendCountdown();
    Get.snackbar(
      'OTP sent',
      'Demo OTP: $demoOtp',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _startOtpResendCountdown() {
    _otpResendTimer?.cancel();
    resendOtpCountdown.value = 30;
    _otpResendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendOtpCountdown.value <= 1) {
        resendOtpCountdown.value = 0;
        timer.cancel();
        _otpResendTimer = null;
      } else {
        resendOtpCountdown.value--;
      }
    });
  }

  Future<void> submitLogin() async {
    if (isLoading.value) return;

    isLoading.value = true;
    var isAuthenticated = false;
    var errorMessage = 'Use the demo credentials shown on this screen.';

    try {
      if (loginMode.value == 'email') {
        isAuthenticated = await DemoAccountStore.signInWithPassword(
          identifier: identifierController.text,
          password: passwordController.text,
        );
      } else if (loginMode.value == 'mobile' && isMobileValid.value) {
        isAuthenticated = await DemoAccountStore.signInWithOtp(
          mobile: mobileController.text,
          otp: getOtp(),
        );
      } else if (loginMode.value == 'mobile') {
        errorMessage = 'Enter the demo 10-digit mobile number.';
      } else {
        errorMessage = 'Enter the demo email or mobile number to continue.';
      }
    } catch (_) {
      errorMessage = 'Could not start the demo session. Please try again.';
    } finally {
      isLoading.value = false;
    }

    if (!isAuthenticated) {
      Get.snackbar(
        'Unable to sign in',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error.withOpacity(0.12),
      );
      return;
    }

    Get.offAllNamed('/home');
  }

  Future<void> goToHome() async {
    isLoading.value = true;
    isLoading.value = false;
    Get.offAllNamed('/home');
  }

  Future<void> login() async {
    await submitLogin();
  }

  Future<void> loginWithMobile() async {
    await submitLogin();
  }

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
