import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/app_toast.dart';
import '../../../shared/widgets/dialogs.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/profile_controller.dart';
import 'profile_photo_upload_bottomsheet.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Profile',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: _ProfileContent(controller: controller),
      ),
    );
  }
}

class _ProfileContent extends StatefulWidget {
  const _ProfileContent({required this.controller});

  final ProfileController controller;

  @override
  State<_ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<_ProfileContent> {
  final Dialogs _dialogs = Dialogs();
  bool _showProfileUpdateForm = false;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Jennifer Aaker');
    _emailController = TextEditingController(text: 'jennifer@email.com');
    _phoneController = TextEditingController(text: '+91 9876543210');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onMenuTap(_ProfileMenuItemData item) {
    if (item.title == 'Your Profile') {
      setState(() => _showProfileUpdateForm = true);
      return;
    }

    try {
      Get.toNamed(item.route);
    } catch (_) {
      AppToast.errorToast('${item.title} screen is not available yet.');
    }
  }

  void _onSaveProfile() {
    AppToast.successToast('Profile updated successfully');
    setState(() => _showProfileUpdateForm = false);
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = <_ProfileMenuItemData>[
      const _ProfileMenuItemData(
        title: 'Your Profile',
        subtitle: 'Personal information',
        icon: Icons.person_outline_rounded,
        route: '/profileInfo',
      ),
      const _ProfileMenuItemData(
        title: 'Manage Address',
        subtitle: 'Shipping locations',
        icon: Icons.location_on_outlined,
        route: '/address',
      ),
      const _ProfileMenuItemData(
        title: 'Payment Methods',
        subtitle: 'Saved cards & UPI',
        icon: Icons.credit_card_outlined,
        route: '/payment',
      ),
      const _ProfileMenuItemData(
        title: 'My Orders',
        subtitle: 'Order history',
        icon: Icons.shopping_bag_outlined,
        route: '/myOrders',
      ),
      const _ProfileMenuItemData(
        title: 'My Coupons',
        subtitle: 'Offers and vouchers',
        icon: Icons.local_offer_outlined,
        route: '/coupons',
      ),
      const _ProfileMenuItemData(
        title: 'My Wallet',
        subtitle: 'Balance and transactions',
        icon: Icons.account_balance_wallet_outlined,
        route: '/wallet',
      ),
      const _ProfileMenuItemData(
        title: 'Settings',
        subtitle: 'App preferences',
        icon: Icons.settings_outlined,
        route: '/settings',
      ),
    ];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 260),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: SingleChildScrollView(
        key: ValueKey(_showProfileUpdateForm ? 'profile-form' : 'profile-main'),
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
        child: Column(
          children: [
            _ProfileIdentityCard(controller: widget.controller),
            const SizedBox(height: 20),
            if (_showProfileUpdateForm)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFECECEC)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x10000000),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _ProfileFormField(
                      controller: _nameController,
                      label: 'Full Name',
                    ),
                    const SizedBox(height: 12),
                    _ProfileFormField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    _ProfileFormField(
                      controller: _phoneController,
                      label: 'Phone',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onSaveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C4CE6),
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _showProfileUpdateForm = false);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Color(0xFF888888)),
                      ),
                    ),
                  ],
                ),
              )
            else ...[
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFECECEC)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x10000000),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuItems.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFECECEC),
                  ),
                  itemBuilder: (context, index) {
                    return _ProfileMenuItem(
                      item: menuItems[index],
                      onTap: () => _onMenuTap(menuItems[index]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () => _dialogs.logoutConfirm(
                    'Are you sure want to logout',
                    'Are you sure you want to log out from this device?',
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFFD8D8)),
                    backgroundColor: const Color(0xFFFFFAFA),
                    foregroundColor: const Color(0xFFE14A4A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 19),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Color(0xFFE38C8C),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProfileIdentityCard extends StatefulWidget {
  const _ProfileIdentityCard({required this.controller});

  final ProfileController controller;

  @override
  State<_ProfileIdentityCard> createState() => _ProfileIdentityCardState();
}

class _ProfileIdentityCardState extends State<_ProfileIdentityCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const userName = 'Jennifer Aaker';
    return Column(
      children: [
        GestureDetector(
          onTapDown: (_) {},
          onTap: () => _openPhotoSheet(context),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 220),
            tween: Tween<double>(begin: 1, end: 1),
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: SizedBox(
              width: 102,
              height: 102,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white,
                          width: 4,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Obx(() {
                          if (widget.controller.isLoading.value) {
                            return const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF6C4CE6),
                                ),
                              ),
                            );
                          }

                          final selectedImage =
                              widget.controller.selectedImage.value;
                          if (selectedImage == null) {
                            return Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFFF2F2F2),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 44,
                                  color: Color(0xFFB0B0B0),
                                ),
                              ),
                            );
                          }

                          return Image.file(
                            selectedImage,
                            fit: BoxFit.cover,
                          );
                        }),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final value = 1 + (_pulseController.value * 0.09);
                        return Transform.scale(scale: value, child: child);
                      },
                      child: InkWell(
                        onTap: () => _openPhotoSheet(context),
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C4CE6),
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AppColors.white, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x226C4CE6),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.edit_rounded,
                            size: 14,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          userName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF222222),
          ),
        ),
      ],
    );
  }

  void _openPhotoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return const FractionallySizedBox(child: ProfilePhotoBottomSheet());
      },
    );
  }
}

class _ProfileMenuItemData {
  const _ProfileMenuItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
}

class _ProfileMenuItem extends StatefulWidget {
  const _ProfileMenuItem({required this.item, required this.onTap});

  final _ProfileMenuItemData item;
  final VoidCallback onTap;

  @override
  State<_ProfileMenuItem> createState() => _ProfileMenuItemState();
}

class _ProfileMenuItemState extends State<_ProfileMenuItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _arrowController;

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0,
      upperBound: 1,
      value: 0,
    );
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHighlightChanged: (value) {
        if (value) {
          _arrowController.forward();
        } else {
          _arrowController.reverse();
        }
      },
      child: SizedBox(
        height: 62,
        child: Row(
          children: [
            const SizedBox(width: 14),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF3EEFF),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                widget.item.icon,
                size: 19,
                color: const Color(0xFF6C4CE6),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    widget.item.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _arrowController,
              builder: (context, child) {
                final dx = _arrowController.value * 4;
                return Transform.translate(
                  offset: Offset(dx, 0),
                  child: Transform.rotate(
                    angle: _arrowController.value * (math.pi / 36),
                    child: child,
                  ),
                );
              },
              child: const Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: Color(0xFFB0B0B0),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

class _ProfileFormField extends StatelessWidget {
  const _ProfileFormField({
    required this.controller,
    required this.label,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFF888888),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFECECEC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFECECEC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6C4CE6), width: 1.2),
        ),
      ),
    );
  }
}
