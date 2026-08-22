import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/style/app_text_style.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../../../shared/widgets/premium_product_card.dart';
import '../controller/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg = isDark ? const Color(0xFF121212) : AppColors.white;

    return Scaffold(
      backgroundColor: pageBg,
      appBar: const PremiumAppBar(
        title: 'My Wishlist',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Obx(() {
          if (controller.wishlistItems.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1D1D1D) : AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF313131)
                          : const Color(0xFFECECEC),
                    ),
                    boxShadow: [
                      if (!isDark)
                        const BoxShadow(
                          color: Color(0x12111111),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: AppColors.primary2.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 38,
                          color: AppColors.primary2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No items in wishlist',
                        style: AppTextStyle.fs12Black600().copyWith(
                          color: isDark ? AppColors.white : AppColors.black1,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Save your favorite products here and access them anytime.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? const Color(0xFFB7B7B7)
                              : AppColors.black2,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      FilledButton.icon(
                        onPressed: () => Get.toNamed('/products'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary2,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                        label: const Text('Explore Products'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final width = MediaQuery.of(context).size.width;
          int columns = 2;
          if (width >= 1100) {
            columns = 5;
          } else if (width >= 900) {
            columns = 4;
          } else if (width >= 650) {
            columns = 3;
          }

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1D1D1D) : AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF313131)
                        : const Color(0xFFECECEC),
                  ),
                  boxShadow: [
                    if (!isDark)
                      const BoxShadow(
                        color: Color(0x0F111111),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary2.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: AppColors.primary2,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saved Items',
                            style: AppTextStyle.fs12Black600().copyWith(
                              color:
                                  isDark ? AppColors.white : AppColors.black1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${controller.wishlistItems.length} products in your wishlist',
                            style: TextStyle(
                              color: isDark
                                  ? const Color(0xFFB7B7B7)
                                  : AppColors.black2,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: width > 900 ? 0.7 : 0.65,
                  ),
                  itemCount: controller.wishlistItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.wishlistItems[index];
                    return PremiumProductCard(
                      id: item['id'] as String,
                      name: item['name'] as String,
                      image: item['image'] as String,
                      price: (item['price'] as num).toDouble(),
                      originalPrice: ((item['price'] as num) * 1.5).toDouble(),
                      rating: 4.5,
                      reviewCount: 100,
                      isWishlisted: true,
                      onTap: () =>
                          Get.toNamed('/productDetails', arguments: item['id']),
                      onAddToCart: () =>
                          controller.addToCart(item['id'] as String),
                      onWishlistToggle: () =>
                          controller.removeFromWishlist(item['id'] as String),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
