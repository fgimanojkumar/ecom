import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show ScrollController, TextEditingController;
import 'package:get/get.dart';

class SearchController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxBool isGrid = true.obs;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxDouble minRating = 0.0.obs;
  final RxBool inStockOnly = false.obs;
  final RxBool discountedOnly = false.obs;
  final RxBool favoritesOnly = false.obs;
  final RxString selectedSeller = 'All'.obs;
  final RxString sortBy = 'Relevance'.obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 50.0.obs;
  final RxString deliveryTimeFilter = 'Any'.obs;
  final RxBool oneBenefitsOnly = false.obs;
  final RxList<String> selectedCuisines = <String>[].obs;
  final RxList<String> selectedExploreTags = <String>[].obs;
  final RxString ratingFilter = 'Any'.obs;
  final RxString vegNonVegFilter = 'All'.obs;
  final RxString costForTwoFilter = 'Any'.obs;
  final RxString mealTimeFilter = 'Any'.obs;
  final RxString spiceLevelFilter = 'Any'.obs;
  final RxString portionSizeFilter = 'Any'.obs;
  final RxString dietTypeFilter = 'Any'.obs;
  final RxString prepTimeFilter = 'Any'.obs;
  final RxBool freeDeliveryOnly = false.obs;
  final RxBool newArrivalsOnly = false.obs;

  final List<String> availableCategories = const [
    'Fruits',
    'Vegetables',
    'Beverages',
    'Meat',
  ];

  final List<String> sortOptions = const [
    'Relevance',
    'Price: Low to High',
    'Price: High to Low',
    'Rating: High to Low',
    'Discount: High to Low',
  ];

  final List<String> sellerOptions = const [
    'All',
    'Philip',
    'Arlene',
    'Warren',
    'Ferrari',
    'Kylie',
  ];

  final List<String> deliveryTimeOptions = const [
    'Any',
    'Under 20 mins',
    'Under 30 mins',
    'Under 45 mins',
  ];

  final List<String> cuisineOptions = const [
    'North Indian',
    'South Indian',
    'Chinese',
    'Biryani',
    'Fast Food',
    'Desserts',
    'Beverages',
    'Healthy',
  ];

  final List<String> exploreOptions = const [
    'Top Rated',
    'Best Seller',
    'Offers',
    'New Arrivals',
    'Express Delivery',
  ];

  final List<String> ratingOptions = const [
    'Any',
    '4.5+',
    '4.0+',
    '3.5+',
  ];

  final List<String> vegNonVegOptions = const [
    'All',
    'Veg',
    'Non-Veg',
  ];

  final List<String> costForTwoOptions = const [
    'Any',
    'Under 200',
    '200 to 400',
    'Above 400',
  ];

  final List<String> mealTimeOptions = const [
    'Any',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];

  final List<String> spiceLevelOptions = const [
    'Any',
    'Mild',
    'Medium',
    'Spicy',
  ];

  final List<String> portionSizeOptions = const [
    'Any',
    'Single',
    'Sharing',
    'Family',
  ];

  final List<String> dietTypeOptions = const [
    'Any',
    'Balanced',
    'High Protein',
    'Low Carb',
    'Keto',
  ];

  final List<String> prepTimeOptions = const [
    'Any',
    'Under 15 mins',
    'Under 25 mins',
    'Under 40 mins',
  ];

  final RxList<String> recentSearches = <String>[
    'Cold Drinks',
    'Cooking oil',
    'Instant Noodles',
  ].obs;

  final List<Map<String, dynamic>> _allProducts = <Map<String, dynamic>>[
    {
      'name': 'Vibrant Fruit Platter',
      'image': '🍎',
      'seller': 'Philip',
      'rating': '4.9',
      'price': '\$20.78',
      'oldPrice': '\$30.00',
      'category': 'Fruits',
      'stock': 12,
      'isNew': true,
      'deliveryTime': 24,
      'isOneBenefit': true,
      'cuisines': <String>['Healthy', 'Desserts'],
      'exploreTags': <String>['Top Rated', 'Best Seller'],
      'foodType': 'Veg',
      'costForTwo': 280,
      'mealTime': 'Breakfast',
      'spiceLevel': 'Mild',
      'portionSize': 'Sharing',
      'dietType': 'Balanced',
      'prepTime': 12,
      'freeDelivery': true,
    },
    {
      'name': 'Eden\'s Strawberry',
      'image': '🍓',
      'seller': 'Arlene',
      'rating': '4.9',
      'price': '\$26.78',
      'oldPrice': '\$30.00',
      'category': 'Fruits',
      'stock': 5,
      'isNew': false,
      'deliveryTime': 18,
      'isOneBenefit': false,
      'cuisines': <String>['Desserts', 'Healthy'],
      'exploreTags': <String>['Offers', 'Express Delivery'],
      'foodType': 'Veg',
      'costForTwo': 220,
      'mealTime': 'Snacks',
      'spiceLevel': 'Mild',
      'portionSize': 'Single',
      'dietType': 'Low Carb',
      'prepTime': 14,
      'freeDelivery': false,
    },
    {
      'name': 'Sunburst Orange',
      'image': '🍊',
      'seller': 'Warren',
      'rating': '4.7',
      'price': '\$15.50',
      'oldPrice': '\$22.00',
      'category': 'Fruits',
      'stock': 9,
      'isNew': false,
      'deliveryTime': 32,
      'isOneBenefit': true,
      'cuisines': <String>['Beverages', 'Healthy'],
      'exploreTags': <String>['Top Rated', 'Offers'],
      'foodType': 'Veg',
      'costForTwo': 260,
      'mealTime': 'Lunch',
      'spiceLevel': 'Medium',
      'portionSize': 'Sharing',
      'dietType': 'Balanced',
      'prepTime': 24,
      'freeDelivery': true,
    },
    {
      'name': 'Pomegranate',
      'image': '🍇',
      'seller': 'Ferrari',
      'rating': '4.8',
      'price': '\$18.99',
      'oldPrice': '\$24.99',
      'category': 'Fruits',
      'stock': 0,
      'isNew': true,
      'deliveryTime': 29,
      'isOneBenefit': true,
      'cuisines': <String>['Desserts', 'Healthy'],
      'exploreTags': <String>['New Arrivals'],
      'foodType': 'Veg',
      'costForTwo': 310,
      'mealTime': 'Dinner',
      'spiceLevel': 'Mild',
      'portionSize': 'Family',
      'dietType': 'High Protein',
      'prepTime': 30,
      'freeDelivery': true,
    },
    {
      'name': 'Fresh Broccoli',
      'image': '🥦',
      'seller': 'Kylie',
      'rating': '4.6',
      'price': '\$12.50',
      'oldPrice': '\$16.00',
      'category': 'Vegetables',
      'stock': 18,
      'isNew': false,
      'deliveryTime': 16,
      'isOneBenefit': false,
      'cuisines': <String>['South Indian', 'Healthy'],
      'exploreTags': <String>['Express Delivery', 'Offers'],
      'foodType': 'Veg',
      'costForTwo': 180,
      'mealTime': 'Lunch',
      'spiceLevel': 'Medium',
      'portionSize': 'Single',
      'dietType': 'Keto',
      'prepTime': 10,
      'freeDelivery': true,
    },
    {
      'name': 'Orange Juice',
      'image': '🧃',
      'seller': 'Philip',
      'rating': '4.5',
      'price': '\$9.90',
      'oldPrice': '\$12.00',
      'category': 'Beverages',
      'stock': 14,
      'isNew': false,
      'deliveryTime': 21,
      'isOneBenefit': true,
      'cuisines': <String>['Beverages', 'Fast Food'],
      'exploreTags': <String>['Best Seller'],
      'foodType': 'Veg',
      'costForTwo': 150,
      'mealTime': 'Snacks',
      'spiceLevel': 'Mild',
      'portionSize': 'Single',
      'dietType': 'Balanced',
      'prepTime': 8,
      'freeDelivery': false,
    },
    {
      'name': 'Chicken Breast',
      'image': '🍗',
      'seller': 'Warren',
      'rating': '4.4',
      'price': '\$29.00',
      'oldPrice': '\$34.00',
      'category': 'Meat',
      'stock': 7,
      'isNew': true,
      'deliveryTime': 38,
      'isOneBenefit': false,
      'cuisines': <String>['Biryani', 'North Indian'],
      'exploreTags': <String>['Top Rated', 'New Arrivals'],
      'foodType': 'Non-Veg',
      'costForTwo': 460,
      'mealTime': 'Dinner',
      'spiceLevel': 'Spicy',
      'portionSize': 'Family',
      'dietType': 'High Protein',
      'prepTime': 35,
      'freeDelivery': false,
    },
    // ── Auto-generated product entries ────────────────────────────────────
    ...List.generate(93, (i) {
      final cats = ['Fruits', 'Vegetables', 'Beverages', 'Meat'];
      final sellers = ['Philip', 'Arlene', 'Warren', 'Ferrari', 'Kylie'];
      final food = ['Veg', 'Non-Veg'];
      final spice = ['Mild', 'Medium', 'Spicy'];
      final meal = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
      final diet = ['Balanced', 'High Protein', 'Low Carb', 'Keto'];
      final price = 8.0 + (i % 40);
      final old = price + 5 + (i % 10);
      return {
        'name': 'Product ${i + 8}',
        'image': 'https://picsum.photos/300?random=${i + 10}',
        'seller': sellers[i % sellers.length],
        'rating': '${3.5 + (i % 15) * 0.1}',
        'price': '\$$price',
        'oldPrice': '\$$old',
        'category': cats[i % cats.length],
        'stock': i % 5 == 0 ? 0 : 5 + (i % 20),
        'isNew': i % 7 == 0,
        'deliveryTime': 15 + (i % 30),
        'isOneBenefit': i % 3 == 0,
        'cuisines': <String>[],
        'exploreTags': <String>[],
        'foodType': food[i % 2],
        'costForTwo': 150 + (i % 350),
        'mealTime': meal[i % 4],
        'spiceLevel': spice[i % 3],
        'portionSize': 'Single',
        'dietType': diet[i % 4],
        'prepTime': 10 + (i % 30),
        'freeDelivery': i % 4 == 0,
      };
    }),
  ];

  final RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;

  final RxList<bool> favorites = <bool>[].obs;

  // Pagination
  static const int _pageSize = 20;
  final displayedCount = 20.obs;
  final isLoadingMore = false.obs;
  final scrollController = ScrollController();
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    products.assignAll(_allProducts);
    favorites.assignAll(List<bool>.filled(_allProducts.length, false));
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchTextController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final pos = scrollController.position;
    // extentAfter is the remaining scrollable content below the viewport
    if (pos.extentAfter < 400 &&
        !isLoadingMore.value &&
        displayedCount.value < products.length) {
      loadMore();
    }
  }

  Future<void> loadMore() async {
    isLoadingMore.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    displayedCount.value =
        (displayedCount.value + _pageSize).clamp(0, products.length);
    isLoadingMore.value = false;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void clearSearch() {
    searchQuery.value = '';
    searchTextController.clear();
    applyFilters();
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    applyFilters();
  }

  void removeCategory(String category) {
    selectedCategories.remove(category);
    applyFilters();
  }

  void clearRecentSearches() {
    recentSearches.clear();
    Get.snackbar(
      'Cleared',
      'Recent searches cleared',
      duration: const Duration(seconds: 1),
    );
  }

  void selectRecentSearch(String search) {
    searchQuery.value = search;
    applyFilters();
  }

  void removeRecentSearch(String search) {
    recentSearches.remove(search);
  }

  void toggleFavorite(int index) {
    if (index < favorites.length) {
      favorites[index] = !favorites[index];
      if (favoritesOnly.value) {
        applyFilters();
      }
    }
  }

  void addToCart(int index) {
    if (index < products.length) {
      final product = products[index];
      Get.snackbar(
        'Added to Cart',
        '${product['name']} added to your cart',
        duration: const Duration(seconds: 2),
      );
    }
  }

  void updatePriceRange(double min, double max) {
    minPrice.value = min;
    maxPrice.value = max;
  }

  void updateMinRating(double rating) {
    minRating.value = rating;
  }

  void updateInStockOnly(bool value) {
    inStockOnly.value = value;
  }

  void updateDiscountedOnly(bool value) {
    discountedOnly.value = value;
  }

  void updateFavoritesOnly(bool value) {
    favoritesOnly.value = value;
  }

  void updateSelectedSeller(String seller) {
    selectedSeller.value = seller;
  }

  void updateSortBy(String value) {
    sortBy.value = value;
    applyFilters();
  }

  void updateDeliveryTimeFilter(String value) {
    deliveryTimeFilter.value = value;
  }

  void updateOneBenefitsOnly(bool value) {
    oneBenefitsOnly.value = value;
  }

  void toggleCuisine(String cuisine) {
    if (selectedCuisines.contains(cuisine)) {
      selectedCuisines.remove(cuisine);
    } else {
      selectedCuisines.add(cuisine);
    }
  }

  void toggleExploreTag(String tag) {
    if (selectedExploreTags.contains(tag)) {
      selectedExploreTags.remove(tag);
    } else {
      selectedExploreTags.add(tag);
    }
  }

  void updateRatingFilter(String value) {
    ratingFilter.value = value;
  }

  void updateVegNonVegFilter(String value) {
    vegNonVegFilter.value = value;
  }

  void updateCostForTwoFilter(String value) {
    costForTwoFilter.value = value;
  }

  void updateMealTimeFilter(String value) {
    mealTimeFilter.value = value;
  }

  void updateSpiceLevelFilter(String value) {
    spiceLevelFilter.value = value;
  }

  void updatePortionSizeFilter(String value) {
    portionSizeFilter.value = value;
  }

  void updateDietTypeFilter(String value) {
    dietTypeFilter.value = value;
  }

  void updatePrepTimeFilter(String value) {
    prepTimeFilter.value = value;
  }

  void updateFreeDeliveryOnly(bool value) {
    freeDeliveryOnly.value = value;
  }

  void updateNewArrivalsOnly(bool value) {
    newArrivalsOnly.value = value;
  }

  void logSelectedFiltersAndResults() {
    debugPrint('---------- Applied Filters ----------');
    debugPrint('Sort: ${sortBy.value}');
    debugPrint('Delivery Time: ${deliveryTimeFilter.value}');
    debugPrint(
        'ONE Benefits: ${oneBenefitsOnly.value ? 'Only ONE benefit items' : 'All'}');
    debugPrint(
        'Cuisines: ${selectedCuisines.isEmpty ? 'Any' : selectedCuisines.join(', ')}');
    debugPrint(
        'Explore: ${selectedExploreTags.isEmpty ? 'Any' : selectedExploreTags.join(', ')}');
    debugPrint('Ratings: ${ratingFilter.value}');
    debugPrint('Veg/Non-Veg: ${vegNonVegFilter.value}');
    debugPrint('Cost for Two: ${costForTwoFilter.value}');
    debugPrint('Seller: ${selectedSeller.value}');
    debugPrint('In Stock Only: ${inStockOnly.value}');
    debugPrint('Discounted Only: ${discountedOnly.value}');
    debugPrint('Favorites Only: ${favoritesOnly.value}');
    debugPrint(
        'Price Range: ${minPrice.value.toStringAsFixed(0)} - ${maxPrice.value.toStringAsFixed(0)}');
    debugPrint('Meal Time: ${mealTimeFilter.value}');
    debugPrint('Spice Level: ${spiceLevelFilter.value}');
    debugPrint('Portion Size: ${portionSizeFilter.value}');
    debugPrint('Diet Type: ${dietTypeFilter.value}');
    debugPrint('Prep Time: ${prepTimeFilter.value}');
    debugPrint('Free Delivery Only: ${freeDeliveryOnly.value}');
    debugPrint('New Arrivals Only: ${newArrivalsOnly.value}');
    debugPrint(
        'Categories: ${selectedCategories.isEmpty ? 'Any' : selectedCategories.join(', ')}');
    debugPrint('Total Results: ${products.length}');
    debugPrint('Result Names: ${products.map((e) => e['name']).join(', ')}');
    debugPrint('-------------------------------------');
  }

  void applyFilters() {
    final String query = searchQuery.value.trim().toLowerCase();

    final List<Map<String, dynamic>> filtered = _allProducts.where((product) {
      final String name = (product['name'] as String? ?? '').toLowerCase();
      final String seller = (product['seller'] as String? ?? '');
      final String category = (product['category'] as String? ?? '');
      final double rating = _parseDouble(product['rating']);
      final double price = _parseMoney(product['price']);
      final double oldPrice = _parseMoney(product['oldPrice']);
      final int stock = product['stock'] as int? ?? 0;
      final int deliveryTime = product['deliveryTime'] as int? ?? 999;
      final bool hasOneBenefit = product['isOneBenefit'] as bool? ?? false;
      final List<dynamic> cuisinesRaw =
          product['cuisines'] as List<dynamic>? ?? <dynamic>[];
      final List<dynamic> exploreRaw =
          product['exploreTags'] as List<dynamic>? ?? <dynamic>[];
      final String foodType = product['foodType'] as String? ?? 'Veg';
      final int costForTwo = product['costForTwo'] as int? ?? 0;
      final String mealTime = product['mealTime'] as String? ?? 'Lunch';
      final String spiceLevel = product['spiceLevel'] as String? ?? 'Mild';
      final String portionSize = product['portionSize'] as String? ?? 'Single';
      final String dietType = product['dietType'] as String? ?? 'Balanced';
      final int prepTime = product['prepTime'] as int? ?? 999;
      final bool freeDelivery = product['freeDelivery'] as bool? ?? false;
      final bool isNew = product['isNew'] as bool? ?? false;

      final List<String> cuisines =
          cuisinesRaw.map((e) => e.toString()).toList();
      final List<String> exploreTags =
          exploreRaw.map((e) => e.toString()).toList();

      final bool matchesQuery = query.isEmpty || name.contains(query);
      final bool matchesCategory =
          selectedCategories.isEmpty || selectedCategories.contains(category);
      final bool matchesRating = rating >= minRating.value;
      final bool matchesPrice =
          price >= minPrice.value && price <= maxPrice.value;
      final bool matchesStock = !inStockOnly.value || stock > 0;
      final bool hasDiscount = oldPrice > price;
      final bool matchesDiscount = !discountedOnly.value || hasDiscount;
      final bool matchesSeller =
          selectedSeller.value == 'All' || selectedSeller.value == seller;

      final bool matchesDeliveryTime = _matchesDeliveryTime(deliveryTime);
      final bool matchesOneBenefits = !oneBenefitsOnly.value || hasOneBenefit;
      final bool matchesCuisine = selectedCuisines.isEmpty ||
          selectedCuisines.any((selected) => cuisines.contains(selected));
      final bool matchesExplore = selectedExploreTags.isEmpty ||
          selectedExploreTags.any((selected) => exploreTags.contains(selected));
      final bool matchesRatingFilter = _matchesRatingFilter(rating);
      final bool matchesVegNonVeg =
          vegNonVegFilter.value == 'All' || vegNonVegFilter.value == foodType;
      final bool matchesCostForTwo = _matchesCostForTwo(costForTwo);
      final bool matchesMealTime =
          mealTimeFilter.value == 'Any' || mealTimeFilter.value == mealTime;
      final bool matchesSpiceLevel = spiceLevelFilter.value == 'Any' ||
          spiceLevelFilter.value == spiceLevel;
      final bool matchesPortionSize = portionSizeFilter.value == 'Any' ||
          portionSizeFilter.value == portionSize;
      final bool matchesDietType =
          dietTypeFilter.value == 'Any' || dietTypeFilter.value == dietType;
      final bool matchesPrepTime = _matchesPrepTime(prepTime);
      final bool matchesFreeDelivery = !freeDeliveryOnly.value || freeDelivery;
      final bool matchesNewArrivals = !newArrivalsOnly.value || isNew;

      return matchesQuery &&
          matchesCategory &&
          matchesRating &&
          matchesPrice &&
          matchesStock &&
          matchesDiscount &&
          matchesSeller &&
          matchesDeliveryTime &&
          matchesOneBenefits &&
          matchesCuisine &&
          matchesExplore &&
          matchesRatingFilter &&
          matchesVegNonVeg &&
          matchesCostForTwo &&
          matchesMealTime &&
          matchesSpiceLevel &&
          matchesPortionSize &&
          matchesDietType &&
          matchesPrepTime &&
          matchesFreeDelivery &&
          matchesNewArrivals;
    }).toList();

    if (favoritesOnly.value) {
      final Set<String> favoriteNames = <String>{};
      for (int i = 0; i < _allProducts.length && i < favorites.length; i++) {
        if (favorites[i]) {
          favoriteNames.add(_allProducts[i]['name'] as String? ?? '');
        }
      }
      filtered.removeWhere(
        (product) => !favoriteNames.contains(product['name'] as String? ?? ''),
      );
    }

    _sortProducts(filtered);
    products.assignAll(filtered);
    // Reset pagination whenever filter results change
    displayedCount.value = _pageSize;
  }

  void resetFilters() {
    selectedCategories.clear();
    minRating.value = 0.0;
    inStockOnly.value = false;
    discountedOnly.value = false;
    favoritesOnly.value = false;
    selectedSeller.value = 'All';
    sortBy.value = 'Relevance';
    minPrice.value = 0.0;
    maxPrice.value = 50.0;
    deliveryTimeFilter.value = 'Any';
    oneBenefitsOnly.value = false;
    selectedCuisines.clear();
    selectedExploreTags.clear();
    ratingFilter.value = 'Any';
    vegNonVegFilter.value = 'All';
    costForTwoFilter.value = 'Any';
    mealTimeFilter.value = 'Any';
    spiceLevelFilter.value = 'Any';
    portionSizeFilter.value = 'Any';
    dietTypeFilter.value = 'Any';
    prepTimeFilter.value = 'Any';
    freeDeliveryOnly.value = false;
    newArrivalsOnly.value = false;
    applyFilters();
  }

  void _sortProducts(List<Map<String, dynamic>> items) {
    switch (sortBy.value) {
      case 'Price: Low to High':
        items.sort((a, b) =>
            _parseMoney(a['price']).compareTo(_parseMoney(b['price'])));
        break;
      case 'Price: High to Low':
        items.sort((a, b) =>
            _parseMoney(b['price']).compareTo(_parseMoney(a['price'])));
        break;
      case 'Rating: High to Low':
        items.sort((a, b) =>
            _parseDouble(b['rating']).compareTo(_parseDouble(a['rating'])));
        break;
      case 'Delivery Time':
        items.sort(
          (a, b) => (a['deliveryTime'] as int? ?? 999)
              .compareTo(b['deliveryTime'] as int? ?? 999),
        );
        break;
      case 'Discount: High to Low':
        items.sort((a, b) {
          final double discountA =
              _parseMoney(a['oldPrice']) - _parseMoney(a['price']);
          final double discountB =
              _parseMoney(b['oldPrice']) - _parseMoney(b['price']);
          return discountB.compareTo(discountA);
        });
        break;
      default:
        break;
    }
  }

  double _parseMoney(dynamic value) {
    final String source = value?.toString() ?? '0';
    final String normalized = source.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(normalized) ?? 0.0;
  }

  double _parseDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '0') ?? 0.0;
  }

  bool _matchesDeliveryTime(int deliveryTime) {
    switch (deliveryTimeFilter.value) {
      case 'Under 20 mins':
        return deliveryTime <= 20;
      case 'Under 30 mins':
        return deliveryTime <= 30;
      case 'Under 45 mins':
        return deliveryTime <= 45;
      default:
        return true;
    }
  }

  bool _matchesRatingFilter(double rating) {
    switch (ratingFilter.value) {
      case '4.5+':
        return rating >= 4.5;
      case '4.0+':
        return rating >= 4.0;
      case '3.5+':
        return rating >= 3.5;
      default:
        return true;
    }
  }

  bool _matchesCostForTwo(int cost) {
    switch (costForTwoFilter.value) {
      case 'Under 200':
        return cost < 200;
      case '200 to 400':
        return cost >= 200 && cost <= 400;
      case 'Above 400':
        return cost > 400;
      default:
        return true;
    }
  }

  bool _matchesPrepTime(int prepTime) {
    switch (prepTimeFilter.value) {
      case 'Under 15 mins':
        return prepTime <= 15;
      case 'Under 25 mins':
        return prepTime <= 25;
      case 'Under 40 mins':
        return prepTime <= 40;
      default:
        return true;
    }
  }
}
