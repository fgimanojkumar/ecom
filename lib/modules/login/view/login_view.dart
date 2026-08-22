import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/common_input_field.dart';
import '../controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  const SizedBox(height: 20),

                  /// LOGO
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.white1,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_rounded,
                      size: 60,
                      color: AppColors.primary2,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Sign in to continue shopping',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.black2,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// LOGIN CARD
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(.08),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
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
                                Text(
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
                                  controller: controller.identifierController,
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'Mobile number or email',
                                  prefixWidget: Icon(
                                    controller.loginMode.value == 'mobile'
                                        ? Icons.phone_in_talk_outlined
                                        : Icons.email_outlined,
                                    color: AppColors.primary2,
                                  ),
                                  suffixWidget:
                                      controller.loginMode.value == 'email' ||
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
                                if (controller.loginMode.value == 'mobile' &&
                                    !controller.isMobileValid.value)
                                  Text(
                                    'Enter a valid 10-digit mobile number to continue.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.black2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                if (controller.loginMode.value == 'mobile' &&
                                    controller.isMobileValid.value)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text(
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
                                        child: TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Resend OTP',
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
                                              controller.isPasswordVisible.value
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
                                      borderRadius: BorderRadius.circular(16),
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
                                              child: CircularProgressIndicator(
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
                          padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.divider,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
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
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.g_mobiledata,
                                      size: 24,
                                      color: AppColors.error,
                                    ),
                                    label: Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        color: AppColors.black2,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
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

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: AppColors.primary1,
                        ),
                      ),
                      TextButton(
                        onPressed: controller.goToSignUp,
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppColors.primary2,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
