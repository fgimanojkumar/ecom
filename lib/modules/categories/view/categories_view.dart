import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../../../shared/widgets/premium_category_card.dart';
import '../controller/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
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
        // LayoutBuilder must be outside Obx; deferred builder callbacks
        // are not tracked by Obx's reactive phase.
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final crossAxisCount = width >= 1180
                ? 8
                : width >= 900
                    ? 6
                    : width >= 680
                        ? 5
                        : 4;

            return Obx(
              () => GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.78,
                ),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return PremiumCategoryCard(
                    name: category['name'] as String,
                    image: category['image'] as String,
                    icon: Icons.category.codePoint.toString(),
                    onTap: () =>
                        controller.viewCategory(category['id'] as String),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
