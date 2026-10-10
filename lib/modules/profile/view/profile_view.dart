import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/demo/demo_account_store.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/dialogs.dart';
import '../../../shared/widgets/common_input_field.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/profile_controller.dart';
import 'profile_photo_upload_bottomsheet.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(title: 'Profile', showBackButton: true),
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
  bool _editingProfile = false;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  final _menuItems = const <_ProfileMenuEntry>[
    _ProfileMenuEntry(
      title: 'Personal information',
      subtitle: 'Edit your name and contact details',
      icon: Icons.person_outline_rounded,
      route: '',
      isEditAction: true,
    ),
    _ProfileMenuEntry(
      title: 'My Orders',
      subtitle: 'Order history and tracking',
      icon: Icons.shopping_bag_outlined,
      route: '/myOrders',
    ),
    _ProfileMenuEntry(
      title: 'Manage Addresses',
      subtitle: 'Delivery locations',
      icon: Icons.location_on_outlined,
      route: '/address',
    ),
    _ProfileMenuEntry(
      title: 'Payment Methods',
      subtitle: 'Available checkout methods',
      icon: Icons.credit_card_outlined,
      route: '/paymentMethods',
    ),
    _ProfileMenuEntry(
      title: 'My Coupons',
      subtitle: 'Offers and vouchers',
      icon: Icons.local_offer_outlined,
      route: '/coupons',
    ),
    _ProfileMenuEntry(
      title: 'Return & Refund Status',
      subtitle: 'Track an order return',
      icon: Icons.assignment_return_outlined,
      route: '/returnStatus',
    ),
    _ProfileMenuEntry(
      title: 'Refer & Earn',
      subtitle: 'Invite friends',
      icon: Icons.card_giftcard_outlined,
      route: '/referAndEarn',
    ),
    _ProfileMenuEntry(
      title: 'Settings',
      subtitle: 'App preferences',
      icon: Icons.settings_outlined,
      route: '/settings',
    ),
  ];

  @override
  void initState() {
    super.initState();
    final user = DemoAccountStore.activeUser.value ?? DemoAccountStore.demoUser;
    _nameController =
        TextEditingController(text: user['name']?.toString() ?? '');
    _emailController =
        TextEditingController(text: user['email']?.toString() ?? '');
    _phoneController =
        TextEditingController(text: user['phone']?.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _openProfileEditor() {
    final user = DemoAccountStore.activeUser.value ?? DemoAccountStore.demoUser;
    _nameController.text = user['name']?.toString() ?? '';
    _emailController.text = user['email']?.toString() ?? '';
    _phoneController.text = user['phone']?.toString() ?? '';
    setState(() => _editingProfile = true);
  }

  void _saveProfile() {
    DemoAccountStore.updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    );
    setState(() => _editingProfile = false);
    Get.snackbar('Profile updated', 'Your details have been saved.');
  }

  void _onMenuTap(_ProfileMenuEntry item) {
    if (item.isEditAction) {
      _openProfileEditor();
    } else {
      Get.toNamed(item.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ProfileSummaryCard(
                controller: widget.controller,
                onEditProfilePressed: _openProfileEditor,
              ),
              const SizedBox(height: 18),
              if (_editingProfile) _buildProfileEditor() else _buildMenu(),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: () => _dialogs.logoutConfirm(
                  'Log out?',
                  'Are you sure you want to log out from this device?',
                ),
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Log out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side:
                      BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: _showDeleteAccountInfo,
                  child: const Text('Delete account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileEditor() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Personal information',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          _ProfileField(controller: _nameController, label: 'Full name'),
          const SizedBox(height: 12),
          _ProfileField(
            controller: _emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          _ProfileField(
            controller: _phoneController,
            label: 'Mobile number',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _editingProfile = false),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white2),
      ),
      child: Column(
        children: [
          for (var index = 0; index < _menuItems.length; index++) ...[
            _ProfileMenuTile(
              item: _menuItems[index],
              onTap: () => _onMenuTap(_menuItems[index]),
            ),
            if (index < _menuItems.length - 1)
              const Divider(height: 1, indent: 58),
          ],
        ],
      ),
    );
  }

  void _showDeleteAccountInfo() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete account'),
        content: const Text(
          'Account deletion is not connected in this local demo. Contact support to request deletion of a production account.',
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Close')),
          TextButton(
            onPressed: () {
              Get.back();
              Get.toNamed('/support');
            },
            child: const Text('Contact support'),
          ),
        ],
      ),
    );
  }
}

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard({
    required this.controller,
    required this.onEditProfilePressed,
  });

  final ProfileController controller;
  final VoidCallback onEditProfilePressed;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user =
          DemoAccountStore.activeUser.value ?? DemoAccountStore.demoUser;
      final selectedImage = controller.selectedImage.value;
      final name = user['name']?.toString() ?? 'Customer';
      final email = user['email']?.toString() ?? '';
      final phone = user['phone']?.toString() ?? '';

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white2),
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => _openPhotoSheet(context),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: ClipOval(
                            child: controller.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.primary1,
                                    ),
                                  )
                                : selectedImage == null
                                    ? Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            _avatarFallback(),
                                      )
                                    : Image.file(
                                        selectedImage,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            _avatarFallback(),
                                      ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: AppColors.primary1,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              color: AppColors.white,
                              size: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.black1,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _ProfileContactLine(
                                icon: Icons.email_outlined, value: email),
                            if (phone.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              _ProfileContactLine(
                                  icon: Icons.phone_outlined, value: phone),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: onEditProfilePressed,
                        tooltip: 'Edit profile',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.edit_note_rounded,
                            color: AppColors.primary1, size: 22),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Divider(height: 1),
            ),
            Row(
              children: [
                const Icon(Icons.workspace_premium_outlined,
                    color: AppColors.primary1, size: 22),
                const SizedBox(width: 9),
                const Expanded(
                  child: Text(
                    'Reward points',
                    style: TextStyle(
                      color: AppColors.black1,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '${DemoAccountStore.loyaltyPoints} pts',
                  style: const TextStyle(
                    color: AppColors.primary1,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => Get.toNamed('/loyaltyPoints'),
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: const Text('View rewards'),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _avatarFallback() => Container(
        color: AppColors.white1,
        alignment: Alignment.center,
        child: const Icon(Icons.person_rounded,
            size: 38, color: AppColors.muteIconColor),
      );

  void _openPhotoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ProfilePhotoBottomSheet(),
    );
  }
}

class _ProfileContactLine extends StatelessWidget {
  const _ProfileContactLine({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppColors.black2),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.black2, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _ProfileMenuEntry {
  const _ProfileMenuEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    this.isEditAction = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final bool isEditAction;
}

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({required this.item, required this.onTap});

  final _ProfileMenuEntry item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primary1.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(item.icon, color: AppColors.primary1, size: 19),
      ),
      title: Text(item.title,
          style: const TextStyle(
              color: AppColors.black1, fontWeight: FontWeight.w700)),
      subtitle: Text(item.subtitle),
      trailing: const Icon(Icons.chevron_right_rounded,
          color: AppColors.muteIconColor),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.controller,
    required this.label,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return CommonInputField.field(
      controller: controller,
      keyboardType: keyboardType,
      labelText: label,
    );
  }
}
