import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../../modules/cart/controller/cart_controller.dart';
import '../../../shared/demo/demo_account_store.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/common_input_field.dart';
import '../../../shared/widgets/premium_app_bar.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final List<XFile> _reviewImages = [];
  bool _isSubmitting = false;
  static const int _maxImages = 5;

  Map<String, dynamic> get _selectedOrder {
    final orderId = Get.arguments?.toString();
    return DemoAccountStore.orders.firstWhere(
      (order) => order['id'] == orderId,
      orElse: () => DemoAccountStore.orders.first,
    );
  }

  List<Map<String, dynamic>> get _products =>
      (_selectedOrder['lines'] as List<Map<String, dynamic>>?) ?? [];

  void _reorder() {
    final cart = CartController.ensureInitialized();
    for (var index = 0; index < _products.length; index++) {
      final line = _products[index];
      final price = (line['price'] as num?)?.toDouble() ?? 0;
      cart.addMapProductToCart(
        {
          ...line,
          'id': line['id'] ?? '${_selectedOrder['id']}-$index',
          'originalPrice': line['originalPrice'] ?? price,
          'category': line['category'] ?? 'Reorder',
          'stock': 50,
        },
        quantity: (line['qty'] as num?)?.toInt() ?? 1,
      );
    }
    Get.toNamed('/cart');
  }

  Future<void> _shareInvoice() async {
    final order = _selectedOrder;
    final lines = _products
        .map((item) => '${item['name']}  x${item['qty']}  ₹${item['price']}')
        .join('\n');
    await Share.share(
      'Bhabsa demo invoice\nOrder: ${order['id']}\nDate: ${order['date']}\n$lines\nTotal: ₹${order['total']}',
      subject: 'Invoice ${order['id']}',
    );
  }

  void _requestReturn() {
    if (_selectedOrder['status'] != 'Delivered') {
      Get.snackbar(
          'Return unavailable', 'Returns can be requested after delivery.');
      return;
    }
    if (_selectedOrder['returnRequestStatus'] != null) {
      Get.toNamed('/returnStatus', arguments: _selectedOrder['id']);
      return;
    }
    setState(() => _selectedOrder['returnRequestStatus'] = 'Requested');
    Get.toNamed('/returnStatus', arguments: _selectedOrder['id']);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    if (_reviewImages.length >= _maxImages) {
      Get.snackbar(
        'Limit Reached',
        'You can add up to $_maxImages photos',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }
    try {
      final picker = ImagePicker();
      final images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        final remaining = _maxImages - _reviewImages.length;
        setState(() => _reviewImages.addAll(images.take(remaining)));
      }
    } catch (_) {}
  }

  void _removeImage(int index) => setState(() => _reviewImages.removeAt(index));

  Future<void> _submitReview() async {
    if (_rating == 0) {
      Get.snackbar(
        'Rating Required',
        'Please tap a star to rate your experience',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.warning_rounded, color: AppColors.white),
      );
      return;
    }
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _rating = 0;
      _reviewController.clear();
      _reviewImages.clear();
    });
    Get.snackbar(
      'Review Submitted!',
      'Thank you for your feedback',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.check_circle_rounded, color: AppColors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Order Details',
        showBackButton: true,
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            children: [
              _buildOrderOverview(),
              const SizedBox(height: 16),
              if (MediaQuery.sizeOf(context).width >= 900)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          _buildTracking(),
                          const SizedBox(height: 16),
                          _buildProducts(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _buildAddress(),
                          const SizedBox(height: 16),
                          _buildPayment(),
                          const SizedBox(height: 16),
                          _buildSummary(),
                          const SizedBox(height: 16),
                          _buildActions(),
                        ],
                      ),
                    ),
                  ],
                )
              else ...[
                _buildTracking(),
                const SizedBox(height: 16),
                _buildProducts(),
                const SizedBox(height: 16),
                _buildAddress(),
                const SizedBox(height: 16),
                _buildPayment(),
                const SizedBox(height: 16),
                _buildSummary(),
                const SizedBox(height: 16),
                _buildActions(),
              ],
              const SizedBox(height: 16),
              _buildReviewSection(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, 12 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _reorder,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reorder'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary1, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary1.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: _shareInvoice,
                icon: const Icon(Icons.download_rounded,
                    color: AppColors.white, size: 18),
                label: const Text('Invoice',
                    style: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderOverview() {
    final order = _selectedOrder;
    final status = order['status'] as String? ?? 'Processing';
    final statusColor = status == 'Delivered'
        ? AppColors.success
        : status == 'Cancelled' || status == 'Returned'
            ? AppColors.error
            : AppColors.info;
    final orderId = order['id'] as String? ?? 'Order';
    final date = order['date'] as String? ?? 'Date unavailable';
    final itemCount = order['items'] ?? _products.length;
    final total = (order['total'] as num?)?.toDouble() ?? 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECE9)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.045),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary1.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: AppColors.primary1,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ORDER NUMBER',
                      style: TextStyle(
                        color: AppColors.black2,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      orderId,
                      style: const TextStyle(
                        color: AppColors.black1,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
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
              Expanded(
                child: _overviewMetric(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Items',
                  value: '$itemCount',
                ),
              ),
              Expanded(
                child: _overviewMetric(
                  icon: Icons.payments_outlined,
                  label: 'Order total',
                  value: '₹${total.toStringAsFixed(2)}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: AppColors.muteIconColor,
                size: 14,
              ),
              const SizedBox(width: 7),
              Text(
                'Placed on $date',
                style: const TextStyle(
                  color: AppColors.black2,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewMetric({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary1, size: 17),
        const SizedBox(width: 7),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.black2, fontSize: 11),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.black1,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData titleIcon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.07),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary1.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(titleIcon, color: AppColors.primary1, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildTracking() {
    final status = _selectedOrder['status'] as String? ?? 'Processing';
    final orderDate = _selectedOrder['date'] as String? ?? '';
    final isShipped = status == 'In Transit' || status == 'Delivered';
    final isDelivered = status == 'Delivered';

    return _sectionCard(
      title: 'Order Tracking',
      titleIcon: Icons.local_shipping_rounded,
      child: Column(
        children: [
          _timelineStep('Order Placed', orderDate, true),
          _timelineStep('Processing', orderDate, true),
          _timelineStep('Shipped', orderDate, isShipped),
          _timelineStep('Delivered', orderDate, isDelivered, isLast: true),
        ],
      ),
    );
  }

  Widget _timelineStep(String title, String date, bool completed,
      {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: completed ? AppColors.success : AppColors.greyLight,
                shape: BoxShape.circle,
                boxShadow: completed
                    ? [
                        BoxShadow(
                          color: AppColors.success.withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : null,
              ),
              child: const Icon(Icons.check_rounded,
                  size: 15, color: AppColors.white),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 34,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.success.withOpacity(0.5),
                      AppColors.divider
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(date,
                    style: TextStyle(color: AppColors.black2, fontSize: 12)),
                SizedBox(height: isLast ? 0 : 14),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProducts() {
    return _sectionCard(
      title: 'Ordered Products',
      titleIcon: Icons.shopping_bag_rounded,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _products.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 24, color: Color(0xFFF0F0F0)),
        itemBuilder: (context, index) {
          final product = _products[index];
          final imagePath = product['image'] as String? ?? '';
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imagePath.startsWith('http')
                    ? Image.network(
                        imagePath,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        imagePath,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14)),
                    const SizedBox(height: 5),
                    Text('Qty: ${product["qty"]}',
                        style:
                            TextStyle(color: AppColors.black2, fontSize: 12)),
                    const SizedBox(height: 6),
                    Text(
                      '\u20b9${product["price"]}',
                      style: const TextStyle(
                          color: AppColors.primary2,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddress() {
    final addressId = _selectedOrder['addressId'];
    final deliveryAddress = DemoAccountStore.addresses.firstWhere(
      (item) => item['id'] == addressId,
      orElse: () => DemoAccountStore.addresses.first,
    );
    final billingAddress = DemoAccountStore.addresses.firstWhere(
      (item) => item['id'] == (_selectedOrder['billingAddressId'] ?? addressId),
      orElse: () => deliveryAddress,
    );

    return _sectionCard(
      title: 'Billing & Delivery Addresses',
      titleIcon: Icons.location_on_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _addressInfo('Delivery', deliveryAddress),
          const SizedBox(height: 16),
          _addressInfo('Billing', billingAddress),
        ],
      ),
    );
  }

  Widget _addressInfo(String label, Map<String, dynamic> address) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.primary1.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.home_rounded,
              color: AppColors.primary1, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 13)),
              const SizedBox(height: 4),
              Text(address['name'] as String,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 4),
              Text(
                DemoAccountStore.formatAddress(address),
                style: const TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 4),
              Text(
                '+91 ${address['phone']}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primary2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPayment() {
    final paymentMethod = _selectedOrder['paymentMethod'] as String? ?? 'Demo';

    return _sectionCard(
      title: 'Payment Details',
      titleIcon: Icons.payment_rounded,
      child: Column(
        children: [
          _paymentRow('Payment Method', paymentMethod,
              Icons.account_balance_wallet_rounded),
          const SizedBox(height: 12),
          _paymentRow('Payment Status', 'Paid', Icons.check_circle_rounded,
              valueColor: AppColors.success),
        ],
      ),
    );
  }

  Widget _paymentRow(String label, String value, IconData icon,
      {Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: valueColor ?? AppColors.muteIconColor),
        const SizedBox(width: 10),
        Expanded(
            child: Text(label,
                style: TextStyle(color: AppColors.black2, fontSize: 13))),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.black1,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    final subtotal = (_selectedOrder['subtotal'] as num?)?.toDouble() ??
        (_selectedOrder['total'] as num).toDouble();
    final shipping = (_selectedOrder['shipping'] as num?)?.toDouble() ?? 0;
    final tax = (_selectedOrder['tax'] as num?)?.toDouble() ?? 0;
    final total = (_selectedOrder['total'] as num).toDouble();

    return _sectionCard(
      title: 'Price Summary',
      titleIcon: Icons.receipt_long_rounded,
      child: Column(
        children: [
          SummaryRow('Subtotal', '₹${subtotal.toStringAsFixed(2)}'),
          SummaryRow('Shipping', '₹${shipping.toStringAsFixed(2)}'),
          SummaryRow('GST', '₹${tax.toStringAsFixed(2)}'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Divider(),
          ),
          SummaryRow('Total', '₹${total.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final hasReturnRequest = _selectedOrder['returnRequestStatus'] != null;
    final actions = [
      {'icon': Icons.download_rounded, 'label': 'Invoice'},
      {
        'icon': hasReturnRequest
            ? Icons.assignment_return_outlined
            : Icons.assignment_return_rounded,
        'label': hasReturnRequest ? 'Refund Status' : 'Return',
      },
      {'icon': Icons.support_agent_rounded, 'label': 'Support'},
    ];
    return _sectionCard(
      title: 'Quick Actions',
      titleIcon: Icons.flash_on_rounded,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: actions.length,
        itemBuilder: (_, i) {
          return OutlinedButton.icon(
            onPressed: () {
              switch (actions[i]['label']) {
                case 'Invoice':
                  _shareInvoice();
                case 'Return':
                  _requestReturn();
                case 'Refund Status':
                  Get.toNamed('/returnStatus', arguments: _selectedOrder['id']);
                case 'Support':
                  Get.toNamed('/support');
              }
            },
            icon: Icon(actions[i]['icon'] as IconData, size: 16),
            label: Text(actions[i]['label'] as String,
                style: const TextStyle(fontSize: 12)),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviewSection() {
    final ratingLabels = ['Terrible', 'Bad', 'Okay', 'Good', 'Excellent'];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary1.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gradient header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary1, AppColors.gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: const Row(
              children: [
                Icon(Icons.star_rounded, color: AppColors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Rate & Review',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Star row — uniform size prevents overflow when all 5 are filled
                Center(
                  child: FittedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        final filled = index < _rating;
                        return GestureDetector(
                          onTap: () => setState(() => _rating = index + 1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            child: Icon(
                              filled
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              color: filled
                                  ? AppColors.statusBtnYellow
                                  : AppColors.greyLight,
                              size: 42,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                // Rating label pill
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _rating > 0
                      ? Center(
                          key: ValueKey(_rating),
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary1.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ratingLabels[_rating - 1],
                              style: const TextStyle(
                                color: AppColors.primary1,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(height: 14, key: ValueKey(0)),
                ),

                const SizedBox(height: 18),

                // Review text field
                CommonInputField.field(
                  controller: _reviewController,
                  maxLines: 4,
                  maxLength: 500,
                  hintText: 'Share your experience with this order...',
                  fillColor: const Color(0xFFF6F8FA),
                  radius: 14,
                  contentPadding: const EdgeInsets.all(14),
                  showCounter: true,
                ),

                const SizedBox(height: 18),

                _buildPhotosSection(),

                const SizedBox(height: 22),

                _buildSubmitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Add Photos',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              '${_reviewImages.length}/$_maxImages',
              style: TextStyle(color: AppColors.muteIconColor, fontSize: 12),
            ),
            const Spacer(),
            if (_reviewImages.length < _maxImages)
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary1.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: AppColors.primary1.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.add_photo_alternate_rounded,
                          size: 15, color: AppColors.primary1),
                      SizedBox(width: 4),
                      Text('Add',
                          style: TextStyle(
                              color: AppColors.primary1,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (_reviewImages.isEmpty)
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FA),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFDDE1E7), width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_rounded,
                      size: 30, color: AppColors.primary1.withOpacity(0.55)),
                  const SizedBox(height: 6),
                  Text('Tap to add photos',
                      style: TextStyle(
                          color: AppColors.muteIconColor, fontSize: 12)),
                ],
              ),
            ),
          )
        else
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _reviewImages.length +
                  (_reviewImages.length < _maxImages ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                if (index == _reviewImages.length) {
                  return GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      width: 92,
                      decoration: BoxDecoration(
                        color: AppColors.primary1.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.primary1.withOpacity(0.25)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_rounded,
                              color: AppColors.primary1, size: 26),
                          SizedBox(height: 4),
                          Text('Add',
                              style: TextStyle(
                                  color: AppColors.primary1,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  );
                }

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: SizedBox(
                        width: 92,
                        height: 92,
                        child: _buildImagePreview(_reviewImages[index]),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close_rounded,
                              size: 13, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildImagePreview(XFile xFile) {
    if (kIsWeb) {
      return FutureBuilder<Uint8List>(
        future: xFile.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Image.memory(snapshot.data!, fit: BoxFit.cover);
          }
          return Container(
            color: AppColors.white1,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      );
    }
    return Image.file(File(xFile.path), fit: BoxFit.cover);
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _isSubmitting
            ? Container(
                key: const ValueKey('loading'),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary1, AppColors.gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: AppColors.white, strokeWidth: 2.5),
                  ),
                ),
              )
            : Container(
                key: const ValueKey('submit'),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary1, AppColors.gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary1.withOpacity(0.38),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _submitReview,
                    borderRadius: BorderRadius.circular(14),
                    splashColor: Colors.white.withOpacity(0.15),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.send_rounded,
                              color: AppColors.white, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Submit Review',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const SummaryRow(this.title, this.value, {super.key, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isTotal ? AppColors.black1 : AppColors.black2,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              fontSize: isTotal ? 15 : 13,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? AppColors.primary2 : AppColors.black,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
              fontSize: isTotal ? 17 : 13,
            ),
          ),
        ],
      ),
    );
  }
}
