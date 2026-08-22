import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/common_input_field.dart';
import '../controller/forgotpassword_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: SafeArea(
          child: ResponsiveContent(
            addHorizontalPadding: true,
            child: Obx(
              () => Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeroImage(),
                          const SizedBox(height: 16),
                          _buildStepIndicator(controller.currentStep.value),
                          const SizedBox(height: 16),
                          _buildFormCard(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white1,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.white2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          'resources/images/login_img.png',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: AppColors.white.withOpacity(0.1),
              child: const Center(
                child: Icon(
                  Icons.lock_reset_rounded,
                  color: AppColors.white,
                  size: 62,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int currentStep) {
    final List<String> steps = ['Email', 'OTP', 'New Password'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: List.generate(steps.length, (index) {
          final bool isDone = index < currentStep;
          final bool isActive = index == currentStep;

          return Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isDone || isActive
                        ? AppColors.primary2
                        : AppColors.white2,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isDone
                        ? const Icon(Icons.check,
                            size: 16, color: AppColors.white)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isActive
                                  ? AppColors.white
                                  : AppColors.primary2,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    steps[index],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isActive
                          ? AppColors.primary2
                          : AppColors.muteIconColor,
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                ),
                if (index != steps.length - 1)
                  Container(
                    width: 10,
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    color: isDone ? AppColors.primary2 : AppColors.divider,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.currentStep.value == 0) ...[
            _buildSectionTitle(
              title: 'Reset With Email',
              subtitle: 'Enter your email and we will send an OTP.',
            ),
            const SizedBox(height: 18),
            _buildInputLabel('Email Address'),
            const SizedBox(height: 8),
            CommonInputField.field(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'example@mail.com',
              prefixWidget: const Icon(
                Icons.alternate_email_rounded,
                color: AppColors.primary2,
              ),
            ),
            const SizedBox(height: 24),
            _buildPrimaryButton(
              label: 'Send OTP',
              onPressed: controller.sendResetCode,
            ),
          ] else if (controller.currentStep.value == 1) ...[
            _buildSectionTitle(
              title: 'Verify OTP',
              subtitle: 'Enter the 6-digit code sent to your email.',
            ),
            const SizedBox(height: 18),
            _buildInputLabel('OTP Code'),
            const SizedBox(height: 8),
            TextField(
              controller: controller.otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              style: const TextStyle(
                fontSize: 24,
                letterSpacing: 8,
                fontWeight: FontWeight.w600,
                color: AppColors.deepBlueColor,
              ),
              decoration: InputDecoration(
                counterText: '',
                hintText: '000000',
                filled: true,
                fillColor: AppColors.white1,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.primary2,
                    width: 1.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: controller.sendResetCode,
                child: const Text(
                  'Resend Code',
                  style: TextStyle(
                    color: AppColors.primary2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildPrimaryButton(
              label: 'Verify OTP',
              onPressed: controller.verifyOTP,
            ),
          ] else ...[
            _buildSectionTitle(
              title: 'Create New Password',
              subtitle: 'Use at least 8 characters with letters and numbers.',
            ),
            const SizedBox(height: 18),
            _buildInputLabel('New Password'),
            const SizedBox(height: 8),
            Obx(
              () => CommonInputField.field(
                controller: controller.newPasswordController,
                hintText: 'Enter new password',
                prefixWidget: const Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.primary2,
                ),
                obscureText: !controller.isPasswordVisible.value,
                suffixWidget: IconButton(
                  onPressed: controller.togglePasswordVisibility,
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.black2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            _buildInputLabel('Confirm Password'),
            const SizedBox(height: 8),
            Obx(
              () => CommonInputField.field(
                controller: controller.confirmPasswordController,
                hintText: 'Confirm password',
                prefixWidget: const Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.primary2,
                ),
                obscureText: !controller.isConfirmPasswordVisible.value,
                suffixWidget: IconButton(
                  onPressed: controller.toggleConfirmPasswordVisibility,
                  icon: Icon(
                    controller.isConfirmPasswordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.black2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildPrimaryButton(
              label: 'Reset Password',
              onPressed: controller.resetPassword,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.deepBlueColor,
            fontSize: 23,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.black2,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.black1,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: controller.isLoading.value ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: controller.isLoading.value
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: AppColors.white,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
      ),
    );
  }
}
