import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../../coupon/controller/coupon_controller.dart';
import '../controller/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color secondaryText = AppColors.black2;
    const Color lightBorder = AppColors.white2;
    const Color chipBackground = AppColors.white1;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'My Cart',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Obx(() {
          if (controller.cartItems.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.08),
                            blurRadius: 15,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 80,
                        color: AppColors.primary1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your Cart is Empty',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Looks like you haven't added any products yet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary1,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Cart Items
                        ...List.generate(
                          controller.cartItems.length,
                          (index) {
                            final item = controller.cartItems[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.06),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Top row with three-dot menu
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.product.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.black1,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Text(
                                                    'Premium Collection',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: secondaryText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                              icon: const Icon(Icons.more_vert,
                                                  color: secondaryText,
                                                  size: 20),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        // Image and details row
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: Image.network(
                                                item.product.image,
                                                width: 90,
                                                height: 90,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    width: 90,
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                      color: chipBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                    ),
                                                    child: const Icon(
                                                      Icons.image,
                                                      color: secondaryText,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 14),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Category chip
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: chipBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Text(
                                                      'Women',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.primary1,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  // Price
                                                  Text(
                                                    '\$${item.product.price}',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.primary1,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'In Stock',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.success,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 14),
                                        // Divider
                                        Container(
                                          height: 1,
                                          color: lightBorder,
                                        ),
                                        const SizedBox(height: 12),
                                        // Bottom action and quantity
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Save to Wishlist
                                            TextButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.favorite_outline,
                                                size: 16,
                                                color: secondaryText,
                                              ),
                                              label: const Text(
                                                'Save to Wishlist',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: secondaryText,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            // Quantity controls
                                            Row(
                                              children: [
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                      const BoxConstraints(),
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: AppColors.error,
                                                    size: 18,
                                                  ),
                                                  onPressed: () {
                                                    controller.removeFromCart(
                                                        item.id);
                                                  },
                                                ),
                                                const SizedBox(width: 12),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: chipBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        constraints:
                                                            const BoxConstraints(
                                                          minWidth: 28,
                                                          minHeight: 28,
                                                        ),
                                                        icon: const Icon(
                                                          Icons.remove,
                                                          size: 16,
                                                          color: AppColors
                                                              .primary1,
                                                        ),
                                                        onPressed: () {
                                                          if (item.quantity >
                                                              1) {
                                                            controller
                                                                .updateQuantity(
                                                              item.id,
                                                              item.quantity - 1,
                                                            );
                                                          }
                                                        },
                                                      ),
                                                      Text(
                                                        '${item.quantity}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              AppColors.black1,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        constraints:
                                                            const BoxConstraints(
                                                          minWidth: 28,
                                                          minHeight: 28,
                                                        ),
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 16,
                                                          color: AppColors
                                                              .primary1,
                                                        ),
                                                        onPressed: () {
                                                          controller
                                                              .updateQuantity(
                                                            item.id,
                                                            item.quantity + 1,
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        // Order Summary
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
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
                                  color: AppColors.black1,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Summary rows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Sub Total',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: secondaryText,
                                    ),
                                  ),
                                  Text(
                                    '\$${controller.total.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Dynamic coupon discount row
                              Obx(() {
                                if (!Get.isRegistered<CouponController>()) {
                                  return const SizedBox.shrink();
                                }
                                final cc = Get.find<CouponController>();
                                final code = cc.appliedCouponCode.value;
                                if (code.isEmpty)
                                  return const SizedBox.shrink();
                                final discount = controller.couponDiscount;
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Coupon: $code',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: secondaryText,
                                          ),
                                        ),
                                        Text(
                                          '-\$${discount.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.success,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                );
                              }),
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
                                      color: AppColors.black1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                height: 1,
                                color: lightBorder,
                              ),
                              const SizedBox(height: 16),
                              // Final Total
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Amount',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.black1,
                                    ),
                                  ),
                                  Text(
                                    '\$${(controller.total - controller.couponDiscount + 8).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(
        () => controller.cartItems.isEmpty
            ? const SizedBox()
            : Container(
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
                      color: AppColors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/checkout');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary1,
                      elevation: 4,
                      shadowColor: AppColors.primary1.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
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
