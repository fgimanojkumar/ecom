import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../controller/signup_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ResponsiveContent(
          addHorizontalPadding: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// TOP HEADER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary2,
                        AppColors.primary2,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.shopping_bag,
                        color: AppColors.white,
                        size: 70,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start shopping with us today',
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(
                            0.05,
                          ),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        /// NAME
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            prefixIcon: const Icon(
                              Icons.person_outline,
                            ),
                            filled: true,
                            fillColor: AppColors.white1,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// EMAIL
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                            ),
                            filled: true,
                            fillColor: AppColors.white1,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// PHONE
                        TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            prefixIcon: const Icon(
                              Icons.phone_outlined,
                            ),
                            filled: true,
                            fillColor: AppColors.white1,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// PASSWORD
                        Obx(
                          () => TextField(
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: IconButton(
                                onPressed: controller.togglePasswordVisibility,
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.white1,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  14,
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// PASSWORD STRENGTH
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LinearProgressIndicator(
                              value: 0.7,
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Strong Password',
                              style: TextStyle(
                                color: AppColors.success,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        /// CONFIRM PASSWORD
                        Obx(
                          () => TextField(
                            controller: controller.confirmPasswordController,
                            obscureText:
                                !controller.isConfirmPasswordVisible.value,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: IconButton(
                                onPressed:
                                    controller.toggleConfirmPasswordVisibility,
                                icon: Icon(
                                  controller.isConfirmPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.white1,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  14,
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// TERMS
                        Obx(
                          () => CheckboxListTile(
                            value: controller.agreeToTerms.value,
                            activeColor: AppColors.primary2,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'I agree to Terms & Conditions',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            onChanged: (value) {
                              controller.agreeToTerms.value = value ?? false;
                            },
                          ),
                        ),

                        const SizedBox(height: 15),

                        /// SIGNUP BUTTON
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.signUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: AppColors.white,
                                    )
                                  : const Text(
                                      'CREATE ACCOUNT',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.divider,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                'OR',
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

                        /// GOOGLE SIGNUP
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.g_mobiledata,
                              size: 28,
                            ),
                            label: const Text(
                              'Continue with Google',
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppColors.primary2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
