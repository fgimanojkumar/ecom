import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryMap = {
      'Electronics': ['Audio', 'Wearables', 'Accessories', 'Gadgets'],
      'Fashion': ['Women', 'Men', 'Footwear', 'Accessories'],
      'Beauty': ['Skincare', 'Makeup', 'Hair', 'Fragrance'],
      'Sports': ['Fitness', 'Outdoor', 'Shoes', 'Accessories'],
      'Mobiles & Tablets': [
        'Smartphones',
        'Tablets',
        'Cases & Covers',
        'Chargers',
        'Audio',
      ],
      'Groceries': [
        'Fruits & Vegetables',
        'Pantry Staples',
        'Snacks',
        'Beverages',
        'Household',
      ],
      'Footwear': ['Sneakers', 'Casual Shoes', 'Formal Shoes', 'Sandals'],
      'Books': ['Fiction', 'Non-fiction', 'Children', 'Academic', 'Stationery'],
      'Toys & Baby': ['Toys', 'Baby Care', 'Feeding', 'Nursery', 'Learning'],
      'Jewellery': ['Necklaces', 'Earrings', 'Rings', 'Bracelets', 'Watches'],
    };

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PremiumAppBar(
        title: Get.currentRoute.contains('subcategor')
            ? 'Sub Categories'
            : 'Categories',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWeb = constraints.maxWidth >= 900;

            return Obx(() {
              final selectedId = controller.selectedCategoryId.value.isEmpty
                  ? controller.categories.first['id'] as String
                  : controller.selectedCategoryId.value;
              final selectedCategory = controller.categories.firstWhere(
                (category) => (category['id'] as String) == selectedId,
                orElse: () => controller.categories.first,
              );
              final selectedName = selectedCategory['name'] as String;
              final subCategories = categoryMap[selectedName] ??
                  ['Trending', 'New Arrival', 'Popular'];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: isWeb ? 270 : 104,
                    margin: EdgeInsets.only(right: isWeb ? 18 : 10),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView.builder(
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        final isSelected =
                            (category['id'] as String) == selectedId;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: InkWell(
                            onTap: () => controller.selectCategory(
                              category['id'] as String,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary1.withOpacity(0.08)
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary1
                                      : AppColors.white2,
                                ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: isWeb
                                  ? Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            category['image'] as String,
                                            width: 42,
                                            height: 42,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            category['name'] as String,
                                            style: TextStyle(
                                              fontWeight: isSelected
                                                  ? FontWeight.w800
                                                  : FontWeight.w600,
                                              color: isSelected
                                                  ? AppColors.primary1
                                                  : AppColors.black1,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            category['image'] as String,
                                            width: 48,
                                            height: 48,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          category['name'] as String,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: isSelected
                                                ? FontWeight.w800
                                                : FontWeight.w600,
                                            color: isSelected
                                                ? AppColors.primary1
                                                : AppColors.black1,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.white2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primary1.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.category_rounded,
                                  color: AppColors.primary1,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  selectedName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.black1,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    controller.viewCategory(selectedId),
                                child: const Text('View all'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.only(bottom: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isWeb ? 3 : 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: isWeb ? 1.2 : 1.0,
                            ),
                            itemCount: subCategories.length,
                            itemBuilder: (context, index) {
                              final name = subCategories[index];
                              final image = controller.categories.firstWhere(
                                (category) =>
                                    (category['name'] as String) ==
                                    selectedName,
                                orElse: () => controller.categories.first,
                              )['image'] as String;

                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: AppColors.white2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withOpacity(0.03),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () =>
                                      controller.viewCategory(selectedId),
                                  borderRadius: BorderRadius.circular(18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(18),
                                          ),
                                          child: Image.network(
                                            image,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.black1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
