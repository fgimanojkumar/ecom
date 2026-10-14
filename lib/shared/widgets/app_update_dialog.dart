import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';

/// Shows an update dialog when the app has a newer version available.
/// Force-update mode is enabled when the current app version is below the
/// minimum required version for continued access to the app.
class AppUpdateDialog {
  AppUpdateDialog._();

  static const String _currentVersion = '1.2.2';
  static const String _latestVersion = '1.3.1';
  static const String _minimumRequiredVersion = '1.3.0';

  static bool get _hasUpdate =>
      _compareVersions(_currentVersion, _latestVersion) < 0;
  static bool get _isForceUpdate =>
      _compareVersions(_currentVersion, _minimumRequiredVersion) < 0;

  static int _compareVersions(String current, String target) {
    final currentParts = current.split('.').map(int.tryParse).toList();
    final targetParts = target.split('.').map(int.tryParse).toList();

    final maxLength = currentParts.length > targetParts.length
        ? currentParts.length
        : targetParts.length;

    for (var i = 0; i < maxLength; i++) {
      final currentValue = i < currentParts.length ? (currentParts[i] ?? 0) : 0;
      final targetValue = i < targetParts.length ? (targetParts[i] ?? 0) : 0;

      if (currentValue < targetValue) return -1;
      if (currentValue > targetValue) return 1;
    }

    return 0;
  }

  static Future<void> checkAndShow() async {
    if (!_hasUpdate) return;
    await Future.delayed(const Duration(milliseconds: 400));
    Get.dialog(
      _UpdateDialogContent(isForceUpdate: _isForceUpdate),
      barrierDismissible: !_isForceUpdate,
    );
  }

  static Future<void> showTestDialog({bool force = false}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    Get.dialog(
      _UpdateDialogContent(isForceUpdate: force),
      barrierDismissible: !force,
    );
  }
}

class _UpdateDialogContent extends StatelessWidget {
  const _UpdateDialogContent({required this.isForceUpdate});

  final bool isForceUpdate;

  @override
  Widget build(BuildContext context) {
    final titleText =
        isForceUpdate ? 'Mandatory Update Required' : 'New Update Available';
    final subtitle = isForceUpdate
        ? 'This version is no longer supported. Please update to continue using the app.'
        : 'A newer version is available with performance improvements and bug fixes.';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.18),
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 26),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.system_update_rounded,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    titleText,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.black2,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _VersionInfoRow(
                    label: 'Current version',
                    value: 'v${AppUpdateDialog._currentVersion}',
                  ),
                  _VersionInfoRow(
                    label: 'Latest version',
                    value: 'v${AppUpdateDialog._latestVersion}',
                  ),
                  _VersionInfoRow(
                    label: 'Required version',
                    value: isForceUpdate
                        ? 'v${AppUpdateDialog._minimumRequiredVersion}'
                        : 'v${AppUpdateDialog._latestVersion}',
                  ),
                  const SizedBox(height: 18),
                  Text(
                    isForceUpdate
                        ? '• Security fixes\n• Improved performance\n• Required for continued access'
                        : '• Bug fixes\n• Stability improvements\n• Better user experience',
                    style: const TextStyle(
                      color: AppColors.black1,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (isForceUpdate)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: null,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.black2,
                              side: BorderSide(color: AppColors.white2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      if (isForceUpdate) const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary1,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isForceUpdate ? 'Update' : 'Update',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      if (isForceUpdate) ...[
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.black,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Force Update',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                      if (!isForceUpdate)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.black2,
                              side: const BorderSide(color: AppColors.white2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionInfoRow extends StatelessWidget {
  const _VersionInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.black2,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.black1,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
