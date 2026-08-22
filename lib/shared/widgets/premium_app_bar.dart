import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/style/app_colors.dart';
import '../../shared/style/app_text_style.dart';

class PremiumAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final double elevation;
  final Color? backgroundColor;

  const PremiumAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.elevation = 2,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedBackground = backgroundColor ?? AppColors.white;
    final isLightBackground = resolvedBackground.computeLuminance() > 0.5;
    final foregroundColor =
        isLightBackground ? AppColors.black1 : AppColors.white;

    return Container(
      decoration: BoxDecoration(
        color: resolvedBackground,
        border: isLightBackground
            ? const Border(
                bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary1.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AppBar(
        title: Text(
          title,
          style: AppTextStyle.fs12Black600().copyWith(
            color: foregroundColor,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: centerTitle,
        iconTheme: IconThemeData(color: AppColors.primary1),
        leading: leading ??
            (showBackButton
                ? IconButton(
                    icon: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.primary1.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.primary1,
                        size: 16,
                      ),
                    ),
                    onPressed: onBackPressed ?? () => _handleSafeBack(context),
                  )
                : null),
        actions: actions,
      ),
    );
  }

  void _handleSafeBack(BuildContext context) {
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
      return;
    }

    final navigator = Navigator.maybeOf(context);
    if (navigator?.canPop() ?? false) {
      navigator!.pop();
      return;
    }

    if (Get.previousRoute.isNotEmpty && Get.previousRoute != Get.currentRoute) {
      Get.offNamed(Get.previousRoute);
      return;
    }

    Get.offAllNamed('/home');
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
