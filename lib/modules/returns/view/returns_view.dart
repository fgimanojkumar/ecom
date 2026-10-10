import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/returns_controller.dart';

class ReturnsView extends GetView<ReturnsController> {
  const ReturnsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Returns & Refunds',
        showBackButton: true,
      ),
      body: Obx(() {
        final orders = controller.visibleOrders;
        final returnCount = controller.returnOrders.length;
        final eligibleCount = controller.eligibleOrders.length;

        return RefreshIndicator(
          color: AppColors.primary1,
          onRefresh: () async => controller.refreshOrders(),
          child: ResponsiveContent(
            addHorizontalPadding: true,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                  children: [
                    const Text(
                      'Your returns',
                      style: TextStyle(
                        color: AppColors.black1,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$returnCount active ${returnCount == 1 ? 'return' : 'returns'} · $eligibleCount ${eligibleCount == 1 ? 'order' : 'orders'} eligible',
                      style: const TextStyle(
                        color: AppColors.black2,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ReturnsController.filters.map((filter) {
                        final isSelected =
                            controller.activeFilter.value == filter;
                        return ChoiceChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (_) => controller.selectFilter(filter),
                          selectedColor:
                              AppColors.primary1.withValues(alpha: 0.1),
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.primary1
                                : AppColors.white2,
                          ),
                          labelStyle: TextStyle(
                            color: isSelected
                                ? AppColors.primary1
                                : AppColors.black2,
                            fontWeight: FontWeight.w700,
                          ),
                          backgroundColor: AppColors.white,
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    if (orders.isEmpty)
                      _emptyState()
                    else
                      ...orders.map(_orderCard),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.info.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.info,
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Refunds are sent to the original payment method after the returned item is received and inspected.',
                              style: TextStyle(
                                color: AppColors.black2,
                                fontSize: 12,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _orderCard(Map<String, dynamic> order) {
    final hasReturn = order['returnRequestStatus'] != null;
    final lines = order['lines'];
    final itemName = lines is List && lines.isNotEmpty && lines.first is Map
        ? (lines.first as Map)['name']?.toString() ??
            '${order['items'] ?? 1} items'
        : '${order['items'] ?? 1} items';
    final total = order['total'];
    final totalLabel = total is num ? '₹${total.toStringAsFixed(0)}' : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.white2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary1.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.assignment_return_outlined,
                  color: AppColors.primary1,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ${order['id']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.black1,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order['date'] ?? 'Date unavailable'} · $itemName',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.black2,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (totalLabel.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  totalLabel,
                  style: const TextStyle(
                    color: AppColors.black1,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: hasReturn
                      ? AppColors.info.withValues(alpha: 0.08)
                      : AppColors.success.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  hasReturn
                      ? controller.statusLabel(order)
                      : 'Return available',
                  style: TextStyle(
                    color: hasReturn ? AppColors.info : AppColors.success,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () => hasReturn
                    ? controller.openReturnStatus(order)
                    : controller.requestReturn(order),
                icon: Icon(
                  hasReturn
                      ? Icons.route_outlined
                      : Icons.assignment_return_outlined,
                  size: 17,
                ),
                label: Text(hasReturn ? 'Track return' : 'Request return'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary1,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 36, horizontal: 12),
      child: Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 40,
            color: AppColors.muteIconColor,
          ),
          SizedBox(height: 12),
          Text(
            'No orders in this section',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black1,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Delivered orders within the return window will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.black2, height: 1.45),
          ),
        ],
      ),
    );
  }
}
