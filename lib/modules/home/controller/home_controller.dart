import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/controller/cart_controller.dart';
import '../../../shared/widgets/app_toast.dart';

class HomeController extends GetxController {
  final selectedCategoryIndex = 0.obs;
  final searchQuery = ''.obs;
  final currentBannerIndex = 0.obs;
  final isDrawerOpen = false.obs;
  final currentHintIndex = 0.obs;
  late PageController bannerPageController;
  Timer? _bannerTimer;
  Timer? _hintTimer;

  static const _searchHints = [
    'Search earphones...',
    'Search watches...',
    'Search sneakers...',
    'Search clothing...',
    'Search electronics...',
    'Search accessories...',
  ];

  String get currentSearchHint => _searchHints[currentHintIndex.value];

  @override
  void onInit() {
    super.onInit();
    bannerPageController = PageController(viewportFraction: 1);
    _startBannerAutoSlide();
    _startHintCycling();
  }

  void _startHintCycling() {
    _hintTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      currentHintIndex.value =
          (currentHintIndex.value + 1) % _searchHints.length;
    });
  }

  void _startBannerAutoSlide() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!bannerPageController.hasClients || banners.isEmpty) {
        return;
      }
      final next = (currentBannerIndex.value + 1) % banners.length;
      bannerPageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void onClose() {
    _bannerTimer?.cancel();
    _hintTimer?.cancel();
    bannerPageController.dispose();
    super.onClose();
  }

  final categories = [
    {
      'name': 'Dresses',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpQQJkX4QxVH-28D1eFJ_RP7evdCNcec4wTA9wDIUwlw&s=10',
    },
    {
      'name': 'Shoes',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQp1r-hUHhLxHH_FzhvaaLdVER5q7-25qL9Acruqmw8aQ&s=10',
    },
    {
      'name': 'Bags',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIJ4tsK-5-am7SRNPPnw4HNrBxOLFQOv0ihrH2AhNTCA&s=10',
    },
    {
      'name': 'Watches',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7JjYbO4WJg6QXPLdvkdg16La0KeBP5cBXq0lyO_Y2iw&s=10',
    },
    {
      'name': 'Jewelry',
      'image':
          'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=200',
    },
    {
      'name': 'Beauty',
      'image':
          'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=200',
    },
    {
      'name': 'Accessories',
      'image':
          'https://images.unsplash.com/photo-1556306535-0f09a537f0a3?w=200',
    },
    {
      'name': 'Sports',
      'image':
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200',
    },
  ].obs;

  final banners = [
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      'title': '',
      'subtitle': 'Crafted cuts for your premium wardrobe',
      'color1': const Color(0xFFD884A7),
      'color2': const Color(0xFFC66D98),
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
      'title': 'Summer Collection 50% Off',
      'subtitle': 'Breathable fits, bright days, better prices',
      'color1': const Color(0xFFD884A7),
      'color2': const Color(0xFFC66D98),
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      'title': 'New Fashion Arrivals',
      'subtitle': 'Fresh drops curated by style experts',
      'color1': const Color(0xFFD884A7),
      'color2': const Color(0xFFC66D98),
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      'title': 'Luxury Collection',
      'subtitle': 'Timeless silhouettes with a modern edge',
      'color1': const Color(0xFFD884A7),
      'color2': const Color(0xFFC66D98),
    },
  ].obs;

  void openDrawer() {
    isDrawerOpen.value = true;
  }

  void closeDrawer() {
    isDrawerOpen.value = false;
  }

  final featuredProducts = <Map<String, dynamic>>[
    {
      'id': '1',
      'name':
          'Premium Wireless Headphones Premium Wireless Headphones Premium Wireless Headphones Premium Wireless Headphones',
      'price': 3999,
      'originalPrice': 5999,
      'rating': 4.5,
      'reviewCount': 128,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      'category': 'Electronics',
      'isWishlisted': false,
    },
    {
      'id': '2',
      'name': 'Smart Watch Ultra',
      'price': 8999,
      'originalPrice': 12999,
      'rating': 4.8,
      'reviewCount': 245,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
      'category': 'Electronics',
      'isWishlisted': false,
    },
    {
      'id': '3',
      'name': 'Designer T-Shirt',
      'price': 799,
      'originalPrice': 1299,
      'rating': 4.3,
      'reviewCount': 89,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      'category': 'Fashion',
      'isWishlisted': false,
    },
    {
      'id': '4',
      'name': 'Organic Face Cream',
      'price': 599,
      'originalPrice': 899,
      'rating': 4.6,
      'reviewCount': 156,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      'category': 'Beauty',
      'isWishlisted': false,
    },
    {
      'id': '5',
      'name': 'Organic Face Cream',
      'price': 599,
      'originalPrice': 899,
      'rating': 4.6,
      'reviewCount': 156,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      'category': 'Beauty',
      'isWishlisted': false,
    },
    {
      'id': '6',
      'name': 'Organic Face Cream',
      'price': 599,
      'originalPrice': 899,
      'rating': 4.6,
      'reviewCount': 156,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
      'category': 'Beauty',
      'isWishlisted': false,
    },
    {
      'id': '7',
      'name': 'Organic Face Cream',
      'price': 599,
      'originalPrice': 899,
      'rating': 4.6,
      'reviewCount': 156,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      'category': 'Beauty',
      'isWishlisted': false,
    },
    {
      'id': '8',
      'name': 'Organic Face Cream',
      'price': 599,
      'originalPrice': 899,
      'rating': 4.6,
      'reviewCount': 156,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      'category': 'Beauty',
      'isWishlisted': false,
    },
  ].obs;

  // Offers data — add 'route' to redirect on tap
  final offers = <Map<String, dynamic>>[
    {
      'title': 'Diwali Mega Sale',
      'subtitle': 'Up to 70% off on premium picks',
      'discount': '70%',
      'code': 'DIWALI70',
      'icon': Icons.local_fire_department_rounded,
      'colors': [const Color(0xFFFF6B35), const Color(0xFFE8395A)],
      'route': '/products',
    },
    {
      'title': 'Festival Cashback',
      'subtitle': 'Flat ₹300 back on prepaid orders',
      'discount': '₹300',
      'code': 'FEST300',
      'icon': Icons.card_giftcard_rounded,
      'colors': [const Color(0xFF5B4DCC), const Color(0xFFC850C0)],
      'route': '/specialOffers',
    },
    {
      'title': 'Flash Deals',
      'subtitle': 'Buy 2 Get 1 Free on selected items',
      'discount': 'B2G1',
      'code': 'FLASH21',
      'icon': Icons.bolt_rounded,
      'colors': [const Color(0xFF0B6B43), const Color(0xFF37C87A)],
      'route': '/products',
    },
  ].obs;

  // Promo banner data — add 'route' to redirect on tap
  final promos = <Map<String, dynamic>>[
    {
      'title': 'Mega Fashion Sale',
      'subtitle': 'Exclusive deals on top brands',
      'discount': '50',
      'tag': 'TODAY ONLY',
      'gradient': [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)],
      'accent': const Color(0xFFFFD93D),
      'route': '/products',
    },
    {
      'title': 'Electronics Fest',
      'subtitle': 'Latest gadgets at best prices',
      'discount': '40',
      'tag': 'LIMITED',
      'gradient': [const Color(0xFF4776E6), const Color(0xFF8E54E9)],
      'accent': const Color(0xFF7FFFFF),
      'route': '/products',
    },
    {
      'title': 'Home Decor Week',
      'subtitle': 'Transform your living space',
      'discount': '60',
      'tag': 'FLASH SALE',
      'gradient': [const Color(0xFF0B6B43), const Color(0xFF56AB2F)],
      'accent': const Color(0xFFFFE55B),
      'route': '/products',
    },
  ].obs;

  // Set showEmergencyBanner = true and fill message to display a notice below the slider
  final emergencyMessage =
      '🚚 Delivery delays expected in some areas. Orders may take 1-2 extra days.'
          .obs;
  final showEmergencyBanner = true.obs;

  List<Map<String, dynamic>> get topProducts =>
      featuredProducts.take(4).toList();

  List<Map<String, dynamic>> get recentViewedProducts =>
      featuredProducts.reversed.take(4).toList();

  List<Map<String, dynamic>> get topRatedProducts {
    final items = List<Map<String, dynamic>>.from(featuredProducts);
    items.sort(
      (a, b) =>
          ((b['rating'] as num?) ?? 0).compareTo((a['rating'] as num?) ?? 0),
    );
    return items.take(4).toList();
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void toggleWishlist(int index) {
    final product = featuredProducts[index];
    final isWishlisted = !(product['isWishlisted'] == true);
    product['isWishlisted'] = isWishlisted;
    featuredProducts.refresh();

    final name = (product['name'] ?? 'Product').toString();
    AppToast.successToast(
      isWishlisted ? '$name added in wishlist' : '$name removed from wishlist',
    );
  }

  void onProductTap(String productId) {
    Get.toNamed('/productDetails', arguments: productId);
  }

  void onAddToCart(String productId) {
    final productMap = featuredProducts.firstWhereOrNull(
      (item) => item['id'].toString() == productId,
    );

    if (productMap == null) {
      AppToast.errorToast('Product not found');
      return;
    }

    CartController.ensureInitialized().addMapProductToCart(productMap);
    final name = (productMap['name'] ?? 'Product').toString();
    AppToast.successToast('$name added in cart');
  }
}
