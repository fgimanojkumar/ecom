import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/style/app_colors.dart';
import 'package:imoss/shared/utils/responsive_util.dart';

import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/product_controller.dart';

class ProductDetailsView extends GetView<ProductController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final images = (controller.product['images'] as List?) ?? const [];
    final categories = (controller.product['categories'] as List?) ?? const [];
    final sizes = (controller.product['sizes'] as List?) ?? const [];
    final colors = (controller.product['colors'] as List?) ?? const [];
    final features = (controller.product['features'] as List?) ?? const [];
    final benefits = (controller.product['benefits'] as List?) ?? const [];
    final howToUse = (controller.product['howToUse'] as List?) ?? const [];
    final ingredients =
        (controller.product['ingredients'] as List?) ?? const [];
    final warnings = (controller.product['warnings'] as List?) ?? const [];
    final relatedProducts =
        (controller.product['relatedProducts'] as List?) ?? const [];
    final reviews = (controller.product['reviews'] as List?) ?? const [];
    final ratingBreakdown =
        (controller.product['ratingBreakdown'] as Map?) ?? const {};

    final price = ((controller.product['price'] as num?) ?? 0).toDouble();
    final originalPrice =
        ((controller.product['originalPrice'] as num?) ?? 0).toDouble();
    final rating = ((controller.product['rating'] as num?) ?? 0).toDouble();
    final reviewCount = (controller.product['reviewCount'] as int?) ?? 0;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PremiumAppBar(
        title: 'Product Details',
        showBackButton: true,
        actions: [
          _CircleAction(
            icon: Icons.share_outlined,
            onTap: () {},
          ),
          const SizedBox(width: 8),
          _CircleAction(
            icon: Icons.favorite_border_rounded,
            iconColor: AppColors.error,
            onTap: () {},
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: ResponsiveContent(
          addHorizontalPadding: true,
          child: Obx(
            () => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProductGallery(
                      images: images,
                      selectedIndex: controller.selectedImageIndex.value,
                      onPageChanged: (index) =>
                          controller.selectedImageIndex.value = index,
                      onThumbnailTap: controller.selectImage,
                      pageController: controller.imagePageController,
                    ),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categories
                          .map(
                            (cat) => _CategoryChip(
                              label: cat.toString(),
                              isSelected:
                                  controller.selectedCategory.value == cat,
                              onTap: () =>
                                  controller.selectedCategory.value = cat,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      (controller.product['name'] as String?) ??
                          'Premium Product',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        color: AppColors.black1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'by ${(controller.product['brand'] as String?) ?? 'Brand'}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _PriceStockCard(
                      controller: controller,
                      price: price,
                      originalPrice: originalPrice,
                      inStock: (controller.product['inStock'] as bool?) ?? true,
                      deliveryText:
                          (controller.product['delivery'] as String?) ??
                              'Fast delivery available',
                      seller: (controller.product['seller'] as String?) ??
                          'Verified seller',
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'Select Size'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: sizes
                          .map(
                            (size) => _ChoiceChipButton(
                              label: size.toString(),
                              isSelected: controller.selectedSize.value == size,
                              onTap: () => controller.selectedSize.value = size,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'Color Options'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: colors
                          .map(
                            (color) => _ChoiceChipButton(
                              label: color.toString(),
                              isSelected:
                                  controller.selectedColor.value == color,
                              onTap: () =>
                                  controller.selectedColor.value = color,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'Benefits'),
                    const SizedBox(height: 10),
                    ...benefits.map(
                      (item) => _BulletText(text: item.toString()),
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'Description'),
                    const SizedBox(height: 10),
                    Text(
                      (controller.product['description'] as String?) ??
                          'No description available.',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: AppColors.black2,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'Highlights'),
                    const SizedBox(height: 10),
                    ...features.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(
                                Icons.check_circle_rounded,
                                size: 16,
                                color: AppColors.success,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feature.toString(),
                                style: const TextStyle(
                                  color: AppColors.black1,
                                  fontSize: 13,
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'How To Use'),
                    const SizedBox(height: 10),
                    ...howToUse.asMap().entries.map(
                          (entry) => _NumberedText(
                            number: entry.key + 1,
                            text: entry.value.toString(),
                          ),
                        ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'Ingredients'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ingredients
                          .map(
                            (item) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F8F8),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE8E8E8),
                                ),
                              ),
                              child: Text(
                                item.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black1,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'Product Warning'),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFFE3A3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: warnings
                            .map(
                              (item) => _BulletText(
                                text: item.toString(),
                                iconColor: AppColors.warning,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'Related Products'),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 208,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: relatedProducts.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final item = relatedProducts[index] as Map;
                          return _RelatedProductCard(item: item);
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(title: 'Ratings & Reviews'),
                    const SizedBox(height: 10),
                    _RatingSummaryCard(
                      rating: rating,
                      reviewCount: reviewCount,
                      breakdown: ratingBreakdown,
                    ),
                    const SizedBox(height: 14),
                    _SectionTitle(title: 'User Ratings'),
                    const SizedBox(height: 10),
                    ...reviews.map(
                      (review) => _ReviewCard(
                        name: review['name']?.toString() ?? 'Customer',
                        rating: (review['rating'] as num?)?.toDouble() ?? 4,
                        comment: review['comment']?.toString() ?? '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _BottomActionBar(controller: controller),
    );
  }
}

class _ProductGallery extends StatelessWidget {
  final List images;
  final int selectedIndex;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onThumbnailTap;
  final PageController pageController;

  const _ProductGallery({
    required this.images,
    required this.selectedIndex,
    required this.onPageChanged,
    required this.onThumbnailTap,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFECECEC)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: AppColors.white1,
              borderRadius: BorderRadius.circular(18),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: PageView.builder(
                controller: pageController,
                onPageChanged: onPageChanged,
                itemCount: images.isEmpty ? 1 : images.length,
                itemBuilder: (context, index) {
                  final image = images.isEmpty
                      ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10'
                      : images[index].toString();
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.network(
                      image,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.black2,
                          size: 52,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 74,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.isEmpty ? 1 : images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final thumb = images.isEmpty
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10'
                    : images[index].toString();
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () => onThumbnailTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: 62,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary2
                            : const Color(0xFFE5E7EB),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        thumb,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_outlined,
                          color: AppColors.black2,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingSummaryCard extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final Map breakdown;

  const _RatingSummaryCard({
    required this.rating,
    required this.reviewCount,
    required this.breakdown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.yellowStarColor,
                      size: 22,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.black1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$reviewCount ratings',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.black2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [5, 4, 3, 2, 1].map((star) {
                final value = (breakdown['$star'] as num?)?.toDouble() ?? 0;
                final normalized = (value / 100).clamp(0.0, 1.0);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                        child: Text(
                          '$star',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.black2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        size: 12,
                        color: AppColors.yellowStarColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: normalized,
                            minHeight: 7,
                            backgroundColor: const Color(0xFFE5E7EB),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.primary2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${value.toInt()}%',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.black2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceStockCard extends StatelessWidget {
  final ProductController controller;
  final double price;
  final double originalPrice;
  final bool inStock;
  final String deliveryText;
  final String seller;

  const _PriceStockCard({
    required this.controller,
    required this.price,
    required this.originalPrice,
    required this.inStock,
    required this.deliveryText,
    required this.seller,
  });

  @override
  Widget build(BuildContext context) {
    final discountPercent = originalPrice > 0
        ? (((originalPrice - price) / originalPrice) * 100).round()
        : 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECECEC)),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Rs ${price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary2,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Rs ${originalPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.black2,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$discountPercent% OFF',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE7E7E7)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: controller.decreaseQty,
                  icon: const Icon(Icons.remove_rounded),
                  color: AppColors.black1,
                  splashRadius: 16,
                ),
                Obx(
                  () => Text(
                    '${controller.quantity.value}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black1,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: controller.increaseQty,
                  icon: const Icon(Icons.add_rounded),
                  color: AppColors.black1,
                  splashRadius: 16,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                inStock ? Icons.check_circle : Icons.cancel,
                color: inStock ? AppColors.success : AppColors.error,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                inStock ? 'In Stock' : 'Out of Stock',
                style: TextStyle(
                  color: inStock ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.local_shipping_outlined,
                  size: 16, color: AppColors.black2),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  deliveryText,
                  style: const TextStyle(
                    color: AppColors.black2,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.storefront_outlined,
                  size: 16, color: AppColors.black2),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Sold by $seller',
                  style: const TextStyle(
                    color: AppColors.black2,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChoiceChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceChipButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary2 : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary2 : const Color(0xFFE5E7EB),
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primary2.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.black1,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary2.withOpacity(0.14)
              : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isSelected ? AppColors.primary2 : const Color(0xFFE8E8E8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primary2 : AppColors.black2,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final double rating;
  final String comment;

  const _ReviewCard({
    required this.name,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.primary2.withOpacity(0.12),
                child: Text(
                  name.isNotEmpty ? name[0] : 'U',
                  style: const TextStyle(
                    color: AppColors.primary2,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.black1,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.star,
                      size: 12,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: const TextStyle(
              color: AppColors.black2,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.black1,
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  const _CircleAction({
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.black1,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 20, color: iconColor),
      splashRadius: 20,
      tooltip: 'action',
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final ProductController controller;

  const _BottomActionBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: const Color(0xFFECECEC))),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        14,
        10,
        14,
        10 + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: controller.addToCart,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary2,
                side: const BorderSide(color: AppColors.primary2),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.shopping_cart_outlined, size: 18),
              label: const Text(
                'Add to Cart',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary2,
                foregroundColor: AppColors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.flash_on_rounded, size: 18),
              label: const Text(
                'Buy Now',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;
  final Color iconColor;

  const _BulletText({
    required this.text,
    this.iconColor = AppColors.success,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(Icons.circle, size: 8, color: iconColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.black1,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberedText extends StatelessWidget {
  final int number;
  final String text;

  const _NumberedText({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary2.withOpacity(0.14),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: AppColors.primary2,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.black1,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedProductCard extends StatelessWidget {
  final Map item;

  const _RelatedProductCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECECEC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 104,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white1,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item['image']?.toString() ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.image,
                  color: AppColors.black2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item['name']?.toString() ?? 'Related Product',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.black1,
            ),
          ),
          const Spacer(),
          Text(
            'Rs ${(item['price'] ?? 0).toString()}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.primary2,
            ),
          ),
        ],
      ),
    );
  }
}
