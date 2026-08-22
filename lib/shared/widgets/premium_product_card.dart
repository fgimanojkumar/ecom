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
              padding: const EdgeInsets.all(10),
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
}
