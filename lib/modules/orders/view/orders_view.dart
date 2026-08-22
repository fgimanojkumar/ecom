import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = controller.orders;
    final deliveredCount =
        orders.where((o) => o['status'] == 'Delivered').length;
    final pendingCount = orders.where((o) => o['status'] != 'Delivered').length;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'My Orders',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Obx(() {
          if (controller.orders.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFECECEC)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.07),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: AppColors.primary2.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.inventory_2_outlined,
                          size: 40,
                          color: AppColors.primary2,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'No Orders Yet',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your purchased items will appear here once you place your first order.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black2,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => Get.toNamed('/products'),
                        icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                        label: const Text('Start Shopping'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary2,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        title: 'Total',
                        value: '${orders.length}',
                        icon: Icons.list_alt_rounded,
                        iconColor: AppColors.info,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Delivered',
                        value: '$deliveredCount',
                        icon: Icons.check_circle_rounded,
                        iconColor: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Pending',
                        value: '$pendingCount',
                        icon: Icons.timelapse_rounded,
                        iconColor: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final order = orders[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFECECEC)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.05),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    order['image'] as String,
                                    width: 92,
                                    height: 92,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 92,
                                        height: 92,
                                        color: AppColors.white2,
                                        child: const Icon(Icons.image),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              order['id'] as String,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: AppColors.black1,
                                              ),
                                            ),
                                          ),
                                          _statusChip(
                                            order['status'] as String,
                                            order['statusColor'] as String,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${order['items']} Items',
                                        style: const TextStyle(
                                          color: AppColors.black2,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Rs ${_formatAmount(order['total'])}',
                                        style: const TextStyle(
                                          color: AppColors.primary2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        order['date'] as String,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.muteIconColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.body,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    order['status'] == 'Delivered'
                                        ? Icons.verified_rounded
                                        : Icons.local_shipping,
                                    color: order['status'] == 'Delivered'
                                        ? AppColors.success
                                        : AppColors.info,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      order['status'] == 'Delivered'
                                          ? 'Delivered successfully to your address'
                                          : 'Shipment is on the way. Track for live updates.',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      controller.viewOrderDetails(
                                        order['id'] as String,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.location_on_outlined,
                                      size: 18,
                                    ),
                                    label: const Text('Track'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.primary2,
                                      side: const BorderSide(
                                        color: AppColors.primary2,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      controller.viewOrderDetails(
                                        order['id'] as String,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.receipt_long_rounded,
                                      color: AppColors.white,
                                      size: 18,
                                    ),
                                    label: const Text(
                                      'Details',
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _formatAmount(dynamic value) {
    final amount = (value as num?)?.toDouble() ?? 0;
    if (amount == amount.roundToDouble()) {
      return amount.toStringAsFixed(0);
    }
    return amount.toStringAsFixed(2);
  }

  Widget _statusChip(
    String status,
    String color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: _getStatusColor(color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'green':
        return AppColors.success;

      case 'blue':
        return AppColors.info;

      case 'orange':
        return AppColors.warning;

      case 'red':
        return AppColors.error;

      default:
        return AppColors.greyLight;
    }
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.black1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.black2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
