import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/utils/responsive_util.dart';
import 'package:imoss/shared/widgets/common_input_field.dart';
import 'package:imoss/shared/widgets/premium_app_bar.dart';
import 'package:imoss/shared/widgets/premium_product_card.dart';
import '../controller/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PremiumAppBar(
        title: 'Search Products',
        showBackButton: true,
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () => controller.isGrid.value = !controller.isGrid.value,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  controller.isGrid.value
                      ? Icons.view_list_rounded
                      : Icons.grid_view_rounded,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ResponsiveContent(
          addHorizontalPadding: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchSection(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recent Searches Section
                        _buildRecentSearchesHeader(),
                        const SizedBox(height: 16),
                        _buildRecentSearchesList(),
                        const SizedBox(height: 20),

                        // Category Filters
                        _buildCategoryFilters(),
                        const SizedBox(height: 28),

                        // Product Grid
                        _buildProductGrid(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4B5964),
            Color(0xFFEEF2F5),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: CommonInputField.field(
        hintText: 'Search here...',
        onChanged: controller.updateSearchQuery,
        fillColor: AppColors.white,
        radius: 26,
        showFocusedBorder: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 50, minHeight: 44),
        suffixIconConstraints:
            const BoxConstraints(minWidth: 50, minHeight: 44),
        prefixWidget: const Icon(
          Icons.search_rounded,
          color: Color(0xFF8A8A8A),
          size: 22,
        ),
        suffixWidget: GestureDetector(
          onTap: () => _openAdvancedFilterSheet(context),
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0F6B43),
            ),
            child: const Icon(
              Icons.tune_rounded,
              size: 17,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.availableCategories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: _buildCategoryChip(
                category,
                isSelected: controller.selectedCategories.contains(category),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.statusBtnGreen : AppColors.boxShadowColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.statusBtnGreen : AppColors.white2,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.black1,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => controller.toggleCategory(label),
            child: Icon(
              Icons.close,
              color: isSelected ? AppColors.white : AppColors.muteIconColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearchesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent Searches',
          style: TextStyle(
            color: AppColors.black1,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () => controller.clearRecentSearches(),
          child: const Text(
            'Clear all',
            style: TextStyle(
              color: AppColors.statusBtnGreen,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearchesList() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.recentSearches.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final search = controller.recentSearches[index];
          return _buildRecentSearchItem(search);
        },
      ),
    );
  }

  Widget _buildRecentSearchItem(String search) {
    return GestureDetector(
      onTap: () => controller.selectRecentSearch(search),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.white2,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.history,
              color: AppColors.muteIconColor,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                search,
                style: const TextStyle(
                  color: AppColors.black1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.removeRecentSearch(search),
              child: const Icon(
                Icons.close,
                color: AppColors.muteIconColor,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return Obx(
      () {
        if (controller.products.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'No products found with selected filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.muteIconColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final crossAxisCount = width >= 1180
                ? 5
                : width >= 980
                    ? 4
                    : width >= 760
                        ? 3
                        : 2;

            return Obx(
              () => controller.isGrid.value
                  ? MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return PremiumProductCard(
                          id: 'search_$index',
                          name: product['name'] as String? ?? 'Product',
                          image: product['image'] as String? ?? '',
                          price: _parseMoney(product['price']) ?? 0,
                          originalPrice: _parseMoney(product['oldPrice']) ??
                              _parseMoney(product['price']) ??
                              0,
                          rating: double.tryParse(
                                  product['rating']?.toString() ?? '') ??
                              4.0,
                          reviewCount: 20 + (index * 7),
                          isWishlisted: index < controller.favorites.length
                              ? controller.favorites[index]
                              : false,
                          onTap: () {},
                          onWishlistToggle: () =>
                              controller.toggleFavorite(index),
                        );
                      },
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.products.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        final price = _parseMoney(product['price']) ?? 0;
                        final originalPrice =
                            _parseMoney(product['oldPrice']) ?? price;
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16),
                                ),
                                child: Image.network(
                                  product['image'] as String? ?? '',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 100,
                                    height: 100,
                                    color: const Color(0xFFF0F0F0),
                                    child: const Icon(Icons.image,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'] as String? ?? 'Product',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Color(0xFF222222),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text(
                                            '₹${price.toStringAsFixed(0)}',
                                            style: const TextStyle(
                                              color: Color(0xFF0F6B43),
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15,
                                            ),
                                          ),
                                          if (originalPrice > price) ...[
                                            const SizedBox(width: 6),
                                            Text(
                                              '₹${originalPrice.toStringAsFixed(0)}',
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 11,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            );
          },
        );
      },
    );
  }

  double? _parseMoney(dynamic value) {
    if (value == null) {
      return null;
    }

    final cleaned = value.toString().replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned);
  }

  void _openAdvancedFilterSheet(BuildContext context) {
    final List<String> filterCategories = <String>[
      'Sort',
      'Delivery Time',
      'ONE Benefits',
      'Cuisines',
      'Explore',
      'Ratings',
      'Veg/Non-Veg',
      'Cost for Two',
      'Seller',
      'In Stock',
      'Discount',
      'Favorites',
      'Price',
      'Meal Time',
      'Spice Level',
      'Portion Size',
      'Diet Type',
      'Prep Time',
      'Free Delivery',
      'New Arrivals',
    ];

    final List<String> sortOptions = <String>[
      'Relevance (Default)',
      'Delivery Time',
      'Rating',
      'Cost: Low to High',
      'Cost: High to Low',
    ];

    final RxString selectedFilterCategory = filterCategories.first.obs;
    final RxString selectedSortOption =
        _mapControllerSortToUi(controller.sortBy.value).obs;

    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.white2,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter & Sort',
                      style: TextStyle(
                        color: AppColors.black1,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    InkWell(
                      onTap: Get.back,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFF5F5F5), Color(0xFFEAEAEA)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: AppColors.black1,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, thickness: 1.2, color: AppColors.white2),
              Expanded(
                child: Obx(
                  () => Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            border: Border(
                              right: BorderSide(
                                color: AppColors.white2,
                                width: 1.2,
                              ),
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: filterCategories.length,
                            itemBuilder: (BuildContext context, int index) {
                              final String item = filterCategories[index];
                              final bool isSelected =
                                  selectedFilterCategory.value == item;
                              return _buildFilterSidebarItem(
                                label: item,
                                isSelected: isSelected,
                                onTap: () {
                                  selectedFilterCategory.value = item;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                          child: _buildFilterCategoryContent(
                            category: selectedFilterCategory.value,
                            sortOptions: sortOptions,
                            selectedSortOption: selectedSortOption,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.white2, width: 1.2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            controller.resetFilters();
                            selectedFilterCategory.value =
                                filterCategories.first;
                            selectedSortOption.value =
                                _mapControllerSortToUi(controller.sortBy.value);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: AppColors.divider, width: 1.2),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              color: AppColors.black1,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary1,
                                AppColors.primary1.withOpacity(0.9)
                              ],
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
                          child: ElevatedButton(
                            onPressed: () {
                              controller.updateSortBy(
                                _mapUiSortToController(
                                    selectedSortOption.value),
                              );
                              controller.logSelectedFiltersAndResults();
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Apply Filters',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  String _mapUiSortToController(String value) {
    switch (value) {
      case 'Rating':
        return 'Rating: High to Low';
      case 'Cost: Low to High':
        return 'Price: Low to High';
      case 'Cost: High to Low':
        return 'Price: High to Low';
      case 'Delivery Time':
        return 'Delivery Time';
      default:
        return 'Relevance';
    }
  }

  String _mapControllerSortToUi(String value) {
    switch (value) {
      case 'Rating: High to Low':
        return 'Rating';
      case 'Price: Low to High':
        return 'Cost: Low to High';
      case 'Price: High to Low':
        return 'Cost: High to Low';
      case 'Delivery Time':
        return 'Delivery Time';
      default:
        return 'Relevance (Default)';
    }
  }

  Widget _buildFilterSidebarItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary1.withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppColors.primary1.withOpacity(0.3))
              : null,
        ),
        child: Row(
          children: [
            if (isSelected)
              Container(
                width: 4,
                height: 32,
                margin: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: AppColors.primary1,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            else
              const SizedBox(width: 12),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? AppColors.primary1 : AppColors.black1,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.check_rounded,
                  color: AppColors.primary1,
                  size: 20,
                ),
              )
            else
              const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildSortRadioRow({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary1.withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppColors.primary1.withOpacity(0.2))
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.primary1 : AppColors.black1,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: -0.1,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary1 : AppColors.divider,
                  width: 2,
                ),
              ),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary1 : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCategoryContent({
    required String category,
    required List<String> sortOptions,
    required RxString selectedSortOption,
  }) {
    switch (category) {
      case 'Sort':
        return ListView.separated(
          itemCount: sortOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = sortOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: selectedSortOption.value == option,
              onTap: () {
                selectedSortOption.value = option;
              },
            );
          },
        );
      case 'Delivery Time':
        return ListView.separated(
          itemCount: controller.deliveryTimeOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = controller.deliveryTimeOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: controller.deliveryTimeFilter.value == option,
              onTap: () => controller.updateDeliveryTimeFilter(option),
            );
          },
        );
      case 'ONE Benefits':
        return ListView(
          children: [
            const SizedBox(height: 4),
            const Text(
              'Exclusive Benefits',
              style: TextStyle(
                color: AppColors.black1,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Show items with member-only offers and faster fulfillment.',
              style: TextStyle(
                color: AppColors.black2,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.body,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.white2),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'ONE Benefits Only',
                      style: TextStyle(
                        color: AppColors.black1,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Switch(
                    value: controller.oneBenefitsOnly.value,
                    activeColor: AppColors.statusBtnYellow,
                    onChanged: controller.updateOneBenefitsOnly,
                  ),
                ],
              ),
            ),
          ],
        );
      case 'Cuisines':
        return ListView(
          children: [
            const SizedBox(height: 4),
            const Text(
              'Pick Cuisines',
              style: TextStyle(
                color: AppColors.black1,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.cuisineOptions.map((String cuisine) {
                final bool selected =
                    controller.selectedCuisines.contains(cuisine);
                return _buildSelectableChip(
                  label: cuisine,
                  isSelected: selected,
                  onTap: () => controller.toggleCuisine(cuisine),
                );
              }).toList(),
            ),
          ],
        );
      case 'Explore':
        return ListView(
          children: [
            const SizedBox(height: 4),
            const Text(
              'Explore Collections',
              style: TextStyle(
                color: AppColors.black1,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.exploreOptions.map((String tag) {
                final bool selected =
                    controller.selectedExploreTags.contains(tag);
                return _buildSelectableChip(
                  label: tag,
                  isSelected: selected,
                  onTap: () => controller.toggleExploreTag(tag),
                );
              }).toList(),
            ),
          ],
        );
      case 'Ratings':
        return ListView.separated(
          itemCount: controller.ratingOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = controller.ratingOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: controller.ratingFilter.value == option,
              onTap: () => controller.updateRatingFilter(option),
            );
          },
        );
      case 'Veg/Non-Veg':
        return ListView(
          children: [
            const SizedBox(height: 4),
            const Text(
              'Food Preference',
              style: TextStyle(
                color: AppColors.black1,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...controller.vegNonVegOptions.map((String option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildSortRadioRow(
                  title: option,
                  isSelected: controller.vegNonVegFilter.value == option,
                  onTap: () => controller.updateVegNonVegFilter(option),
                ),
              );
            }),
          ],
        );
      case 'Cost for Two':
        return ListView.separated(
          itemCount: controller.costForTwoOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = controller.costForTwoOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: controller.costForTwoFilter.value == option,
              onTap: () => controller.updateCostForTwoFilter(option),
            );
          },
        );
      case 'Seller':
        return ListView.separated(
          itemCount: controller.sellerOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = controller.sellerOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: controller.selectedSeller.value == option,
              onTap: () => controller.updateSelectedSeller(option),
            );
          },
        );
      case 'In Stock':
        return _buildSingleSwitchCard(
          title: 'Show In-Stock Items Only',
          subtitle: 'Hide unavailable items from product list.',
          value: controller.inStockOnly.value,
          onChanged: controller.updateInStockOnly,
        );
      case 'Discount':
        return _buildSingleSwitchCard(
          title: 'Discounted Items Only',
          subtitle: 'Show products where old price is higher than current.',
          value: controller.discountedOnly.value,
          onChanged: controller.updateDiscountedOnly,
        );
      case 'Favorites':
        return _buildSingleSwitchCard(
          title: 'Favorites Only',
          subtitle: 'Show only items marked with heart.',
          value: controller.favoritesOnly.value,
          onChanged: controller.updateFavoritesOnly,
        );
      case 'Price':
        return ListView(
          children: [
            const SizedBox(height: 4),
            const Text(
              'Price Range',
              style: TextStyle(
                color: AppColors.black1,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            SliderTheme(
              data: SliderTheme.of(Get.context!).copyWith(
                activeTrackColor: AppColors.statusBtnYellow,
                thumbColor: AppColors.statusBtnYellow,
                inactiveTrackColor: AppColors.white2,
                overlayColor: AppColors.statusBtnYellow,
              ),
              child: RangeSlider(
                values: RangeValues(
                  controller.minPrice.value,
                  controller.maxPrice.value,
                ),
                min: 0,
                max: 50,
                divisions: 25,
                onChanged: (RangeValues range) {
                  controller.updatePriceRange(range.start, range.end);
                },
              ),
            ),
            Text(
              '\$${controller.minPrice.value.toStringAsFixed(0)} - \$${controller.maxPrice.value.toStringAsFixed(0)}',
              style: const TextStyle(
                color: AppColors.blackHeading,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case 'Meal Time':
        return ListView.separated(
          itemCount: controller.mealTimeOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = controller.mealTimeOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: controller.mealTimeFilter.value == option,
              onTap: () => controller.updateMealTimeFilter(option),
            );
          },
        );
      case 'Spice Level':
        return ListView.separated(
          itemCount: controller.spiceLevelOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = controller.spiceLevelOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: controller.spiceLevelFilter.value == option,
              onTap: () => controller.updateSpiceLevelFilter(option),
            );
          },
        );
      case 'Portion Size':
        return ListView.separated(
          itemCount: controller.portionSizeOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = controller.portionSizeOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: controller.portionSizeFilter.value == option,
              onTap: () => controller.updatePortionSizeFilter(option),
            );
          },
        );
      case 'Diet Type':
        return ListView.separated(
          itemCount: controller.dietTypeOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = controller.dietTypeOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: controller.dietTypeFilter.value == option,
              onTap: () => controller.updateDietTypeFilter(option),
            );
          },
        );
      case 'Prep Time':
        return ListView.separated(
          itemCount: controller.prepTimeOptions.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.white1,
          ),
          itemBuilder: (_, index) {
            final String option = controller.prepTimeOptions[index];
            return _buildSortRadioRow(
              title: option,
              isSelected: controller.prepTimeFilter.value == option,
              onTap: () => controller.updatePrepTimeFilter(option),
            );
          },
        );
      case 'Free Delivery':
        return _buildSingleSwitchCard(
          title: 'Free Delivery Only',
          subtitle: 'Show items with zero delivery charge.',
          value: controller.freeDeliveryOnly.value,
          onChanged: controller.updateFreeDeliveryOnly,
        );
      case 'New Arrivals':
        return _buildSingleSwitchCard(
          title: 'New Arrivals Only',
          subtitle: 'Show recently added products only.',
          value: controller.newArrivalsOnly.value,
          onChanged: controller.updateNewArrivalsOnly,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSingleSwitchCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.body,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.white2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.black1,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.black2,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: value,
                activeColor: AppColors.statusBtnYellow,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectableChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.body : AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? AppColors.statusBtnYellow : AppColors.white2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color:
                isSelected ? AppColors.statusBtnYellow : AppColors.blackHeading,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildFilterRow({
    required String title,
    required Widget valueWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white1,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.black1,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            valueWidget,
          ],
        ),
      ),
    );
  }
}
