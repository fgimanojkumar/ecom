import 'package:get/get.dart';
import '../../../data/models/cart_model.dart';
import '../../../data/models/product_model.dart';
import '../../coupon/controller/coupon_controller.dart';
import '../../../shared/widgets/app_toast.dart';

class CartController extends GetxController {
  static const double shippingCharge = 50.0;
  static const double taxRate = 0.18;

  static CartController ensureInitialized() {
    if (Get.isRegistered<CartController>()) {
      return Get.find<CartController>();
    }

    return Get.put(CartController(), permanent: true);
  }

  final cartItems = <CartItem>[].obs;
  final appliedCoupon = Rxn<String>();

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
          id: 'cart-${DateTime.now().microsecondsSinceEpoch}',
          product: product,
          quantity: quantity,
          selectedSize: size,
          selectedColor: color,
        ),
      );
    }
    update();
    AppToast.successToast('${product.name} added to cart');
  }

  void addMapProductToCart(
    Map<String, dynamic> productMap, {
    int quantity = 1,
  }) {
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

    addToCart(product, quantity: quantity);
  }

  void removeFromCart(String itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
    update();
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(itemId);
      return;
    }
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(quantity: quantity);
      update();
    }
  }

  void applyCoupon(String code) {
    appliedCoupon.value = code;
    update();
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
  double get productSavings => cartItems.fold(
        0,
        (sum, item) =>
            sum +
            ((item.product.originalPrice - item.product.price)
                    .clamp(0.0, double.infinity) *
                item.quantity),
      );
  double get totalSavings => productSavings + couponDiscount;
  double get discountedSubtotal =>
      (subtotal - couponDiscount).clamp(0.0, subtotal).toDouble();
  double get tax => discountedSubtotal * taxRate;
  double get total => discountedSubtotal + tax + shippingCharge;

  int get itemCount => cartItems.fold<int>(
      0, (sum, item) => sum + (item.quantity > 0 ? item.quantity : 0));
}
