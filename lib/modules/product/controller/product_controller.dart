import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/controller/cart_controller.dart';
import '../../../data/models/product_model.dart';
import '../../../shared/widgets/app_toast.dart';

class ProductController extends GetxController {
  final selectedSize = ''.obs;
  final selectedColor = ''.obs;
  final selectedCategory = ''.obs;
  final selectedImageIndex = 0.obs;
  final quantity = 1.obs;
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
    'ratingBreakdown': {
      '5': 72,
      '4': 18,
      '3': 6,
      '2': 2,
      '1': 2,
    },
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
    'inStock': true,
    'features': [
      'Active Noise Cancellation',
      '30-hour battery life',
      'Premium Sound Quality',
      'Bluetooth 5.0',
      'Comfortable Design'
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
    final sizes = (product['sizes'] as List?) ?? [];
    final colors = (product['colors'] as List?) ?? [];
    final categories = (product['categories'] as List?) ?? [];

    if (sizes.isNotEmpty) {
      selectedSize.value = sizes.first.toString();
    }
    if (colors.isNotEmpty) {
      selectedColor.value = colors.first.toString();
    }
    if (categories.isNotEmpty) {
      selectedCategory.value = categories.first.toString();
    }
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
    if (quantity.value < 10) {
      quantity.value++;
    }
  }

  void decreaseQty() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart() {
    if (selectedColor.isEmpty) {
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

    final productName = (productData['name'] ?? 'Product').toString();
    AppToast.successToast('$productName added in cart');
  }
}
