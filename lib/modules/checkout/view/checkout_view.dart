import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

import '../../../shared/demo/demo_account_store.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/style/app_text_style.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Checkout',
        showBackButton: true,
      ),
      bottomNavigationBar: kIsWeb
          ? Container(
              height: 88 + MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                16 + MediaQuery.of(context).padding.bottom,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: AppColors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Obx(
                    () => SizedBox(
                      width: controller.activeStep.value > 0 ? 360 : 200,
                      child: Row(
                        children: [
                          if (controller.activeStep.value > 0) ...[
                            Expanded(
                              child: SizedBox(
                                height: 56,
                                child: OutlinedButton.icon(
                                  onPressed: controller.goToPreviousStep,
                                  icon: const Icon(Icons.arrow_back_rounded,
                                      size: 18),
                                  label: const Text('Back'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: SizedBox(
                              height: 56,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.primary1,
                                      AppColors.primary1
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary2.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: controller.activeStep.value == 3
                                      ? controller.initiatePayment
                                      : controller.continueToNextStep,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    controller.activeStep.value == 3
                                        ? 'PAY ₹${CartController.ensureInitialized().total.toStringAsFixed(2)}'
                                        : 'CONTINUE',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
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
            )
          : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = ResponsiveUtil.horizontalPadding(context);
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                16,
                horizontalPadding,
                16,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: ResponsiveUtil.maxContentWidth(context),
                  ),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// STEP INDICATOR
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                [
                                  'Address',
                                  'Payment',
                                  'Review',
                                  'Pay'
                                ][controller.activeStep.value],
                                style: const TextStyle(
                                  color: AppColors.primary1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'STEP ${controller.activeStep.value + 1} OF 4',
                                style: const TextStyle(
                                  color: AppColors.black2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: List.generate(
                                  4,
                                  (index) => Expanded(
                                    child: Container(
                                      height: 4,
                                      margin: EdgeInsets.only(
                                          right: index == 3 ? 0 : 6),
                                      decoration: BoxDecoration(
                                        color:
                                            index <= controller.activeStep.value
                                                ? AppColors.primary1
                                                : AppColors.white2,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        if (controller.activeStep.value == 0) ...[
                          /// ADDRESS HEADER
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Delivery Address',
                                      style:
                                          AppTextStyle.fs12Black600().copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Choose where to deliver',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.muteIconColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primary2
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Get.toNamed('/addNewAddress');
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 18,
                                      color: AppColors.primary2,
                                    ),
                                    label: const Text(
                                      'Add New',
                                      style:
                                          TextStyle(color: AppColors.primary2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          /// ADDRESS LIST
                          RadioGroup<String>(
                            groupValue: controller.selectedAddressId.value,
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedAddressId.value = value;
                              }
                            },
                            child: Column(
                              children: controller.addresses.map((address) {
                                final addressId =
                                    address['id'] as String? ?? '';
                                final isSelected =
                                    controller.selectedAddressId.value ==
                                        addressId;

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary2
                                          : AppColors.white2,
                                      width: isSelected ? 2 : 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color:
                                                  AppColors.primary2.withValues(
                                                alpha: 0.15,
                                              ),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : [
                                            BoxShadow(
                                              color: AppColors.black.withValues(
                                                alpha: 0.04,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                  ),
                                  child: RadioListTile<String>(
                                    value: addressId,
                                    activeColor: AppColors.primary2,
                                    title: Text(
                                      address['type'] ?? address['name'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        DemoAccountStore.formatAddress(address),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.black2,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(height: 8),
                          CheckboxListTile(
                            value:
                                controller.useDeliveryAddressForBilling.value,
                            onChanged: (value) => controller
                                .useDeliveryAddressForBilling
                                .value = value ?? true,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: AppColors.primary1,
                            title: const Text(
                              'Billing address same as delivery address',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ),
                          if (!controller
                              .useDeliveryAddressForBilling.value) ...[
                            const SizedBox(height: 8),
                            const Text(
                              'Select billing address',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(height: 10),
                            RadioGroup<String>(
                              groupValue:
                                  controller.selectedBillingAddressId.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedBillingAddressId.value =
                                      value;
                                }
                              },
                              child: Column(
                                children: controller.addresses.map((address) {
                                  final addressId =
                                      address['id'] as String? ?? '';
                                  return RadioListTile<String>(
                                    value: addressId,
                                    activeColor: AppColors.primary1,
                                    title: Text(
                                      address['type'] ?? address['name'] ?? '',
                                    ),
                                    subtitle: Text(
                                      DemoAccountStore.formatAddress(address),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],

                          const SizedBox(height: 26),

                          /// COUPON
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color:
                                    AppColors.success.withValues(alpha: 0.12),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.success.withValues(alpha: 0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.success
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.local_offer_rounded,
                                    color: AppColors.success,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Apply Coupon',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'Save more with discount code',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.greyLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.success
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.toNamed('/coupons');
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                    ),
                                    child: Text(
                                      'Select',
                                      style: TextStyle(
                                        color: AppColors.success,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 28),

                          /// ORDER SUMMARY
                          Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackHeading,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.black.withValues(alpha: 0.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _summaryRow(
                                  'Subtotal',
                                  '₹${CartController.ensureInitialized().subtotal.toStringAsFixed(2)}',
                                ),
                                if (CartController.ensureInitialized()
                                        .couponDiscount >
                                    0) ...[
                                  const SizedBox(height: 14),
                                  _summaryRow(
                                    'Coupon savings',
                                    '-₹${CartController.ensureInitialized().couponDiscount.toStringAsFixed(2)}',
                                  ),
                                ],
                                const SizedBox(height: 14),
                                _summaryRow(
                                  'Shipping',
                                  '₹${CartController.shippingCharge.toStringAsFixed(2)}',
                                ),
                                const SizedBox(height: 14),
                                _summaryRow(
                                  'Tax (18%)',
                                  '₹${CartController.ensureInitialized().tax.toStringAsFixed(2)}',
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Container(
                                    height: 1,
                                    color: AppColors.white2,
                                  ),
                                ),
                                _summaryRow(
                                  'Total',
                                  '₹${CartController.ensureInitialized().total.toStringAsFixed(2)}',
                                  isTotal: true,
                                ),
                              ],
                            ),
                          ),
                        ],

                        if (controller.activeStep.value == 1)
                          _buildPaymentStage(),
                        if (controller.activeStep.value == 2)
                          _buildReviewStage(),
                        if (controller.activeStep.value == 3)
                          _buildDirectPaymentStage(),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPaymentStage() {
    return _stagePanel(
      title: 'Payment method',
      subtitle: 'Choose how you would like to pay.',
      child: Column(
        children: [
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
                final selected = controller.selectedPaymentMethod.value == id;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected ? AppColors.primary1 : AppColors.white2,
                      width: selected ? 1.5 : 1,
                    ),
                  ),
                  child: RadioListTile<String>(
                    value: id,
                    activeColor: AppColors.primary1,
                    title: Text(
                      method['name']!,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    secondary: Icon(_paymentIcon(method['icon']!)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStage() {
    final cart = CartController.ensureInitialized();
    final delivery = controller.addresses.firstWhereOrNull(
      (address) => address['id'] == controller.selectedAddressId.value,
    );
    final billing = controller.useDeliveryAddressForBilling.value
        ? delivery
        : controller.addresses.firstWhereOrNull(
            (address) =>
                address['id'] == controller.selectedBillingAddressId.value,
          );

    return Column(
      children: [
        _stagePanel(
          title: 'Review your order',
          subtitle: 'Check the items and addresses before paying.',
          child: Column(
            children: [
              ...cart.cartItems.map(
                (item) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: Text(item.product.name),
                  subtitle: Text('Qty ${item.quantity}'),
                  trailing: Text(
                    '₹${item.subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const Divider(height: 24),
              _reviewAddress('Delivery address', delivery),
              const SizedBox(height: 14),
              _reviewAddress('Billing address', billing),
              const SizedBox(height: 14),
              _summaryRow('Payment method', _selectedPaymentName()),
              const Divider(height: 24),
              _summaryRow('Subtotal', '₹${cart.subtotal.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              if (cart.couponDiscount > 0) ...[
                _summaryRow(
                  'Savings',
                  '-₹${cart.couponDiscount.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 8),
              ],
              _summaryRow('Tax', '₹${cart.tax.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              _summaryRow(
                'Shipping',
                '₹${CartController.shippingCharge.toStringAsFixed(2)}',
              ),
              const Divider(height: 24),
              _summaryRow(
                'Total',
                '₹${cart.total.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDirectPaymentStage() {
    return _stagePanel(
      title: 'Ready to pay',
      subtitle: 'Your secure payment will use the selected method.',
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF6FBF8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_rounded, color: AppColors.success),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Pay with ${_selectedPaymentName()}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  '₹${CartController.ensureInitialized().total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.primary1,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.wifi_rounded, color: AppColors.info, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Keep your internet connection stable during payment. Do not refresh or close this page until payment is complete.',
                    style: TextStyle(
                      color: AppColors.black2,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tap the payment button below to place your order and continue to the demo payment confirmation.',
            style: TextStyle(color: AppColors.black2, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _stagePanel({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.white2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text(subtitle, style: const TextStyle(color: AppColors.black2)),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _reviewAddress(String title, Map<String, dynamic>? address) {
    final details = address == null
        ? 'No address selected'
        : '${address['name'] ?? address['type']}, ${DemoAccountStore.formatAddress(address)}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(details,
            style: const TextStyle(color: AppColors.black2, height: 1.4)),
      ],
    );
  }

  String _selectedPaymentName() =>
      controller.paymentMethods.firstWhereOrNull(
        (method) => method['id'] == controller.selectedPaymentMethod.value,
      )?['name'] ??
      'Payment';

  IconData _paymentIcon(String icon) {
    switch (icon) {
      case 'credit_card':
        return Icons.credit_card_rounded;
      case 'phone_android':
        return Icons.phone_android_rounded;
      case 'account_balance_wallet':
        return Icons.account_balance_wallet_outlined;
      default:
        return Icons.payment_rounded;
    }
  }

  Widget _summaryRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 15 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? AppColors.blackHeading : AppColors.black2,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? AppColors.primary2 : AppColors.blackHeading,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
      ],
    );
  }
}
