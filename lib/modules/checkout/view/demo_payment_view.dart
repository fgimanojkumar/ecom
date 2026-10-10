import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/checkout_controller.dart';

class DemoPaymentView extends GetView<CheckoutController> {
  const DemoPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartController.ensureInitialized();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Demo Payment',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Obx(
              () => ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.warning.withValues(alpha: 0.25),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline_rounded,
                            color: AppColors.warning),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Demo only. No real payment will be collected. Connect a payment gateway and server-side verification before production.',
                            style: TextStyle(
                              color: AppColors.black1,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Select a payment method',
                    style: TextStyle(
                      color: AppColors.black1,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  RadioGroup<String>(
                    groupValue: controller.selectedPaymentMethod.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedPaymentMethod.value = value;
                      }
                    },
                    child: Column(
                      children: controller.paymentMethods.map((method) {
                        final id = method['id']!;
                        final selected =
                            controller.selectedPaymentMethod.value == id;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected
                                  ? AppColors.primary1
                                  : AppColors.white2,
                              width: selected ? 1.5 : 1,
                            ),
                          ),
                          child: RadioListTile<String>(
                            value: id,
                            activeColor: AppColors.primary1,
                            title: Text(
                              method['name']!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.white1,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order total'),
                        Text(
                          '₹${cart.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.primary1,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: controller.initiatePayment,
                      icon: const Icon(Icons.lock_outline_rounded),
                      label: const Text('Complete demo order'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary1,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
