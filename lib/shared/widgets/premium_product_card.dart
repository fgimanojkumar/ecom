import 'package:flutter/material.dart';
import '../../shared/style/app_colors.dart';
import '../../shared/style/app_text_style.dart';

class PremiumProductCard extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final bool isWishlisted;
  final VoidCallback onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback onWishlistToggle;

  const PremiumProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    this.isWishlisted = false,
    required this.onTap,
    this.onAddToCart,
    required this.onWishlistToggle,
  });

  @override
  State<PremiumProductCard> createState() => _PremiumProductCardState();
}

class _PremiumProductCardState extends State<PremiumProductCard> {
  @override
  Widget build(BuildContext context) {
    final isNetworkImage = widget.image.startsWith('http');

    final discount = widget.originalPrice > 0
        ? (((widget.originalPrice - widget.price) / widget.originalPrice) * 100)
            .toStringAsFixed(0)
        : '0';

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: () => _showQuickPreview(context),
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColors.white,
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// IMAGE SECTION
            SizedBox(
              height: 132,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: 'product_${widget.id}',
                      child: isNetworkImage
                          ? Image.network(
                              widget.image,
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                progress,
                              ) {
                                if (progress == null) {
                                  return child;
                                }

                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return Container(
                                  color: AppColors.white2,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 40,
                                      color: AppColors.greyLight,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: const Color(0xFFFFF8EE),
                              alignment: Alignment.center,
                              child: Text(
                                widget.image,
                                style: const TextStyle(fontSize: 52),
                              ),
                            ),
                    ),
                  ),

                  /// DISCOUNT
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$discount% OFF',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  /// WISHLIST
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: widget.onWishlistToggle,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.isWishlisted
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isWishlisted
                              ? AppColors.error
                              : AppColors.greyLight,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// CONTENT
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.fs12Black600(),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: AppColors.statusBtnYellow,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.rating.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          '(${widget.reviewCount})',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.black2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '₹${widget.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary2,
                        ),
                      ),
                      Text(
                        '₹${widget.originalPrice.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.black2,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(
                        Icons.local_shipping_outlined,
                        size: 12,
                        color: AppColors.black2,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Shipping: Rs 49',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.black2,
                            fontWeight: FontWeight.w600,
                          ),
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

  void _showQuickPreview(BuildContext context) {
    final hasDiscount = widget.originalPrice > widget.price;
    final discountPct = hasDiscount
        ? (((widget.originalPrice - widget.price) / widget.originalPrice) * 100)
            .round()
        : 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: EdgeInsets.fromLTRB(
            20, 16, 20, 20 + MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.white2,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Hero(
              tag: 'product_${widget.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: AppColors.white1,
                    child: const Icon(Icons.image_outlined,
                        size: 40, color: AppColors.muteIconColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black1),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star_rounded,
                    color: AppColors.statusBtnYellow, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${widget.rating}  (${widget.reviewCount} reviews)',
                  style: const TextStyle(fontSize: 12, color: AppColors.black2),
                ),
                if (hasDiscount) ...[
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '$discountPct% OFF',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.error),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '₹${widget.price.toStringAsFixed(0)}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary1),
                ),
                if (hasDiscount) ...[
                  const SizedBox(width: 10),
                  Text(
                    '₹${widget.originalPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.muteIconColor,
                        decoration: TextDecoration.lineThrough),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onTap();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.gradientStart,
                          AppColors.gradientEnd
                        ],
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
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onAddToCart?.call();
                      },
                      icon: const Icon(Icons.shopping_cart_outlined,
                          size: 16, color: AppColors.white),
                      label: const Text('Add to Cart',
                          style: TextStyle(color: AppColors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
