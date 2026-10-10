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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'My Orders',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Obx(() {
          final orders = controller.orders;
          if (orders.isEmpty) return _buildEmptyState();

          final deliveredOrders =
              orders.where((order) => order['status'] == 'Delivered').toList();
          final pendingOrders = orders.where((order) {
            final status = (order['status'] as String? ?? '').toLowerCase();
            return status != 'delivered' &&
                status != 'cancelled' &&
                status != 'returned';
          }).toList();
          final filteredOrders = switch (controller.selectedStatus.value) {
            'Delivered' => deliveredOrders,
            'Pending' => pendingOrders,
            _ => orders.toList(),
          };

          if (filteredOrders.isEmpty) {
            return _buildFilteredEmptyState(controller.selectedStatus.value);
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Your orders',
                        style: TextStyle(
                          color: AppColors.black1,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      '${orders.length} total',
                      style: const TextStyle(
                        color: AppColors.black2,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'To download an invoice, tap Track on the order and choose Invoice.',
                    style: TextStyle(
                      color: AppColors.black2,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: _OrdersFilterTab(
                        label: 'Total',
                        count: orders.length,
                        selected: controller.selectedStatus.value == 'Total',
                        onTap: () => controller.selectStatus('Total'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _OrdersFilterTab(
                        label: 'Delivered',
                        count: deliveredOrders.length,
                        selected:
                            controller.selectedStatus.value == 'Delivered',
                        onTap: () => controller.selectStatus('Delivered'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _OrdersFilterTab(
                        label: 'Pending',
                        count: pendingOrders.length,
                        selected: controller.selectedStatus.value == 'Pending',
                        onTap: () => controller.selectStatus('Pending'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 800));
                  },
                  color: AppColors.primary1,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 900) {
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 600,
                            mainAxisExtent: 520,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: filteredOrders.length,
                          itemBuilder: (context, index) => _OrderCard(
                            order: filteredOrders[index],
                            controller: controller,
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        itemCount: filteredOrders.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) => _OrderCard(
                          order: filteredOrders[index],
                          controller: controller,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.07),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: AppColors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary1.withOpacity(0.12),
                      AppColors.gradientEnd.withOpacity(0.12),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.inventory_2_outlined,
                    size: 40, color: AppColors.primary1),
              ),
              const SizedBox(height: 18),
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
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary1.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () => Get.toNamed('/home'),
                  icon: const Icon(Icons.shopping_bag_outlined,
                      size: 18, color: AppColors.white),
                  label: const Text('Start Shopping',
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilteredEmptyState(String status) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.inbox_outlined,
              color: AppColors.muteIconColor,
              size: 42,
            ),
            const SizedBox(height: 12),
            Text(
              'No $status orders',
              style: const TextStyle(
                color: AppColors.black1,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => controller.selectStatus('Total'),
              child: const Text('Show all orders'),
            ),
          ],
        ),
      ),
    );
  }
}

// â”€â”€â”€ Order Card â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _OrdersFilterTab extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const _OrdersFilterTab({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          constraints: const BoxConstraints(minHeight: 62),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEAF4EE) : AppColors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: selected ? AppColors.primary1 : AppColors.white2,
              width: selected ? 1.3 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? AppColors.primary1 : AppColors.black2,
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '$count',
                style: TextStyle(
                  color: selected ? AppColors.primary1 : AppColors.black1,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderCard extends StatefulWidget {
  final Map order;
  final OrdersController controller;

  const _OrderCard({required this.order, required this.controller});

  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> {
  bool _trackingExpanded = false;

  @override
  Widget build(BuildContext context) {
    final status = widget.order['status'] as String;
    final isDelivered = status == 'Delivered';
    final order = widget.order;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9EEEB)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.045),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // â”€â”€ Header gradient bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9F8),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Icon(Icons.receipt_long_rounded,
                    size: 16, color: AppColors.primary1),
                const SizedBox(width: 8),
                Text(
                  order['id'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.black1,
                  ),
                ),
                const Spacer(),
                _StatusChip(
                    status: status, colorKey: order['statusColor'] as String),
              ],
            ),
          ),

          // â”€â”€ Body â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                // Product image + details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        order['image'] as String,
                        width: 88,
                        height: 88,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: AppColors.white1,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.image_outlined,
                              color: AppColors.muteIconColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.shopping_bag_outlined,
                                  size: 13, color: AppColors.black2),
                              const SizedBox(width: 4),
                              Text(
                                '${order['items']} Items',
                                style: const TextStyle(
                                    color: AppColors.black2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Rs ${_formatAmount(order['total'])}',
                            style: const TextStyle(
                              color: AppColors.primary1,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                                  size: 12, color: AppColors.muteIconColor),
                              const SizedBox(width: 4),
                              Text(
                                order['date'] as String,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.muteIconColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Delivery status banner
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDelivered
                        ? AppColors.success.withOpacity(0.07)
                        : AppColors.info.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDelivered
                          ? AppColors.success.withOpacity(0.2)
                          : AppColors.info.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isDelivered
                            ? Icons.verified_rounded
                            : Icons.local_shipping_rounded,
                        color: isDelivered ? AppColors.success : AppColors.info,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isDelivered
                              ? 'Delivered successfully to your address'
                              : 'Shipment is on the way. Track for live updates.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDelivered
                                ? AppColors.success
                                : AppColors.info,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Collapsible tracking steps
                GestureDetector(
                  onTap: () =>
                      setState(() => _trackingExpanded = !_trackingExpanded),
                  child: Row(
                    children: [
                      Icon(Icons.timeline_rounded,
                          size: 14, color: AppColors.primary1),
                      const SizedBox(width: 6),
                      Text(
                        _trackingExpanded ? 'Hide Tracking' : 'Show Tracking',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary1,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 200),
                        turns: _trackingExpanded ? 0.5 : 0,
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            color: AppColors.primary1, size: 18),
                      ),
                    ],
                  ),
                ),

                AnimatedSize(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  child: _trackingExpanded
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              _trackStep('Order Placed', '28 Jul 2025', true),
                              _trackStep('Packed', '29 Jul 2025', true),
                              _trackStep('Shipped', '30 Jul 2025',
                                  status != 'Pending'),
                              _trackStep(
                                  'Delivered', '01 Aug 2025', isDelivered,
                                  isLast: true),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(height: 12),

                // Action buttons
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => widget.controller
                        .viewOrderDetails(order['id'] as String),
                    icon: const Icon(Icons.local_shipping_outlined, size: 16),
                    label: const Text(
                      'Track',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary1,
                      side: const BorderSide(color: AppColors.primary1),
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(dynamic value) {
    final amount = (value as num?)?.toDouble() ?? 0;
    return amount == amount.roundToDouble()
        ? amount.toStringAsFixed(0)
        : amount.toStringAsFixed(2);
  }

  Widget _trackStep(String title, String date, bool done,
      {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: done ? AppColors.success : AppColors.greyLight,
                shape: BoxShape.circle,
              ),
              child:
                  Icon(Icons.check_rounded, size: 12, color: AppColors.white),
            ),
            if (!isLast)
              Container(
                  width: 2,
                  height: 28,
                  color: done ? AppColors.success : AppColors.divider),
          ],
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              Text(date,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.muteIconColor)),
              SizedBox(height: isLast ? 0 : 10),
            ],
          ),
        ),
      ],
    );
  }
}

// â”€â”€â”€ Status Chip â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _StatusChip extends StatelessWidget {
  final String status;
  final String colorKey;

  const _StatusChip({required this.status, required this.colorKey});

  Color get _color {
    switch (colorKey.toLowerCase()) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withOpacity(0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: _color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// â”€â”€â”€ Summary Card â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
