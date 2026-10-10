import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/controller/cart_controller.dart';
import '../../wishlist/controller/wishlist_controller.dart';
import '../../../data/models/product_model.dart';
import '../../../shared/widgets/app_toast.dart';

class ProductDetailsController extends GetxController {
  final selectedSize = ''.obs;
  final selectedColor = ''.obs;
  final selectedCategory = ''.obs;
  final selectedImageIndex = 0.obs;
  final quantity = 1.obs;
  final isWishlisted = false.obs;
  final PageController imagePageController = PageController();

  final product = {
    'id': '1',
    'name': 'Premium Wireless Headphones',
    'brand': 'SonicWave',
    'categories': ['Electronics', 'Audio', 'Accessories'],
    'price': 3999.0,
    'originalPrice': 5999.0,
    'rating': 4.5,
    'reviewCount': 1280,
    'ratingBreakdown': {'5': 72, '4': 18, '3': 6, '2': 2, '1': 2},
    'description':
        'Premium quality wireless headphones with active noise cancellation, 30-hour battery life, and premium sound quality.',
    'images': [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
    ],
    'sizes': ['One Size'],
    'colors': ['Black', 'Silver', 'Gold'],
    'delivery': 'Free delivery by Tomorrow',
    'seller': 'RetailNet Official',
    'sellerCertified': null,
    'isBestSeller': false,
    'sellerCertificates': [
      {
        'title': 'GST registration',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
        'isDemo': true,
      },
      {'title': 'FSSAI license', 'isDemo': true},
      {'title': 'Other seller certificate', 'isDemo': true},
    ],
    'inStock': true,
    'features': [
      'Active Noise Cancellation',
      '30-hour battery life',
      'Premium Sound Quality',
      'Bluetooth 5.0',
      'Comfortable Design',
    ],
    'benefits': [
      'Delivers immersive audio with deep bass and clear vocals.',
      'Comfort-fit ear cushions for long listening sessions.',
      'Long battery life for uninterrupted daily usage.',
    ],
    'howToUse': [
      'Charge fully before first use.',
      'Press and hold power button for 3 seconds to turn on.',
      'Pair with your phone via Bluetooth settings.',
      'Use touch controls on ear-cup for music and calls.',
    ],
    'ingredients': [
      'ABS polymer body',
      'Protein leather ear cushions',
      '40mm dynamic audio drivers',
      'Rechargeable lithium battery',
    ],
    'warnings': [
      'Avoid exposure to water and high moisture.',
      'Do not use at very high volume for long duration.',
      'Keep away from direct heat and fire.',
    ],
    'relatedProducts': [
      {
        'name': 'BassPro Earbuds',
        'price': 2499,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      },
      {
        'name': 'Travel Headset X2',
        'price': 3299,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      },
      {
        'name': 'Studio Mic Lite',
        'price': 1899,
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      },
    ],
    'reviews': [
      {
        'name': 'Rahul S.',
        'rating': 5,
        'comment':
            'Amazing sound clarity and battery backup. Value for money purchase.',
      },
      {
        'name': 'Neha K.',
        'rating': 4,
        'comment':
            'Very comfortable for long use. Noise cancellation works really well.',
      },
    ],
  }.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is Map) {
      _loadProduct(arguments);
    }
    final sizes = (product['sizes'] as List?) ?? [];
    final colors = (product['colors'] as List?) ?? [];
    final categories = (product['categories'] as List?) ?? [];

    if (sizes.isNotEmpty) selectedSize.value = sizes.first.toString();
    if (colors.isNotEmpty) selectedColor.value = colors.first.toString();
    if (categories.isNotEmpty) {
      selectedCategory.value = categories.first.toString();
    }
    isWishlisted.value = WishlistController.ensureInitialized()
        .isWishlisted(product['id'].toString());
  }

  void _loadProduct(Map arguments) {
    double parsePrice(dynamic value, [double fallback = 0]) {
      if (value is num) return value.toDouble();
      return double.tryParse(
            (value ?? '').toString().replaceAll(RegExp(r'[^0-9.]'), ''),
          ) ??
          fallback;
    }

    List<dynamic> asList(dynamic value) =>
        value is List ? List<dynamic>.from(value) : <dynamic>[];

    final price = parsePrice(arguments['price']);
    final originalPrice =
        parsePrice(arguments['originalPrice'] ?? arguments['oldPrice'], price);
    final image = arguments['image']?.toString() ?? '';
    final rawImages = asList(arguments['images']);
    final images = rawImages.isNotEmpty
        ? rawImages
        : image.isNotEmpty
            ? <dynamic>[image]
            : asList(product['images']);
    final rawCategories = asList(arguments['categories']);
    final categories = rawCategories.isNotEmpty
        ? rawCategories
        : <dynamic>[arguments['category']?.toString() ?? 'General'];
    final stock = arguments['stock'];
    final certificationValue =
        arguments['sellerCertified'] ?? arguments['isSellerCertified'];
    final bestSellerValue =
        arguments['isBestSeller'] ?? arguments['bestSeller'];

    product.addAll({
      'id':
          (arguments['id'] ?? DateTime.now().microsecondsSinceEpoch).toString(),
      'name': arguments['name']?.toString() ?? 'Product',
      'brand': arguments['brand']?.toString() ??
          arguments['seller']?.toString() ??
          'Store',
      'categories': categories,
      'price': price,
      'originalPrice': originalPrice,
      'rating': parsePrice(arguments['rating'], 4.0),
      'reviewCount': (arguments['reviewCount'] as num?)?.toInt() ?? 0,
      'ratingBreakdown': arguments['ratingBreakdown'] is Map
          ? arguments['ratingBreakdown']
          : <String, int>{},
      'description': arguments['description']?.toString() ??
          'Product details are available from the seller.',
      'images': images,
      'sizes': asList(arguments['sizes']),
      'colors': asList(arguments['colors']),
      'delivery':
          arguments['delivery']?.toString() ?? 'Delivery within 5-7 days',
      'seller': arguments['seller']?.toString() ?? 'Verified seller',
      'sellerCertified': certificationValue is bool ? certificationValue : null,
      'isBestSeller': bestSellerValue == true,
      'sellerCertificates': asList(
        arguments['sellerCertificates'] ?? product['sellerCertificates'],
      ),
      'inStock':
          arguments['inStock'] as bool? ?? ((stock as num?)?.toInt() ?? 1) > 0,
      'features': asList(arguments['features']),
      'benefits': asList(arguments['benefits']),
      'howToUse': asList(arguments['howToUse']),
      'ingredients': asList(arguments['ingredients']),
      'warnings': asList(arguments['warnings']),
      'relatedProducts': asList(arguments['relatedProducts']),
      'reviews': asList(arguments['reviews']),
    });
  }

  @override
  void onClose() {
    imagePageController.dispose();
    super.onClose();
  }

  void selectImage(int index) {
    selectedImageIndex.value = index;
    imagePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void increaseQty() {
    if (quantity.value < 10) quantity.value++;
  }

  void decreaseQty() {
    if (quantity.value > 1) quantity.value--;
  }

  void addToCart() {
    final colors = (product['colors'] as List?) ?? const [];
    if (colors.isNotEmpty && selectedColor.isEmpty) {
      AppToast.errorToast('Please select a color');
      return;
    }

    final productData = product;
    final price = (productData['price'] as num?)?.toDouble() ?? 0;
    final originalPrice =
        (productData['originalPrice'] as num?)?.toDouble() ?? price;

    final cartProduct = Product(
      id: (productData['id'] ?? DateTime.now().toString()).toString(),
      name: (productData['name'] ?? 'Product').toString(),
      description:
          (productData['description'] ?? 'Product description').toString(),
      price: price,
      originalPrice: originalPrice,
      rating: (productData['rating'] as num?)?.toDouble() ?? 4.2,
      reviewCount: (productData['reviewCount'] as num?)?.toInt() ?? 0,
      image: ((productData['images'] as List?)?.isNotEmpty ?? false)
          ? (productData['images'] as List).first.toString()
          : '',
      images: ((productData['images'] as List?) ?? const <dynamic>[])
          .map((e) => e.toString())
          .toList(),
      category: selectedCategory.value,
      subCategory: selectedCategory.value,
      stock: 100,
      sizes: ((productData['sizes'] as List?) ?? const <dynamic>[])
          .map((e) => e.toString())
          .toList(),
      colors: ((productData['colors'] as List?) ?? const <dynamic>[])
          .map((e) => e.toString())
          .toList(),
    );

    CartController.ensureInitialized().addToCart(
      cartProduct,
      size: selectedSize.value,
      color: selectedColor.value,
      quantity: quantity.value,
    );
  }

  void toggleWishlist() {
    final wishlist = WishlistController.ensureInitialized();
    wishlist.toggleProduct(Map<String, dynamic>.from(product));
    isWishlisted.value = wishlist.isWishlisted(product['id'].toString());
  }

  void buyNow() {
    final colors = (product['colors'] as List?) ?? const [];
    if (colors.isNotEmpty && selectedColor.isEmpty) {
      AppToast.errorToast('Please select a color');
      return;
    }
    addToCart();
    Get.toNamed('/checkout');
  }
}
