import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt rating = 0.obs;

    final List<Map<String, dynamic>> products = [
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

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Order Details',
        showBackButton: true,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: AppColors.black.withOpacity(0.12),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
                label: const Text('Reorder'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.download,
                  color: AppColors.white,
                ),
                label: const Text(
                  'Invoice',
                  style: TextStyle(color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary2,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// ORDER STATUS
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.statusBtnGreen,
                      AppColors.statusBtnGreen,
                    ],
                  ),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.white,
                      size: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Delivered Successfully',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Order #ORD-20250728',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// TRACKING
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Tracking',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _timelineStep(
                      'Order Placed',
                      '28 Jul 2025',
                      true,
                    ),
                    _timelineStep(
                      'Packed',
                      '29 Jul 2025',
                      true,
                    ),
                    _timelineStep(
                      'Shipped',
                      '30 Jul 2025',
                      true,
                    ),
                    _timelineStep(
                      'Delivered',
                      '01 Aug 2025',
                      true,
                      isLast: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// PRODUCTS
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ordered Products',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                // product["image"],
                                'https://www.equinetmedia.com/hubfs/How-to-find-b2b-blog-images.png',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Quantity : ${product["qty"]}",
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "₹${product["price"]}",
                                    style: const TextStyle(
                                      color: AppColors.primary2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// ADDRESS
              _sectionCard(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Manoj Kumar'),
                    Text('Thane, Maharashtra'),
                    Text('400601'),
                    Text('India'),
                    Text('+91 9876543210'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// PAYMENT
              _sectionCard(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment Method'),
                        Text('UPI'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment Status'),
                        Text(
                          'Paid',
                          style: TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// SUMMARY
              _sectionCard(
                child: const Column(
                  children: [
                    SummaryRow(
                      'Subtotal',
                      '₹9,997',
                    ),
                    SummaryRow(
                      'Shipping',
                      '₹50',
                    ),
                    SummaryRow(
                      'GST',
                      '₹1,800',
                    ),
                    Divider(),
                    SummaryRow(
                      'Total',
                      '₹11,847',
                      isTotal: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// ACTIONS
              _sectionCard(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _actionButton(
                      Icons.location_on,
                      'Track Order',
                    ),
                    _actionButton(
                      Icons.download,
                      'Invoice',
                    ),
                    _actionButton(
                      Icons.assignment_return,
                      'Return',
                    ),
                    _actionButton(
                      Icons.support_agent,
                      'Support',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// REVIEW
              _sectionCard(
                child: Column(
                  children: [
                    const Text(
                      'Rate & Review',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => GestureDetector(
                            onTap: () {
                              rating.value = index + 1;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                index < rating.value
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                color: AppColors.statusBtnYellow,
                                size: 38,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Write your review...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.image),
                      label: const Text('Add Photos'),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.snackbar(
                            'Success',
                            'Review Submitted',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary2,
                        ),
                        child: const Text(
                          'Submit Review',
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _sectionCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.03),
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }

  static Widget _actionButton(
    IconData icon,
    String title,
  ) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(title),
    );
  }

  static Widget _timelineStep(
    String title,
    String date,
    bool completed, {
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor:
                  completed ? AppColors.success : AppColors.greyLight,
              child: const Icon(
                Icons.check,
                size: 12,
                color: AppColors.white,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: AppColors.divider,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: AppColors.black2,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const SummaryRow(
    this.title,
    this.value, {
    super.key,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? AppColors.primary2 : AppColors.black,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
