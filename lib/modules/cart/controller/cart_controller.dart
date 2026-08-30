import 'package:get/get.dart';
import '../../../data/models/cart_model.dart';
import '../../../data/models/product_model.dart';
import '../../coupon/controller/coupon_controller.dart';

class CartController extends GetxController {
  static CartController ensureInitialized() {
    if (Get.isRegistered<CartController>()) {
      return Get.find<CartController>();
    }

    return Get.put(CartController(), permanent: true);
  }

  final cartItems = <CartItem>[].obs;
  final appliedCoupon = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    if (cartItems.isEmpty) {
      addDefaultItems();
    }
  }

  void addDefaultItems() {
    final defaultProducts = [
      Product(
        id: '1',
        name: 'Premium Wireless Headphones',
        description: 'High-quality wireless headphones with noise cancellation',
        price: 89.99,
        originalPrice: 129.99,
        rating: 4.5,
        reviewCount: 234,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
        images: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10'
        ],
        category: 'Electronics',
        subCategory: 'Audio',
        stock: 15,
        sizes: const [],
        colors: const ['Black', 'Silver'],
      ),
      Product(
        id: '2',
        name: 'Designer T-Shirt',
        description: 'Comfortable and stylish cotton t-shirt',
        price: 34.99,
        originalPrice: 49.99,
        rating: 4.3,
        reviewCount: 156,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
        images: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10'
        ],
        category: 'Fashion',
        subCategory: 'Men',
        stock: 50,
        sizes: const ['S', 'M', 'L', 'XL'],
        colors: const ['White', 'Black', 'Blue'],
      ),
      Product(
        id: '3',
        name: 'Leather Wallet',
        description: 'Premium genuine leather wallet with RFID protection',
        price: 59.99,
        originalPrice: 79.99,
        rating: 4.7,
        reviewCount: 89,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
        images: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10'
        ],
        category: 'Accessories',
        subCategory: 'Wallets',
        stock: 25,
        sizes: const [],
        colors: const ['Brown', 'Black'],
      ),
      Product(
        id: '4',
        name: 'Running Shoes',
        description: 'Lightweight running shoes with cushioned sole',
        price: 124.99,
        originalPrice: 169.99,
        rating: 4.6,
        reviewCount: 342,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
        images: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10'
        ],
        category: 'Footwear',
        subCategory: 'Sports',
        stock: 30,
        sizes: const ['6', '7', '8', '9', '10', '11'],
        colors: const ['Black', 'White', 'Red'],
      ),
      Product(
        id: '5',
        name: 'Stainless Steel Watch',
        description: 'Elegant analog watch with leather strap',
        price: 199.99,
        originalPrice: 299.99,
        rating: 4.8,
        reviewCount: 127,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
        images: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10'
        ],
        category: 'Accessories',
        subCategory: 'Watches',
        stock: 18,
        sizes: const [],
        colors: const ['Silver', 'Gold'],
      ),
    ];

    for (var product in defaultProducts) {
      cartItems.add(
        CartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString() + product.id,
          product: product,
          quantity: 1,
          selectedSize: '',
          selectedColor: '',
        ),
      );
    }
  }

  void addToCart(
    Product product, {
    String size = '',
    String color = '',
    int quantity = 1,
  }) {
    if (quantity <= 0) {
      return;
    }

    final existingIndex = cartItems.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      cartItems[existingIndex] = cartItems[existingIndex].copyWith(
        quantity: cartItems[existingIndex].quantity + quantity,
      );
    } else {
      cartItems.add(
        CartItem(
          id: DateTime.now().toString(),
          product: product,
          quantity: quantity,
          selectedSize: size,
          selectedColor: color,
        ),
      );
    }
    Get.snackbar('Success', 'Product added to cart');
  }

  void addMapProductToCart(Map<String, dynamic> productMap) {
    final parsedPrice = (productMap['price'] as num?)?.toDouble() ?? 0;
    final parsedOriginalPrice =
        (productMap['originalPrice'] as num?)?.toDouble() ?? parsedPrice;
    final parsedRating = (productMap['rating'] as num?)?.toDouble() ?? 4.2;
    final parsedReview = (productMap['reviewCount'] as num?)?.toInt() ?? 0;
    final image = (productMap['image'] as String?) ?? '';

    final product = Product(
      id: (productMap['id'] ?? DateTime.now().toString()).toString(),
      name: (productMap['name'] ?? 'Product').toString(),
      description: (productMap['description'] ?? 'Demo product').toString(),
      price: parsedPrice,
      originalPrice: parsedOriginalPrice,
      rating: parsedRating,
      reviewCount: parsedReview,
      image: image,
      images: image.isNotEmpty ? <String>[image] : const <String>[],
      category: (productMap['category'] ?? 'General').toString(),
      subCategory: (productMap['subCategory'] ?? 'General').toString(),
      stock: (productMap['stock'] as num?)?.toInt() ?? 50,
      sizes: const <String>[],
      colors: const <String>[],
    );

    addToCart(product);
  }

  void removeFromCart(String itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(itemId);
      return;
    }
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(quantity: quantity);
    }
  }

  void applyCoupon(String code) {
    appliedCoupon.value = code;
    Get.snackbar('Success', 'Coupon applied');
  }

  // Reads applied coupon from CouponController and computes % discount
  double get couponDiscount {
    try {
      if (!Get.isRegistered<CouponController>()) return 0;
      final cc = Get.find<CouponController>();
      final code = cc.appliedCouponCode.value;
      if (code.isEmpty) return 0;
      final coupon = cc.coupons.firstWhere(
        (c) => c['code'] == code,
        orElse: () => <String, dynamic>{},
      );
      if (coupon.isEmpty) return 0;
      final pct = double.tryParse(
            (coupon['discount'] as String? ?? '')
                .replaceAll(RegExp(r'[^0-9.]'), ''),
          ) ??
          0;
      return subtotal * pct / 100;
    } catch (_) {
      return 0;
    }
  }

  double get subtotal => cartItems.fold(0, (sum, item) => sum + item.subtotal);
  double get tax => subtotal * 0.18;
  double get total => subtotal + tax + 50;

  int get itemCount => cartItems.fold<int>(
      0, (sum, item) => sum + (item.quantity > 0 ? item.quantity : 0));
}
