import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/app/controller/app_controller.dart';
import '../demo/demo_account_store.dart';
import '../style/app_colors.dart';
import 'common_app_drawer.dart';

enum _AccountMenuAction { login, orders, logout }

/// Seller app top bar - title, back navigation, a notifications bell and
/// an account menu (orders / logout). No shopping cart or product search.
class PremiumAppBar extends StatefulWidget implements PreferredSizeWidget {
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
  State<PremiumAppBar> createState() => _PremiumAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _PremiumAppBarState extends State<PremiumAppBar> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadAccountStatus();
  }

  Future<void> _loadAccountStatus() async {
    Map<String, dynamic>? user;
    try {
      user = await DemoAccountStore.restoreSession();
    } catch (_) {
      user = null;
    }
    if (!mounted) return;
    setState(() => _isLoggedIn = user != null);
  }

  void _openDrawerIfAvailable(BuildContext context) {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold != null && scaffold.hasDrawer) {
      scaffold.openDrawer();
      return;
    }
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close navigation menu',
      barrierColor: AppColors.black.withOpacity(0.42),
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (dialogContext, animation, secondaryAnimation) =>
          const Align(
        alignment: Alignment.centerLeft,
        child: CommonAppDrawer(panelMode: true),
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final slide =
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
              .animate(slide),
          child: child,
        );
      },
    );
  }

  void _handleSafeBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }
    Get.offAllNamed('/home');
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    int badge = 0,
    Color iconColor = AppColors.primary1,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.divider),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: iconColor, size: 20),
            if (badge > 0)
              Positioned(
                top: -6,
                right: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: AppColors.error, shape: BoxShape.circle),
                  constraints:
                      const BoxConstraints(minWidth: 18, minHeight: 18),
                  child: Text(
                    badge > 99 ? '99+' : badge.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountMenu() {
    return PopupMenuButton<_AccountMenuAction>(
      tooltip: 'Account menu',
      position: PopupMenuPosition.under,
      offset: const Offset(0, 8),
      color: AppColors.white,
      surfaceTintColor: AppColors.white,
      elevation: 14,
      constraints: const BoxConstraints(minWidth: 220, maxWidth: 260),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.divider),
      ),
      onSelected: _handleAccountAction,
      itemBuilder: (context) => [
        PopupMenuItem<_AccountMenuAction>(
          enabled: false,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCEEEE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.storefront_rounded,
                    color: AppColors.primary1, size: 21),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Seller account',
                      style: TextStyle(
                          color: AppColors.black1,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  Text(_isLoggedIn ? 'Signed in' : 'Not signed in',
                      style: const TextStyle(
                          color: AppColors.black2, fontSize: 11)),
                ],
              ),
            ],
          ),
        ),
        const PopupMenuDivider(height: 1),
        if (!_isLoggedIn)
          _accountMenuItem(
              action: _AccountMenuAction.login,
              icon: Icons.login_rounded,
              label: 'Login'),
        _accountMenuItem(
            action: _AccountMenuAction.orders,
            icon: Icons.receipt_long_outlined,
            label: 'View orders'),
        if (_isLoggedIn)
          _accountMenuItem(
              action: _AccountMenuAction.logout,
              icon: Icons.logout_rounded,
              label: 'Logout',
              isDestructive: true),
      ],
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.divider),
        ),
        child: const Icon(Icons.person_outline_rounded,
            color: AppColors.primary1, size: 20),
      ),
    );
  }

  PopupMenuItem<_AccountMenuAction> _accountMenuItem({
    required _AccountMenuAction action,
    required IconData icon,
    required String label,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? AppColors.error : AppColors.black1;
    return PopupMenuItem<_AccountMenuAction>(
      value: action,
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Icon(icon, size: 19, color: color),
          const SizedBox(width: 11),
          Text(label,
              style: TextStyle(
                  color: color, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  void _handleAccountAction(_AccountMenuAction action) {
    switch (action) {
      case _AccountMenuAction.login:
        Get.toNamed('/login');
      case _AccountMenuAction.orders:
        Get.toNamed('/myOrders');
      case _AccountMenuAction.logout:
        final appController = Get.isRegistered<AppController>()
            ? Get.find<AppController>()
            : Get.put(AppController());
        appController.logoutConfirm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultActions = widget.actions ??
        [
          _buildActionButton(
            icon: Icons.notifications_none_rounded,
            onPressed: () => Get.toNamed('/notifications'),
          ),
          const SizedBox(width: 8),
          _buildAccountMenu(),
          const SizedBox(width: 8),
          _buildActionButton(
            icon: Icons.menu_rounded,
            iconColor: AppColors.black1,
            onPressed: () => _openDrawerIfAvailable(context),
          ),
        ];

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary1.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: const Border(
            bottom: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(
            children: [
              if (widget.leading != null)
                widget.leading!
              else if (widget.showBackButton)
                IconButton(
                  onPressed:
                      widget.onBackPressed ?? () => _handleSafeBack(context),
                  icon: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.primary1.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: AppColors.primary1, size: 16),
                  ),
                )
              else
                const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.title,
                  textAlign:
                      widget.centerTitle ? TextAlign.center : TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.black1,
                  ),
                ),
              ),
              if (!kIsWeb || MediaQuery.sizeOf(context).width < 1200)
                Row(mainAxisSize: MainAxisSize.min, children: defaultActions),
            ],
          ),
        ),
      ),
    );
  }
}
