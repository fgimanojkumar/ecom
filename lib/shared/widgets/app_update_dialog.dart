import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/app_colors.dart';

/// Call AppUpdateDialog.checkAndShow() from SplashController to display this.
class AppUpdateDialog {
  AppUpdateDialog._();

  // Simulate version check — replace with real API call when backend is ready.
  static const String _latestVersion = '1.3.0';
  static const String _currentVersion = '1.2.2';
  static const String _updateUrl =
      'https://play.google.com/store'; // ignore: unused_field

  static bool get _hasUpdate => _latestVersion != _currentVersion;

  static Future<void> checkAndShow() async {
    if (!_hasUpdate) return;
    await Future.delayed(const Duration(milliseconds: 400));
    Get.dialog(
      const _UpdateDialogContent(),
      barrierDismissible: false,
    );
  }
}

class _UpdateDialogContent extends StatelessWidget {
  const _UpdateDialogContent();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.18),
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Gradient header ───────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
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
                      color: AppColors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.system_update_rounded,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Update Available! 🚀',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            // ── Body ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 14, color: AppColors.black2, height: 1.5),
                      children: [
                        TextSpan(text: 'A new version '),
                        TextSpan(
                          text: 'v${AppUpdateDialog._latestVersion}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary1,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' is available with improvements and bug fixes. Update now for the best experience.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // ── Buttons ──────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.black2,
                            side: const BorderSide(color: AppColors.white2),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text(
                            'Not Now',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.gradientStart,
                                AppColors.gradientEnd
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary1.withOpacity(0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.back();
                              // Open store URL when url_launcher is wired up
                            },
                            icon: const Icon(Icons.download_rounded,
                                color: AppColors.white, size: 18),
                            label: const Text(
                              'Update',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
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
