import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/style/app_text_style.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBackground = isDark ? const Color(0xFF121212) : AppColors.white;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: const PremiumAppBar(
        title: 'Settings',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Obx(
          () => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  context: context,
                  title: 'Account',
                  children: [
                    _SettingsTile(
                      icon: Icons.person,
                      title: 'Edit Profile',
                      onTap: () => Get.toNamed('/profile'),
                    ),
                    _SettingsTile(
                      icon: Icons.location_on,
                      title: 'Manage Addresses',
                      onTap: () => Get.toNamed('/address'),
                    ),
                    _SettingsTile(
                      icon: Icons.payment,
                      title: 'Payment Methods',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildSection(
                  context: context,
                  title: 'Notifications',
                  children: [
                    _SettingsToggle(
                      icon: Icons.notifications,
                      title: 'All Notifications',
                      value: controller.notificationsEnabled.value,
                      onChanged: (_) => controller.toggleNotifications(),
                    ),
                    _SettingsToggle(
                      icon: Icons.email,
                      title: 'Email Notifications',
                      value: controller.emailNotifications.value,
                      onChanged: (_) => controller.toggleEmailNotifications(),
                    ),
                    _SettingsToggle(
                      icon: Icons.sms,
                      title: 'SMS Notifications',
                      value: controller.smsNotifications.value,
                      onChanged: (_) => controller.toggleSmsNotifications(),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildSection(
                  context: context,
                  title: 'Preferences',
                  children: [
                    _SettingsToggle(
                      icon: Icons.dark_mode,
                      title: 'Dark Mode',
                      value: controller.isDarkMode.value,
                      onChanged: (_) => controller.toggleDarkMode(),
                    ),
                    _SettingsTile(
                      icon: Icons.language,
                      title: 'Language',
                      subtitle: controller.selectedLanguage.value,
                      onTap: () {
                        Get.bottomSheet(
                          _LanguageBottomSheet(
                            selectedLanguage: controller.selectedLanguage.value,
                            onSelect: (lang) {
                              controller.changeLanguage(lang);
                              Get.back();
                            },
                          ),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildSection(
                  context: context,
                  title: 'About',
                  children: [
                    _SettingsTile(
                      icon: Icons.info,
                      title: 'About Us',
                      onTap: () => Get.toNamed('/about'),
                    ),
                    _SettingsTile(
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      onTap: () => Get.toNamed('/privacy'),
                    ),
                    _SettingsTile(
                      icon: Icons.description,
                      title: 'Terms & Conditions',
                      onTap: () => Get.toNamed('/terms'),
                    ),
                    _SettingsTile(
                      icon: Icons.help,
                      title: 'Help Center',
                      onTap: () => Get.toNamed('/help'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildSection(
                  context: context,
                  title: 'Security',
                  children: [
                    _SettingsTile(
                      icon: Icons.lock,
                      title: 'Change Password',
                      onTap: () => Get.toNamed('/changePassword'),
                    ),
                    _SettingsTile(
                      icon: Icons.logout,
                      title: 'Logout',
                      titleColor: AppColors.error,
                      iconColor: AppColors.error,
                      onTap: controller.showLogoutConfirmation,
                    ),
                    _SettingsTile(
                      icon: Icons.delete_forever,
                      title: 'Delete Account',
                      titleColor: AppColors.error,
                      iconColor: AppColors.error,
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text('Delete Account'),
                            content: const Text(
                              'Are you sure you want to delete your account? This action cannot be undone.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: controller.deleteAccount,
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<Widget> children,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1D1D1D) : AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? const Color(0xFF313131) : const Color(0xFFECECEC),
        ),
        boxShadow: [
          if (!isDark)
            const BoxShadow(
              color: Color(0x0F111111),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 8),
            child: Text(
              title,
              style: AppTextStyle.fs12Black600().copyWith(
                fontSize: 13,
                color: isDark ? Colors.white : AppColors.black1,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final Color? iconColor;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.titleColor,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      minLeadingWidth: 8,
      horizontalTitleGap: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.primary2)
              .withOpacity(isDark ? 0.22 : 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.primary2,
          size: 19,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? (isDark ? Colors.white : AppColors.black1),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                color: isDark ? const Color(0xFFB7B7B7) : AppColors.black2,
                fontSize: 11,
              ),
            )
          : null,
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: isDark ? const Color(0xFF9D9D9D) : const Color(0xFF9CA3AF),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggle({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      minLeadingWidth: 8,
      horizontalTitleGap: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.primary2.withOpacity(isDark ? 0.22 : 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary2, size: 19),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : AppColors.black1,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary2,
        activeTrackColor: AppColors.primary2.withOpacity(0.35),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}

class _LanguageBottomSheet extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onSelect;

  const _LanguageBottomSheet({
    required this.selectedLanguage,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const languages = ['English', 'Hindi', 'Spanish'];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B1B1B) : AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xFF4B4B4B) : const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(
              'Select Language',
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.black1,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            ...languages.map(
              (lang) {
                final isSelected = selectedLanguage == lang;
                return ListTile(
                  onTap: () => onSelect(lang),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  title: Text(
                    lang,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isDark ? Colors.white : AppColors.black1,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle,
                          color: AppColors.primary2)
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
