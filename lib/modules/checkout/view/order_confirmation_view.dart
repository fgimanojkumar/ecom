import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/demo/demo_account_store.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/order_confirmation_controller.dart';

class OrderConfirmationView extends GetView<OrderConfirmationController> {
  const OrderConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Order Confirmation',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Obx(() {
          final order = controller.order.value;
          if (order == null) return _missingOrder();

          final items = controller.itemsFor(order);
          final address = controller.deliveryAddressFor(order);
          final total = controller.amountFor(order['total']);
          final subtotal = controller.amountFor(order['subtotal'] ?? total);
          final shipping = controller.amountFor(order['shipping']);
          final tax = controller.amountFor(order['tax']);
          final itemCount = items.fold<int>(0, (count, item) {
            final quantity = item['qty'];
            return count + (quantity is num ? quantity.toInt() : 1);
          });
          final customerName =
              (address?['name'] ?? DemoAccountStore.activeUser.value?['name'])
                      ?.toString() ??
                  'there';
          final date = controller.formattedDate(order['date']);
          final estimatedDelivery =
              controller.estimatedDeliveryFor(order['date']);
          final paymentMethod =
              controller.paymentMethodLabel(order['paymentMethod']);
          final isWide = MediaQuery.sizeOf(context).width >= 900;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, isWide ? 28 : 18, 16, 32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _successHeader(
                      customerName: customerName,
                      orderId: order['id']?.toString() ?? 'Order confirmed',
                      date: date,
                    ),
                    const SizedBox(height: 22),
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                _itemsSection(items, itemCount),
                                const SizedBox(height: 16),
                                _deliverySection(
                                  address: address,
                                  estimatedDelivery: estimatedDelivery,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                _paymentSection(
                                  paymentMethod: paymentMethod,
                                  date: date,
                                  subtotal: subtotal,
                                  shipping: shipping,
                                  tax: tax,
                                  total: total,
                                ),
                                const SizedBox(height: 16),
                                _customerMessage(),
                                const SizedBox(height: 12),
                                _invoiceDownloadMessage(),
                                const SizedBox(height: 20),
                                _actions(order['id']?.toString() ?? ''),
                              ],
                            ),
                          ),
                        ],
                      )
                    else ...[
                      _itemsSection(items, itemCount),
                      const SizedBox(height: 14),
                      _deliverySection(
                        address: address,
                        estimatedDelivery: estimatedDelivery,
                      ),
                      const SizedBox(height: 14),
                      _paymentSection(
                        paymentMethod: paymentMethod,
                        date: date,
                        subtotal: subtotal,
                        shipping: shipping,
                        tax: tax,
                        total: total,
                      ),
                      const SizedBox(height: 14),
                      _customerMessage(),
                      const SizedBox(height: 12),
                      _invoiceDownloadMessage(),
                      const SizedBox(height: 20),
                      _actions(order['id']?.toString() ?? ''),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _successHeader({
    required String customerName,
    required String orderId,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FAF5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8EFE1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THANK YOU, ${customerName.toUpperCase()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Your order is confirmed',
                  style: TextStyle(
                    color: AppColors.black1,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'We appreciate your order. Our team is preparing it with care, and we’ll keep you updated as it moves your way.',
                  style: TextStyle(
                    color: AppColors.black2,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 14,
                  runSpacing: 6,
                  children: [
                    _headerMeta(Icons.receipt_long_outlined, orderId),
                    _headerMeta(Icons.calendar_today_outlined, date),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemsSection(List<Map<String, dynamic>> items, int itemCount) {
    return _section(
      title: 'Items in your order',
      trailing: '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
      child: items.isEmpty
          ? const Text(
              'Your items are being prepared.',
              style: TextStyle(color: AppColors.black2, fontSize: 13),
            )
          : Column(
              children: [
                for (var index = 0; index < items.length; index++) ...[
                  if (index > 0) const Divider(height: 20),
                  _itemRow(items[index]),
                ],
              ],
            ),
    );
  }

  Widget _itemRow(Map<String, dynamic> item) {
    final quantity = item['qty'] is num ? (item['qty'] as num).toInt() : 1;
    final price = controller.amountFor(item['price']);
    final name = item['name']?.toString() ?? 'Order item';
    final image = item['image']?.toString() ?? '';

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 54,
            height: 54,
            child: image.startsWith('http')
                ? Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _itemPlaceholder(),
                  )
                : image.isNotEmpty
                    ? Image.asset(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _itemPlaceholder(),
                      )
                    : _itemPlaceholder(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.black1,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Qty $quantity',
                style: const TextStyle(
                  color: AppColors.black2,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          _money(price * quantity),
          style: const TextStyle(
            color: AppColors.black1,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _itemPlaceholder() {
    return Container(
      color: AppColors.white1,
      alignment: Alignment.center,
      child: const Icon(
        Icons.shopping_bag_outlined,
        color: AppColors.muteIconColor,
        size: 22,
      ),
    );
  }

  Widget _deliverySection({
    required Map<String, dynamic>? address,
    required String estimatedDelivery,
  }) {
    final addressLines =
        address == null ? '' : DemoAccountStore.formatAddress(address);

    return _section(
      title: 'Delivery details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailRow(
            Icons.local_shipping_outlined,
            'Estimated delivery',
            estimatedDelivery,
          ),
          const SizedBox(height: 14),
          _detailRow(
            Icons.location_on_outlined,
            address?['type']?.toString() ?? 'Shipping address',
            addressLines.isEmpty ? 'Address details unavailable' : addressLines,
          ),
          if (address?['name'] != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                address!['name'].toString(),
                style: const TextStyle(
                  color: AppColors.black2,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _paymentSection({
    required String paymentMethod,
    required String date,
    required double subtotal,
    required double shipping,
    required double tax,
    required double total,
  }) {
    return _section(
      title: 'Payment summary',
      child: Column(
        children: [
          _summaryRow('Payment method', paymentMethod),
          const SizedBox(height: 8),
          _summaryRow('Order date', date),
          const Divider(height: 24),
          _summaryRow('Subtotal', _money(subtotal)),
          const SizedBox(height: 8),
          _summaryRow('Delivery', shipping == 0 ? 'Free' : _money(shipping)),
          const SizedBox(height: 8),
          _summaryRow('Tax', _money(tax)),
          const Divider(height: 24),
          _summaryRow('Total paid', _money(total), emphasize: true),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1FAF5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.lock_outline_rounded,
                    color: AppColors.success, size: 16),
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    'Your payment is securely confirmed.',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
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

  Widget _customerMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8EE),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF5E7CF)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.favorite_border_rounded,
              color: AppColors.primary1, size: 19),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Your trust means a lot to us. We’re here to help if you need anything, and we hope you love your purchase.',
              style: TextStyle(
                color: AppColors.black2,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _invoiceDownloadMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white1,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white2),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            color: AppColors.primary1,
            size: 18,
          ),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Need your invoice later? Open My Orders, tap Track on this order, then choose Invoice.',
              style: TextStyle(
                color: AppColors.black2,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actions(String orderId) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () => Get.toNamed('/orderDetails', arguments: orderId),
            icon: const Icon(Icons.local_shipping_outlined, size: 18),
            label: const Text('Track your order'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary2,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            onPressed: () => Get.offAllNamed('/home'),
            icon: const Icon(Icons.storefront_outlined, size: 18),
            label: const Text('Continue shopping'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary2,
              side: const BorderSide(color: AppColors.primary2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _section({
    required String title,
    String? trailing,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.white2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.black1,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (trailing != null)
                Text(
                  trailing,
                  style: const TextStyle(
                    color: AppColors.black2,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary1, size: 19),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.black2,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.black1,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _summaryRow(String label, String value, {bool emphasize = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: emphasize ? AppColors.black1 : AppColors.black2,
              fontSize: emphasize ? 14 : 12,
              fontWeight: emphasize ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          textAlign: TextAlign.end,
          style: TextStyle(
            color: emphasize ? AppColors.primary2 : AppColors.black1,
            fontSize: emphasize ? 16 : 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _headerMeta(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.black2, size: 14),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.black2,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _money(double amount) => '₹${amount.toStringAsFixed(2)}';

  Widget _missingOrder() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              color: AppColors.muteIconColor,
              size: 42,
            ),
            const SizedBox(height: 12),
            const Text(
              'Order details are unavailable',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black1,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Get.offAllNamed('/home'),
              child: const Text('Continue shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
