import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
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

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Premium Smart Watch',
      'image':
          'https://www.equinetmedia.com/hubfs/How-to-find-b2b-blog-images.png',
      'qty': 1,
      'price': 4999,
    },
    {
      'name': 'Wireless Earbuds Pro',
      'image':
          'https://www.equinetmedia.com/hubfs/How-to-find-b2b-blog-images.png',
      'qty': 2,
      'price': 2499,
    },
  ];

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
              _buildOrderStatus(),
              const SizedBox(height: 16),
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
              onPressed: () {},
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
                onPressed: () {},
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

  Widget _buildOrderStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.primary1, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary1.withOpacity(0.38),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColors.primary1.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        children: [
          Icon(Icons.check_circle_rounded, color: AppColors.white, size: 58),
          SizedBox(height: 10),
          Text(
            'Delivered Successfully',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2),
          ),
          SizedBox(height: 4),
          Text(
            'Order #ORD-20250728',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
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
    return _sectionCard(
      title: 'Order Tracking',
      titleIcon: Icons.local_shipping_rounded,
      child: Column(
        children: [
          _timelineStep('Order Placed', '28 Jul 2025', true),
          _timelineStep('Packed', '29 Jul 2025', true),
          _timelineStep('Shipped', '30 Jul 2025', true),
          _timelineStep('Delivered', '01 Aug 2025', true, isLast: true),
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
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product['image'],
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
    return _sectionCard(
      title: 'Delivery Address',
      titleIcon: Icons.location_on_rounded,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary1.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.home_rounded,
                color: AppColors.primary1, size: 22),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Manoj Kumar',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                SizedBox(height: 4),
                Text('Thane, Maharashtra - 400601',
                    style: TextStyle(fontSize: 13)),
                Text('India', style: TextStyle(fontSize: 13)),
                SizedBox(height: 5),
                Text('+91 9876543210',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primary2,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayment() {
    return _sectionCard(
      title: 'Payment Details',
      titleIcon: Icons.payment_rounded,
      child: Column(
        children: [
          _paymentRow(
              'Payment Method', 'UPI', Icons.account_balance_wallet_rounded),
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
    return _sectionCard(
      title: 'Price Summary',
      titleIcon: Icons.receipt_long_rounded,
      child: const Column(
        children: [
          SummaryRow('Subtotal', '\u20b99,997'),
          SummaryRow('Shipping', '\u20b950'),
          SummaryRow('GST', '\u20b91,800'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Divider(),
          ),
          SummaryRow('Total', '\u20b911,847', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final actions = [
      {'icon': Icons.location_on_rounded, 'label': 'Track Order'},
      {'icon': Icons.download_rounded, 'label': 'Invoice'},
      {'icon': Icons.assignment_return_rounded, 'label': 'Return'},
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
            onPressed: () {},
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
                TextField(
                  controller: _reviewController,
                  maxLines: 4,
                  maxLength: 500,
                  decoration: InputDecoration(
                    hintText: 'Share your experience with this order...',
                    hintStyle:
                        TextStyle(color: AppColors.muteIconColor, fontSize: 13),
                    filled: true,
                    fillColor: const Color(0xFFF6F8FA),
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                          color: AppColors.primary1, width: 1.5),
                    ),
                    counterStyle:
                        TextStyle(color: AppColors.muteIconColor, fontSize: 11),
                  ),
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
