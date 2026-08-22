import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/style/app_text_style.dart';
import '../../../shared/utils/responsive_util.dart';

class OrderConfirmationView extends StatelessWidget {
  const OrderConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveContent(
          addHorizontalPadding: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: 30),
              // Success Message
              Text(
                'Order Confirmed!',
                style: AppTextStyle.headingH1('H1').copyWith(fontSize: 32),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Your order has been placed successfully. You will receive an order confirmation email soon.',
                  style: AppTextStyle.cardTitleStyle().copyWith(
                    color: AppColors.black2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              // Order Details
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white1,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order ID', style: AppTextStyle.mutedTextLabel()),
                        Text('ORD-123456',
                            style: AppTextStyle.cardTitleStyle()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estimated Delivery',
                            style: AppTextStyle.mutedTextLabel()),
                        Text('5-7 Days', style: AppTextStyle.cardTitleStyle()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Amount',
                            style: AppTextStyle.mutedTextLabel()),
                        Text('₹5,950',
                            style: AppTextStyle.cardTitleStyle().copyWith(
                              color: AppColors.primary2,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Action Buttons
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Get.offNamed('/myOrders'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Track Order',
                          style: AppTextStyle.cardTitleStyle().copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Get.offNamed('/home'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Continue Shopping',
                          style: AppTextStyle.cardTitleStyle().copyWith(
                            color: AppColors.primary2,
                          ),
                        ),
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
