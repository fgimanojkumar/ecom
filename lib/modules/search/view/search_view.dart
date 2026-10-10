import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/common_app_drawer.dart';
import '../../../shared/widgets/common_input_field.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../../../shared/widgets/premium_product_card.dart';
import '../controller/search_controller.dart';

class SearchView extends GetView<SearchController> {
  static const List<String> _filterCategories = <String>[
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

  static const List<String> _filterSortOptions = <String>[
    'Relevance (Default)',
    'Delivery Time',
    'Rating',
    'Cost: Low to High',
    'Cost: High to Low',
  ];

  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtil.isDesktop(context);
    final routeArguments = Get.arguments;
    final routeQuery = routeArguments is String
        ? routeArguments
        : routeArguments is Map
            ? (routeArguments['query']?.toString() ?? '')
            : '';
    controller.applyRouteQuery(routeQuery);
    controller.initializeLayoutMode(MediaQuery.sizeOf(context).width);

    return Scaffold(
      drawer: const CommonAppDrawer(),
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Search',
        showBackButton: true,
        searchPageLayout: true,
      ),
      body: SafeArea(
        child: isDesktop
            ? Padding(
                padding: const EdgeInsets.only(left: 18, right: 28),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: _buildWebFilterSidebar(context),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildSearchResults(
                        context,
                        showFilterButton: false,
                        showInlineSearchBar: false,
                      ),
                    ),
                  ],
                ),
              )
            : ResponsiveContent(
                addHorizontalPadding: true,
                child: _buildSearchResults(
                  context,
                  showFilterButton: true,
                  showInlineSearchBar: false,
                ),
              ),
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context, {
    required bool showFilterButton,
    required bool showInlineSearchBar,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.displayedCount.value = 20;
        controller.applyFilters();
        await Future.delayed(const Duration(milliseconds: 600));
      },
      color: AppColors.primary1,
      child: CustomScrollView(
        controller: controller.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchStickyHeaderDelegate(
              ctrl: controller,
              onFilterTap: () => _openAdvancedFilterSheet(context),
              showFilterButton: showFilterButton,
              showSearchField: showInlineSearchBar,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
              child: Obx(() {
                final isSearching =
                    controller.searchQuery.value.trim().isNotEmpty;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isSearching
                      ? [
                          _buildProductGrid(),
                          Obx(() {
                            if (controller.displayedCount.value >=
                                controller.products.length) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: controller.isLoadingMore.value
                                    ? CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: AppColors.primary1,
                                      )
                                    : TextButton(
                                        onPressed: controller.loadMore,
                                        child: Obx(() => Text(
                                              'Load more · ${controller.products.length - controller.displayedCount.value} remaining',
                                              style: TextStyle(
                                                color: AppColors.primary1,
                                              ),
                                            )),
                                      ),
                              ),
                            );
                          }),
                        ]
                      : [
                          _buildRecentSearchesHeader(),
                          const SizedBox(height: 16),
                          _buildRecentSearchesList(),
                        ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebFilterSidebar(BuildContext context) {
    final selectedSortOption =
        _mapControllerSortToUi(controller.sortBy.value).obs;

    return SizedBox(
      height: MediaQuery.sizeOf(context).height - 100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 14, 12, 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Refine results',
                    style: TextStyle(
                      color: AppColors.black1,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.resetFilters();
                    selectedSortOption.value =
                        _mapControllerSortToUi(controller.sortBy.value);
                  },
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 4),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.updateSortBy(
                      _mapUiSortToController(selectedSortOption.value),
                    );
                    controller.logSelectedFiltersAndResults();
                  },
                  icon: const Icon(Icons.check_rounded, size: 16),
                  label: const Text('Apply'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary1,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              key: const PageStorageKey<String>('web-filter-list'),
              padding: const EdgeInsets.symmetric(vertical: 6),
              children: _filterCategories.map((category) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    key: PageStorageKey<String>('web-filter-$category'),
                    initiallyExpanded: category == _filterCategories.first,
                    maintainState: false,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                    childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    collapsedShape: const RoundedRectangleBorder(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: AppColors.white2),
                    ),
                    title: Obx(() {
                      final isActive =
                          _isWebFilterActive(category, selectedSortOption);
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isActive
                                    ? AppColors.primary1
                                    : AppColors.black1,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (isActive)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary1.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'ON',
                                style: TextStyle(
                                  color: AppColors.primary1,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                    trailing: const Icon(
                      Icons.expand_more_rounded,
                      color: AppColors.black2,
                    ),
                    children: [
                      Obx(
                        () {
                          _webFilterCategoryState(
                            category,
                            selectedSortOption,
                          );
                          return KeyedSubtree(
                            key: PageStorageKey<String>(
                              'web-filter-options-$category',
                            ),
                            child: SizedBox(
                              height: 220,
                              child: _buildFilterCategoryContent(
                                category: category,
                                sortOptions: _filterSortOptions,
                                selectedSortOption: selectedSortOption,
                              ),
                            ),
                          );
                        },
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

  Object? _webFilterCategoryState(
    String category,
    RxString selectedSortOption,
  ) {
    switch (category) {
      case 'Sort':
        return selectedSortOption.value;
      case 'Delivery Time':
        return controller.deliveryTimeFilter.value;
      case 'ONE Benefits':
        return controller.oneBenefitsOnly.value;
      case 'Cuisines':
        return '${controller.selectedCuisines.length}:${controller.selectedCuisines.join('|')}';
      case 'Explore':
        return '${controller.selectedExploreTags.length}:${controller.selectedExploreTags.join('|')}';
      case 'Ratings':
        return controller.ratingFilter.value;
      case 'Veg/Non-Veg':
        return controller.vegNonVegFilter.value;
      case 'Cost for Two':
        return controller.costForTwoFilter.value;
      case 'Seller':
        return controller.selectedSeller.value;
      case 'In Stock':
        return controller.inStockOnly.value;
      case 'Discount':
        return controller.discountedOnly.value;
      case 'Favorites':
        return controller.favoritesOnly.value;
      case 'Price':
        return '${controller.minPrice.value}:${controller.maxPrice.value}';
      case 'Meal Time':
        return controller.mealTimeFilter.value;
      case 'Spice Level':
        return controller.spiceLevelFilter.value;
      case 'Portion Size':
        return controller.portionSizeFilter.value;
      case 'Diet Type':
        return controller.dietTypeFilter.value;
      case 'Prep Time':
        return controller.prepTimeFilter.value;
      case 'Free Delivery':
        return controller.freeDeliveryOnly.value;
      case 'New Arrivals':
        return controller.newArrivalsOnly.value;
      default:
        return category;
    }
  }

  bool _isWebFilterActive(
    String category,
    RxString selectedSortOption,
  ) {
    switch (category) {
      case 'Sort':
        return selectedSortOption.value != _filterSortOptions.first;
      case 'Delivery Time':
        return controller.deliveryTimeFilter.value != 'Any';
      case 'ONE Benefits':
        return controller.oneBenefitsOnly.value;
      case 'Cuisines':
        return controller.selectedCuisines.isNotEmpty;
      case 'Explore':
        return controller.selectedExploreTags.isNotEmpty;
      case 'Ratings':
        return controller.ratingFilter.value != 'Any';
      case 'Veg/Non-Veg':
        return controller.vegNonVegFilter.value != 'All';
      case 'Cost for Two':
        return controller.costForTwoFilter.value != 'Any';
      case 'Seller':
        return controller.selectedSeller.value != 'All';
      case 'In Stock':
        return controller.inStockOnly.value;
      case 'Discount':
        return controller.discountedOnly.value;
      case 'Favorites':
        return controller.favoritesOnly.value;
      case 'Price':
        return controller.minPrice.value > 0 || controller.maxPrice.value < 50;
      case 'Meal Time':
        return controller.mealTimeFilter.value != 'Any';
      case 'Spice Level':
        return controller.spiceLevelFilter.value != 'Any';
      case 'Portion Size':
        return controller.portionSizeFilter.value != 'Any';
      case 'Diet Type':
        return controller.dietTypeFilter.value != 'Any';
      case 'Prep Time':
        return controller.prepTimeFilter.value != 'Any';
      case 'Free Delivery':
        return controller.freeDeliveryOnly.value;
      case 'New Arrivals':
        return controller.newArrivalsOnly.value;
      default:
        return false;
    }
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
            final screenWidth = MediaQuery.sizeOf(context).width;
            final crossAxisCount = screenWidth >= 1024
                ? 4
                : screenWidth >= 600
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
                      itemCount: controller.displayedCount.value
                          .clamp(0, controller.products.length),
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        final reviewCount =
                            (product['reviewCount'] as num?)?.toInt() ??
                                20 + (index * 7);
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
                          reviewCount: reviewCount,
                          isWishlisted: index < controller.favorites.length
                              ? controller.favorites[index]
                              : false,
                          isSponsored: product['isSponsored'] == true,
                          lowestPrice30Days:
                              _parseMoney(product['lowestPrice30Days']),
                          isInStock: (product['stock'] as num? ?? 1) > 0,
                          sellerName:
                              product['seller'] as String? ?? 'Verified Seller',
                          isFreeDelivery: product['freeDelivery'] == true,
                          onTap: () => controller.openProductDetails(index),
                          onAddToCart: () => controller.addToCart(index),
                          onWishlistToggle: () =>
                              controller.toggleFavorite(index),
                        );
                      },
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.displayedCount.value
                          .clamp(0, controller.products.length),
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        final price = _parseMoney(product['price']) ?? 0;
                        final originalPrice =
                            _parseMoney(product['oldPrice']) ?? price;
                        final hasDiscount = originalPrice > price;
                        final discountPct = hasDiscount
                            ? (((originalPrice - price) / originalPrice) * 100)
                                .round()
                            : 0;
                        final rating = double.tryParse(
                                product['rating']?.toString() ?? '') ??
                            4.0;
                        final reviewCount =
                            (product['reviewCount'] as num?)?.toInt() ??
                                20 + (index * 7);
                        final inStock = (product['stock'] as int? ?? 1) > 0;
                        final seller =
                            product['seller'] as String? ?? 'Verified Seller';
                        final isSponsored = product['isSponsored'] == true;
                        final lowestPrice30Days =
                            _parseMoney(product['lowestPrice30Days']);
                        final isWishlisted = index < controller.favorites.length
                            ? controller.favorites[index]
                            : false;
                        final isMobile = MediaQuery.sizeOf(context).width < 600;
                        final imageWidth = isMobile ? 88.0 : 110.0;
                        final imageHeight = isMobile ? 126.0 : 180.0;

                        return InkWell(
                          onTap: () => controller.openProductDetails(index),
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.06),
                                  blurRadius: 14,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.03),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ── Image + badges ──────────────────────
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                        left: Radius.circular(18),
                                      ),
                                      child: ProductCardImage(
                                        image:
                                            product['image']?.toString() ?? '',
                                        width: imageWidth,
                                        height: imageHeight,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    if (isSponsored)
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.white
                                                .withOpacity(0.95),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: const Text(
                                            'Sponsored',
                                            style: TextStyle(
                                              color: AppColors.black1,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                // ── Product details ──────────────────────
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Name + wishlist
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                product['name'] as String? ??
                                                    'Product',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13,
                                                  color: AppColors.black1,
                                                  height: 1.3,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => controller
                                                  .toggleFavorite(index),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4),
                                                child: Icon(
                                                  isWishlisted
                                                      ? Icons.favorite_rounded
                                                      : Icons
                                                          .favorite_border_rounded,
                                                  color: isWishlisted
                                                      ? AppColors.error
                                                      : AppColors.muteIconColor,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 5),

                                        // Rating row
                                        Row(
                                          children: [
                                            const Icon(Icons.star_rounded,
                                                color:
                                                    AppColors.statusBtnYellow,
                                                size: 13),
                                            const SizedBox(width: 3),
                                            Text(
                                              rating.toStringAsFixed(1),
                                              style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.black1,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '($reviewCount reviews)',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: AppColors.muteIconColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '• $seller',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color:
                                                      AppColors.muteIconColor,
                                                ),
                                              ),
                                            ),
                                            if (hasDiscount)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 3,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.error
                                                      .withOpacity(0.08),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  '$discountPct% OFF',
                                                  style: const TextStyle(
                                                    color: AppColors.error,
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        // Price row
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '₹${price.toStringAsFixed(0)}',
                                              style: TextStyle(
                                                color: AppColors.primary1,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                              ),
                                            ),
                                            if (hasDiscount) ...[
                                              const SizedBox(width: 6),
                                              Text(
                                                '₹${originalPrice.toStringAsFixed(0)}',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.muteIconColor,
                                                  fontSize: 11,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),

                                        if (lowestPrice30Days != null) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            '30-day low ₹${lowestPrice30Days.toStringAsFixed(0)}',
                                            style: const TextStyle(
                                              color: AppColors.black2,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                        const SizedBox(height: 7),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.success
                                                .withOpacity(0.09),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.autorenew_rounded,
                                                size: 12,
                                                color: AppColors.success,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                '5-7 days return / replacement',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppColors.success,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 7),

                                        // Stock + delivery
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                color: inStock
                                                    ? AppColors.success
                                                        .withOpacity(0.1)
                                                    : AppColors.error
                                                        .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                inStock
                                                    ? 'In Stock'
                                                    : 'Out of Stock',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: inStock
                                                      ? AppColors.success
                                                      : AppColors.error,
                                                ),
                                              ),
                                            ),
                                            if (product['freeDelivery'] ==
                                                true) ...[
                                              const SizedBox(width: 6),
                                              const Icon(
                                                  Icons.local_shipping_outlined,
                                                  size: 11,
                                                  color: AppColors.info),
                                              const SizedBox(width: 2),
                                              const Text(
                                                'Free',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppColors.info,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.local_shipping_outlined,
                                              size: 12,
                                              color: AppColors.black2,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Shipping: Rs 49',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: AppColors.black2,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        ProductAddToCartButton(
                                          onPressed: () =>
                                              controller.addToCart(index),
                                          compact: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    final filterCategories = _filterCategories;
    final sortOptions = _filterSortOptions;

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
              '₹${controller.minPrice.value.toStringAsFixed(0)} - ₹${controller.maxPrice.value.toStringAsFixed(0)}',
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

// ─── Pinned search bar + filter row ──────────────────────────────────────────

class _SearchStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final SearchController ctrl;
  final VoidCallback onFilterTap;
  final bool showFilterButton;
  final bool showSearchField;

  const _SearchStickyHeaderDelegate({
    required this.ctrl,
    required this.onFilterTap,
    required this.showFilterButton,
    required this.showSearchField,
  });

  @override
  double get minExtent => showSearchField ? 120 : 62;
  @override
  double get maxExtent => minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(
        child: Container(
      padding: EdgeInsets.fromLTRB(0, showSearchField ? 10 : 8, 0, 0),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          if (showSearchField) ...[
            // ── Web search bar ─────────────────────────────────
            SizedBox(
              height: 50,
              child: Container(
                // decoration: BoxDecoration(
                //   color: AppColors.white,
                //   borderRadius: BorderRadius.circular(14),
                //   border: Border.all(color: const Color(0xFFE8E8E8)),
                //   boxShadow: [
                //     BoxShadow(
                //       color: AppColors.primary1.withOpacity(0.07),
                //       blurRadius: 16,
                //       offset: const Offset(0, 4),
                //     ),
                //   ],
                // ),
                child: Row(
                  children: [
                    // Text field
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: CommonInputField.field(
                          controller: ctrl.searchTextController,
                          onChanged: ctrl.updateSearchQuery,
                          textInputAction: TextInputAction.search,
                          onSubmitted: ctrl.submitSearch,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColors.black1,
                            fontWeight: FontWeight.w500,
                          ),
                          decorationOverride: InputDecoration(
                            hintText: 'Search products...',
                            hintStyle: TextStyle(
                              color: AppColors.muteIconColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),

                    // Clear button
                    Obx(() => ctrl.searchQuery.value.isNotEmpty
                        ? GestureDetector(
                            onTap: ctrl.clearSearch,
                            child: Container(
                              width: 44,
                              alignment: Alignment.center,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: AppColors.white2,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: AppColors.muteIconColor,
                                  size: 13,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(width: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // ── Grid/List + Filter row ────────────────────────────
          Obx(
            () => SizedBox(
              height: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () => ctrl.isGrid.value = !ctrl.isGrid.value,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.white2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              ctrl.isGrid.value
                                  ? Icons.view_list_rounded
                                  : Icons.grid_view_rounded,
                              size: 15,
                              color: AppColors.primary1,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              ctrl.isGrid.value ? 'List' : 'Grid',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (showFilterButton)
                    Material(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: onFilterTap,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.white2),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.tune_rounded,
                                size: 15,
                                color: AppColors.primary1,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Filter',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black1,
                                ),
                              ),
                            ],
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
    ));
  }

  @override
  bool shouldRebuild(_SearchStickyHeaderDelegate oldDelegate) => false;
}
