import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Change Password',
        showBackButton: true,
      ),
      body: SafeArea(
        child: ResponsiveContent(
          addHorizontalPadding: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
            child: Column(
              children: [
                // ─── Hero illustration ─────────────────────────
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: SvgPicture.string(
                    '''<svg viewBox="0 0 240 200" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="120" cy="100" r="90" fill="#F0FAF5"/>
                        <circle cx="120" cy="100" r="68" fill="#D6F0E5"/>
                        <rect x="85" y="88" width="70" height="54" rx="10" fill="#0F6B43"/>
                        <rect x="93" y="96" width="54" height="38" rx="7" fill="#37C87A"/>
                        <path d="M102 88 C102 72 138 72 138 88" stroke="#0F6B43" stroke-width="8" fill="none" stroke-linecap="round"/>
                        <circle cx="120" cy="115" r="8" fill="#0F6B43"/>
                        <rect x="117" y="115" width="6" height="10" rx="3" fill="#0F6B43"/>
                        <circle cx="68" cy="72" r="10" fill="#37C87A" opacity="0.6"/>
                        <circle cx="172" cy="68" r="7" fill="#0F6B43" opacity="0.4"/>
                        <circle cx="60" cy="130" r="5" fill="#37C87A" opacity="0.5"/>
                        <circle cx="180" cy="132" r="9" fill="#0F6B43" opacity="0.3"/>
                      </svg>''',
                    width: 180,
                    height: 150,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.white2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppColors.body,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.lock_reset_rounded,
                              color: AppColors.primary1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Secure your account',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Use a strong password with uppercase letters and numbers.',
                        style: TextStyle(
                          color: AppColors.black2,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      _PasswordField(
                        label: 'Current Password',
                        controller: controller.oldPasswordController,
                        isVisible: controller.isOldVisible,
                        onToggle: controller.toggleOldVisibility,
                      ),
                      const SizedBox(height: 12),
                      _PasswordField(
                        label: 'New Password',
                        controller: controller.newPasswordController,
                        isVisible: controller.isNewVisible,
                        onToggle: controller.toggleNewVisibility,
                      ),
                      const SizedBox(height: 12),
                      _PasswordField(
                        label: 'Confirm New Password',
                        controller: controller.confirmPasswordController,
                        isVisible: controller.isConfirmVisible,
                        onToggle: controller.toggleConfirmVisibility,
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: controller.isSaving.value
                                ? null
                                : controller.updatePassword,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primary1,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: controller.isSaving.value
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.white,
                                    ),
                                  )
                                : const Text(
                                    'Update Password',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
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
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.controller,
    required this.isVisible,
    required this.onToggle,
  });

  final String label;
  final TextEditingController controller;
  final RxBool isVisible;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        controller: controller,
        obscureText: !isVisible.value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.black2, fontSize: 13),
          filled: true,
          fillColor: AppColors.white1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              isVisible.value ? Icons.visibility_off : Icons.visibility,
              color: AppColors.primary1,
            ),
          ),
        ),
      ),
    );
  }
}
