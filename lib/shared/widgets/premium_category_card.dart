import 'package:flutter/material.dart';
import 'package:imoss/shared/style/app_colors.dart';

class PremiumCategoryCard extends StatelessWidget {
  final String name;
  final String image;
  final String icon;
  final VoidCallback onTap;

  const PremiumCategoryCard({
    super.key,
    required this.name,
    required this.image,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary1.withOpacity(0.2),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary1.withOpacity(0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.white1,
                  child: const Icon(
                    Icons.category_rounded,
                    size: 28,
                    color: AppColors.primary1,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.black1,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
