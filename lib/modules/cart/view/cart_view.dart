import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/common_input_field.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../../coupon/controller/coupon_controller.dart';
import '../../wishlist/controller/wishlist_controller.dart';
import '../controller/cart_controller.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController controller = CartController.ensureInitialized();
  final TextEditingController _couponInputController = TextEditingController();

  @override
  void dispose() {
    _couponInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWideWeb = kIsWeb && MediaQuery.sizeOf(context).width >= 1024;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PremiumAppBar(
        title: 'My Cart',
        showBackButton: true,
        actions: [
          Obx(() => controller.cartItems.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${controller.itemCount} items',
                    style: const TextStyle(
                      color: AppColors.primary1,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Obx(() {
          if (controller.cartItems.isEmpty) {
            return _buildEmptyCart();
          }
          if (isWideWeb) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'Items (${controller.itemCount})',
                          style: const TextStyle(
                            color: AppColors.black1,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
                          child: _buildCartItems(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(8, 16, 16, 24),
                    child: Column(
                      children: [
                        _buildCouponRow(),
                        const SizedBox(height: 14),
                        _buildOrderSummary(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    children: [
                      _buildCartItems(),
                      const SizedBox(height: 14),
                      _buildCouponRow(),
                      const SizedBox(height: 14),
                      _buildOrderSummary(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(() => controller.cartItems.isEmpty
          ? const SizedBox()
          : _buildCheckoutBar(context)),
    );
  }

  Widget _buildCartItems() {
    return Column(
      children: List.generate(controller.cartItems.length, (index) {
        final item = controller.cartItems[index];
        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => controller.removeFromCart(item.id),
          background: Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete_rounded, color: Colors.white, size: 26),
                SizedBox(height: 4),
                Text(
                  'Remove',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          child: _CartItemCard(
            item: item,
            onRemove: () => controller.removeFromCart(item.id),
            onDecrement: () {
              if (item.quantity > 1) {
                controller.updateQuantity(item.id, item.quantity - 1);
              }
            },
            onIncrement: () =>
                controller.updateQuantity(item.id, item.quantity + 1),
          ),
        );
      }),
    );
  }

  // â”€â”€â”€ Empty State â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary1.withOpacity(0.08),
                    AppColors.gradientEnd.withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shopping_cart_outlined,
                  size: 54, color: AppColors.primary1),
            ),
            const SizedBox(height: 24),
            const Text('Your Cart is Empty',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black1)),
            const SizedBox(height: 10),
            const Text("You haven't added any products yet.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.black2, fontSize: 14)),
            const SizedBox(height: 28),
            Container(
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
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_rounded,
                    color: AppColors.white, size: 18),
                label: const Text('Continue Shopping',
                    style: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // â”€â”€â”€ Coupon Row â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Widget _buildCouponRow() {
    final couponController = CouponController.ensureInitialized();
    final hasApplied = couponController.appliedCouponCode.value.isNotEmpty;
    final couponCode = couponController.appliedCouponCode.value;

    if (hasApplied && _couponInputController.text != couponCode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _couponInputController.value = TextEditingValue(
          text: couponCode,
          selection: TextSelection.collapsed(offset: couponCode.length),
        );
      });
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 12,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary1.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.local_offer_rounded,
                    color: AppColors.primary1, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hasApplied ? 'Coupon Applied' : 'Apply Coupon',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: hasApplied ? AppColors.success : AppColors.black1,
                  ),
                ),
              ),
              if (hasApplied)
                TextButton(
                  onPressed: () {
                    couponController.removeCoupon();
                    _couponInputController.clear();
                  },
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          if (hasApplied) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 42),
              child: Text(
                '${couponController.detailsFor(couponCode)?['description'] ?? couponCode} · ${couponController.detailsFor(couponCode)?['unlock'] ?? 'Discount applied to your order'}',
                style: const TextStyle(
                  color: AppColors.black2,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CommonInputField.field(
                  controller: _couponInputController,
                  hintText: 'Enter coupon code',
                  fillColor: AppColors.white1,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  final code = _couponInputController.text.trim();
                  if (code.isEmpty) {
                    Get.snackbar('Coupon', 'Enter a coupon code first');
                    return;
                  }
                  couponController.applyCoupon(
                    code,
                    cartSubtotal: controller.subtotal,
                    cartCategories: controller.cartItems
                        .map((item) => item.product.category)
                        .toSet(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary1,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // â”€â”€â”€ Order Summary â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Widget _buildOrderSummary() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary1.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
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
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
                Icon(Icons.receipt_long_rounded,
                    color: AppColors.white, size: 18),
                SizedBox(width: 8),
                Text('Order Summary',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                _summaryRow(
                    'Sub Total', '₹${controller.subtotal.toStringAsFixed(2)}'),
                const SizedBox(height: 10),
                Builder(builder: (_) {
                  if (!Get.isRegistered<CouponController>()) {
                    return const SizedBox.shrink();
                  }
                  final cc = Get.find<CouponController>();
                  final code = cc.appliedCouponCode.value;
                  if (code.isEmpty) return const SizedBox.shrink();
                  final discount = controller.couponDiscount;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.local_offer_rounded,
                                size: 14, color: AppColors.success),
                            const SizedBox(width: 6),
                            Text(code,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Text(
                          '-₹${discount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.success),
                        ),
                      ],
                    ),
                  );
                }),
                Builder(builder: (_) {
                  final savings = controller.totalSavings;
                  if (savings <= 0) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _summaryRow(
                      'Total Savings',
                      '₹${savings.toStringAsFixed(2)}',
                      accent: true,
                    ),
                  );
                }),
                _summaryRow(
                  'Tax (${(CartController.taxRate * 100).toStringAsFixed(0)}%)',
                  '₹${controller.tax.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 10),
                _summaryRow(
                  'Shipping',
                  '₹${CartController.shippingCharge.toStringAsFixed(2)}',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black1)),
                    Text(
                      '₹${controller.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool accent = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: 13,
              color: accent ? AppColors.success : AppColors.black2,
              fontWeight: accent ? FontWeight.w700 : FontWeight.w400,
            )),
        Text(value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: accent ? AppColors.success : AppColors.black1,
            )),
      ],
    );
  }

  // â”€â”€â”€ Checkout Bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Widget _buildCheckoutBar(BuildContext context) {
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
          // Total pill
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total',
                  style: TextStyle(
                      fontSize: 11,
                      color: AppColors.black2,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(
                '₹${controller.total.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary1),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary1, AppColors.gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary1.withOpacity(0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Get.toNamed('/checkout'),
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.white.withOpacity(0.15),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Proceed to Checkout',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15)),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward_rounded,
                            color: AppColors.white, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// â”€â”€â”€ Cart Item Card â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _CartItemCard extends StatelessWidget {
  final dynamic item;
  final VoidCallback onRemove;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _CartItemCard({
    required this.item,
    required this.onRemove,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = item.product.originalPrice > item.product.price;
    final image = item.product.image as String;
    final wishlist = WishlistController.ensureInitialized();
    final wishlistProduct = <String, dynamic>{
      'id': item.product.id,
      'name': item.product.name,
      'image': image,
      'price': item.product.price,
      'originalPrice': item.product.originalPrice,
      'rating': item.product.rating,
      'reviewCount': item.product.reviewCount,
      'category': item.product.category,
      'stock': item.product.stock,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: AppColors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // â”€â”€ Product Image â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: image.startsWith('http')
                  ? Image.network(
                      image,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _cartImageFallback(),
                    )
                  : image.startsWith('resources/')
                      ? Image.asset(
                          image,
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _cartImageFallback(),
                        )
                      : Container(
                          width: 96,
                          height: 96,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8EE),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: image.isEmpty
                              ? const Icon(
                                  Icons.image_outlined,
                                  color: AppColors.muteIconColor,
                                  size: 28,
                                )
                              : Text(
                                  image,
                                  style: const TextStyle(fontSize: 38),
                                ),
                        ),
            ),

            const SizedBox(width: 14),

            // â”€â”€ Product Details â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Delete
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black1,
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: onRemove,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.close_rounded,
                              size: 14, color: AppColors.error),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Category chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary1.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.product.category,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary1),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Price row
                  Row(
                    children: [
                      Text(
                        '₹${item.product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary1,
                        ),
                      ),
                      if (hasDiscount) ...[
                        const SizedBox(width: 8),
                        Text(
                          '₹${item.product.originalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.muteIconColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Wishlist + Qty row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Wishlist
                      Obx(() {
                        final isSaved = wishlist.isWishlisted(item.product.id);
                        return GestureDetector(
                          onTap: () => wishlist.toggleProduct(wishlistProduct),
                          child: Row(
                            children: [
                              Icon(
                                isSaved
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 14,
                                color: AppColors.error.withOpacity(0.7),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isSaved ? 'Saved' : 'Wishlist',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.black2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      // Quantity stepper
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary1.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.primary1.withOpacity(0.15)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _qtyBtn(
                                icon: Icons.remove_rounded, onTap: onDecrement),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 180),
                              transitionBuilder: (child, animation) =>
                                  SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.4),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: FadeTransition(
                                    opacity: animation, child: child),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '${item.quantity}',
                                  key: ValueKey(item.quantity),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black1,
                                  ),
                                ),
                              ),
                            ),
                            _qtyBtn(
                                icon: Icons.add_rounded, onTap: onIncrement),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartImageFallback() {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.white1,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(
        Icons.image_outlined,
        color: AppColors.muteIconColor,
        size: 28,
      ),
    );
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        child: Icon(icon, size: 16, color: AppColors.primary1),
      ),
    );
  }
}
