import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/invite_friends_controller.dart';

class InviteFriendsView extends GetView<InviteFriendsController> {
  const InviteFriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Invite Friends',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.friends.length,
          itemBuilder: (context, index) {
            final friend = controller.friends[index];
            return _FriendListItem(
              index: index,
              name: friend['name'] ?? '',
              phone: friend['phone'] ?? '',
              avatarUrl: friend['avatar'] ?? '',
            );
          },
        ),
      ),
    );
  }
}

class _FriendListItem extends GetView<InviteFriendsController> {
  const _FriendListItem({
    required this.index,
    required this.name,
    required this.phone,
    required this.avatarUrl,
  });

  final int index;
  final String name;
  final String phone;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.white2, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.white1,
                    alignment: Alignment.center,
                    child: Text(
                      name.isNotEmpty ? name[0] : '?',
                      style: const TextStyle(
                        color: AppColors.muteIconColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.black1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: const TextStyle(
                    color: AppColors.muteIconColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Obx(() {
            final invited = controller.invitedIndexes.contains(index);
            return TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 220),
              tween: Tween<double>(begin: 1, end: invited ? 0.96 : 1),
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: GestureDetector(
                onTap: invited ? null : () => controller.inviteFriend(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: invited ? AppColors.primary2 : AppColors.primary1,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary1.withOpacity(0.24),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    invited ? 'Invited' : 'Invite',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
