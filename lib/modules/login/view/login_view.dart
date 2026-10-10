import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/demo/demo_account_store.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/common_input_field.dart';
import '../controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final content = Container(
            color: AppColors.white,
            child: SafeArea(
              child: ResponsiveContent(
                addHorizontalPadding: true,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      if (MediaQuery.sizeOf(context).width < 960) ...[
                        _buildMobileIntro(context),
                        const SizedBox(height: 28),
                      ],

                      /// LOGIN CARD
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.white2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(.06),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(22),
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'DEMO ACCOUNT',
                                      style: TextStyle(
                                        color: AppColors.primary1,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    SelectableText(
                                      'Email: ${DemoAccountStore.demoUser['email']}',
                                      style: const TextStyle(
                                        color: AppColors.black1,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SelectableText(
                                      'Password: ${DemoAccountStore.demoUser['password']}',
                                      style: const TextStyle(
                                        color: AppColors.black1,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SelectableText(
                                      'Mobile: ${DemoAccountStore.demoUser['phone']}  |  OTP: ${DemoAccountStore.demoOtp}',
                                      style: const TextStyle(
                                        color: AppColors.black1,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    const Text(
                                      'Enter mobile number or email',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.black2,
                                      ),
                                    ),
                                    // const SizedBox(height: 14),
                                    // Container(
                                    //   padding: const EdgeInsets.all(1.2),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(18),
                                    //     gradient: const LinearGradient(
                                    //       begin: Alignment.topLeft,
                                    //       end: Alignment.bottomRight,
                                    //       colors: [
                                    //         Color(0x33C45A2A),
                                    //         Color(0x145C6AC4),
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: AppColors.white,
                                    //       borderRadius: BorderRadius.circular(17),
                                    //     ),
                                    //     padding: const EdgeInsets.fromLTRB(
                                    //       12,
                                    //       10,
                                    //       12,
                                    //       10,
                                    //     ),
                                    //     child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [],
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(height: 16),
                                    CommonInputField.field(
                                      controller:
                                          controller.identifierController,
                                      keyboardType: TextInputType.emailAddress,
                                      hintText: 'Mobile number or email',
                                      prefixWidget: Icon(
                                        controller.loginMode.value == 'mobile'
                                            ? Icons.phone_in_talk_outlined
                                            : Icons.email_outlined,
                                        color: AppColors.primary2,
                                      ),
                                      suffixWidget:
                                          controller.loginMode.value ==
                                                      'email' ||
                                                  controller.isMobileValid.value
                                              ? const Icon(
                                                  Icons.check_circle,
                                                  color: AppColors.success,
                                                )
                                              : null,
                                      fillColor: AppColors.white1,
                                      radius: 16,
                                    ),
                                    const SizedBox(height: 14),
                                    if (controller.loginMode.value ==
                                            'mobile' &&
                                        !controller.isMobileValid.value)
                                      const Text(
                                        'Enter a valid 10-digit mobile number to continue.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.black2,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    if (controller.loginMode.value ==
                                            'mobile' &&
                                        controller.isMobileValid.value)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4),
                                          const Text(
                                            'Enter OTP',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.black2,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                              4,
                                              (index) => SizedBox(
                                                width: 60,
                                                height: 60,
                                                child: CommonInputField.field(
                                                  controller: controller
                                                      .otpControllers[index],
                                                  focusNode: controller
                                                      .otpFocusNodes[index],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  maxLength: 1,
                                                  textAlign: TextAlign.center,
                                                  onChanged: (value) {
                                                    controller.handleOtpInput(
                                                      value,
                                                      index,
                                                    );
                                                  },
                                                  fillColor: AppColors.white1,
                                                  radius: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Obx(() {
                                              final seconds = controller
                                                  .resendOtpCountdown.value;
                                              final label = seconds > 0
                                                  ? 'Resend OTP in 00:${seconds.toString().padLeft(2, '0')}'
                                                  : 'Resend OTP';
                                              return TextButton(
                                                onPressed: seconds == 0
                                                    ? controller.resendOtp
                                                    : null,
                                                child: Text(
                                                  label,
                                                  style: TextStyle(
                                                    color: seconds == 0
                                                        ? AppColors.primary2
                                                        : AppColors.black2,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    if (controller.loginMode.value == 'email')
                                      Column(
                                        children: [
                                          const SizedBox(height: 4),
                                          Obx(
                                            () => CommonInputField.field(
                                              controller:
                                                  controller.passwordController,
                                              obscureText: !controller
                                                  .isPasswordVisible.value,
                                              hintText: 'Password',
                                              prefixWidget: const Icon(
                                                Icons.lock_outline,
                                                color: AppColors.primary2,
                                              ),
                                              suffixWidget: IconButton(
                                                onPressed: controller
                                                    .togglePasswordVisibility,
                                                icon: Icon(
                                                  controller.isPasswordVisible
                                                          .value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: AppColors.primary2,
                                                ),
                                              ),
                                              fillColor: AppColors.white1,
                                              radius: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              onPressed:
                                                  controller.goToForgotPassword,
                                              child: const Text(
                                                'Forgot Password?',
                                                style: TextStyle(
                                                  color: AppColors.primary2,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 55,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColors.primary1,
                                              AppColors.primary1,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary2
                                                  .withOpacity(0.3),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          onPressed: controller.isLoading.value
                                              ? null
                                              : controller.submitLogin,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: controller.isLoading.value
                                              ? const SizedBox(
                                                  width: 22,
                                                  height: 22,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: AppColors.white,
                                                  ),
                                                )
                                              : Text(
                                                  controller.loginMode.value ==
                                                          'mobile'
                                                      ? 'VERIFY & SIGN IN'
                                                      : 'SIGN IN',
                                                  style: const TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// DIVIDER AND GOOGLE LOGIN
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(22, 24, 22, 22),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: AppColors.divider,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          'OR',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.muteIconColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: AppColors.divider,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  /// GOOGLE BUTTON
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.divider,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: OutlinedButton.icon(
                                        onPressed: () => Get.snackbar(
                                          'Demo sign-in',
                                          'Use the demo credentials shown above.',
                                          snackPosition: SnackPosition.BOTTOM,
                                        ),
                                        icon: const Icon(
                                          Icons.g_mobiledata,
                                          size: 24,
                                          color: AppColors.error,
                                        ),
                                        label: const Text(
                                          'Continue with Google',
                                          style: TextStyle(
                                            color: AppColors.black2,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          if (constraints.maxWidth < 960) return content;

          return Row(
            children: [
              Expanded(flex: 11, child: _buildWebPromo()),
              Expanded(flex: 9, child: content),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWebPromo() {
    return Container(
      color: const Color(0xFFEDF4EF),
      padding: const EdgeInsets.fromLTRB(56, 36, 44, 28),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primary1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: AppColors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 11),
                const Text(
                  'Bhabsa',
                  style: TextStyle(
                    color: AppColors.primary1,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),
            const Text(
              'Welcome back.',
              style: TextStyle(
                color: AppColors.blackHeading,
                fontSize: 42,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Good things are waiting for you.',
              style: TextStyle(
                color: AppColors.black2,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const Expanded(
              child: Center(
                child: Image(
                  image: AssetImage('resources/images/login_img.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Text(
              'BHABSA  /  YOUR EVERYDAY EDIT',
              style: TextStyle(
                color: AppColors.black2,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileIntro(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 380;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.shopping_bag_rounded,
                color: AppColors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Bhabsa',
              style: TextStyle(
                color: AppColors.primary1,
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      color: AppColors.blackHeading,
                      fontSize: isCompact ? 27 : 30,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sign in to continue shopping.',
                    style: TextStyle(
                      color: AppColors.black2,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: isCompact ? 88 : 112,
              height: isCompact ? 94 : 116,
              child: const Image(
                image: AssetImage('resources/images/login_img.png'),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
