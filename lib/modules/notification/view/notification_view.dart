import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PremiumAppBar(
        title: 'Notifications',
        showBackButton: true,
        actions: [
          Obx(
            () => controller.hasUnread
                ? TextButton(
                    onPressed: controller.markAllRead,
                    child: const Text(
                      'Mark all read',
                      style: TextStyle(
                        color: AppColors.primary1,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Obx(() {
          if (controller.notifications.isEmpty) {
            return _EmptyState();
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              _NotificationGroup(
                label: 'Recent',
                notifications: controller.notifications.toList(),
                onDelete: (id) => controller.deleteNotification(id),
                onTap: (id) => controller.markAsRead(id),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _NotificationGroup extends StatelessWidget {
  final String label;
  final List<Map<String, dynamic>> notifications;
  final ValueChanged<String> onDelete;
  final ValueChanged<String> onTap;

  const _NotificationGroup({
    required this.label,
    required this.notifications,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.black2,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...notifications.map(
          (n) => _NotificationCard(
            notification: n,
            onDelete: () => onDelete(n['id'] as String),
            onTap: () => onTap(n['id'] as String),
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
    required this.onDelete,
    required this.onTap,
  });

  static const _typeConfig = {
    'order': (
      icon: Icons.shopping_bag_rounded,
      colors: [Color(0xFF4776E6), Color(0xFF8E54E9)],
    ),
    'offer': (
      icon: Icons.local_offer_rounded,
      colors: [Color(0xFF0F6B43), Color(0xFF37C87A)],
    ),
    'promotion': (
      icon: Icons.celebration_rounded,
      colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
    ),
  };

  @override
  Widget build(BuildContext context) {
    final isRead = notification['isRead'] as bool;
    final type = notification['type'] as String;
    final config = _typeConfig[type];
    final icon = config?.icon ?? Icons.notifications_rounded;
    final colors =
        config?.colors ?? [const Color(0xFF9CA3AF), const Color(0xFFD1D5DB)];

    return Dismissible(
      key: Key(notification['id'] as String),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_rounded, color: Colors.white, size: 24),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: isRead
                ? Border.all(color: const Color(0xFFF0F0F0))
                : Border.all(color: AppColors.primary1.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isRead ? 0.04 : 0.07),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient icon
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colors,
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  isRead ? FontWeight.w500 : FontWeight.w700,
                              color: AppColors.black1,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary1,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['message'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.black2,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification['time'] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.muteIconColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.primary1.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_off_rounded,
              size: 42,
              color: AppColors.primary1,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.black1,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "You're all caught up!\nWe'll notify you when something new arrives.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.black2,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
