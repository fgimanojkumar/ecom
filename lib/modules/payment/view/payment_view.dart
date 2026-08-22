import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/utils/responsive_util.dart';
import 'package:imoss/shared/widgets/premium_app_bar.dart';
import '../controller/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    // Color Palette
    const Color primaryDark = AppColors.primary1;
    const Color primaryText = AppColors.black1;
    const Color secondaryText = AppColors.muteIconColor;
    const Color white = AppColors.white;
    const Color borderColor = AppColors.white2;
    const Color lightGrey = AppColors.white1;

    final RxString selectedPayment = 'mastercard'.obs;

    return Scaffold(
      backgroundColor: white,
      appBar: const PremiumAppBar(
        title: 'Payment Method',
        showBackButton: true,
      ),
      body: Container(
        color: AppColors.white,
        child: SafeArea(
          child: ResponsiveContent(
            addHorizontalPadding: true,
            child: Column(
              children: [
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Payment Methods Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Payment Methods',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: primaryText,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Mastercard Option
                              Obx(
                                () => GestureDetector(
                                  onTap: () =>
                                      selectedPayment.value = 'mastercard',
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedPayment.value == 'mastercard'
                                              ? AppColors.body
                                              : white,
                                      border: Border.all(
                                        color: selectedPayment.value ==
                                                'mastercard'
                                            ? primaryDark
                                            : borderColor,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: lightGrey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '💳',
                                              style: TextStyle(fontSize: 24),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        const Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Master Card',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryText,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                '•••••• 9977',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: secondaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: selectedPayment.value ==
                                                      'mastercard'
                                                  ? primaryDark
                                                  : borderColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: selectedPayment.value ==
                                                  'mastercard'
                                              ? Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: primaryDark,
                                                  ),
                                                  margin:
                                                      const EdgeInsets.all(4),
                                                )
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              // PayPal Option
                              Obx(
                                () => GestureDetector(
                                  onTap: () => selectedPayment.value = 'paypal',
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: selectedPayment.value == 'paypal'
                                          ? AppColors.body
                                          : white,
                                      border: Border.all(
                                        color: selectedPayment.value == 'paypal'
                                            ? primaryDark
                                            : borderColor,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: lightGrey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '🅿️',
                                              style: TextStyle(fontSize: 24),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        const Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'PayPal',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryText,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'em***@gmail.com',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: secondaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: selectedPayment.value ==
                                                      'paypal'
                                                  ? primaryDark
                                                  : borderColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: selectedPayment.value ==
                                                  'paypal'
                                              ? Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: primaryDark,
                                                  ),
                                                  margin:
                                                      const EdgeInsets.all(4),
                                                )
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Apple Pay Option
                              Obx(
                                () => GestureDetector(
                                  onTap: () =>
                                      selectedPayment.value = 'applepay',
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: selectedPayment.value == 'applepay'
                                          ? AppColors.body
                                          : white,
                                      border: Border.all(
                                        color:
                                            selectedPayment.value == 'applepay'
                                                ? primaryDark
                                                : borderColor,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: lightGrey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '🍎',
                                              style: TextStyle(fontSize: 24),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        const Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Apple Pay',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryText,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Connected to iCloud',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: secondaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: selectedPayment.value ==
                                                      'applepay'
                                                  ? primaryDark
                                                  : borderColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: selectedPayment.value ==
                                                  'applepay'
                                              ? Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: primaryDark,
                                                  ),
                                                  margin:
                                                      const EdgeInsets.all(4),
                                                )
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Add Payment Method Button
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.add, size: 20),
                                label: const Text('Add Payment Method'),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  side: const BorderSide(
                                      color: primaryDark, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Delivery Address Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Delivery Address',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: primaryText,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: lightGrey,
                                  border:
                                      Border.all(color: borderColor, width: 1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: borderColor, width: 1),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.location_on,
                                            color: primaryDark, size: 24),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Royal Ln. Mesa',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryText,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Royal Ln. Mesa, Jersey 45463',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: secondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: borderColor, width: 2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Order Summary Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Order Summary',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: primaryText,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Sub Total
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sub Total',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: secondaryText,
                                    ),
                                  ),
                                  Text(
                                    '\$418.00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryText,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Promo Code
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Promo-code',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: secondaryText,
                                    ),
                                  ),
                                  Text(
                                    '-\$10.00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Shipping
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: secondaryText,
                                    ),
                                  ),
                                  Text(
                                    '\$8.00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryText,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                height: 1,
                                color: borderColor,
                              ),
                              const SizedBox(height: 16),
                              // Final Total
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: primaryText,
                                    ),
                                  ),
                                  Text(
                                    '\$416.00',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: primaryDark,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Pay Now Button
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.white1, AppColors.white1],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Obx(
          () => SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: controller.isProcessing.value
                  ? null
                  : () => controller.initRazorpay(41600, 'ORD-001'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryDark,
                elevation: 4,
                shadowColor: primaryDark.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: controller.isProcessing.value
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Pay Now',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: white,
                        fontSize: 16,
                        letterSpacing: -0.2,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
