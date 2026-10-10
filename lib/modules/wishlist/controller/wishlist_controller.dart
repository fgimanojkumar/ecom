import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';

class WishlistController extends GetxController {
  static WishlistController ensureInitialized() {
    if (Get.isRegistered<WishlistController>()) {
      return Get.find<WishlistController>();
    }
    return Get.put(WishlistController(), permanent: true);
  }

  final RxList<Map<String, dynamic>> wishlistItems = <Map<String, dynamic>>[
    {
      'id': '1',
      'name': 'Premium Wireless Headphones',
      'price': 3999,
      'isSponsored': true,
      'lowestPrice30Days': 3799,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
    },
    {
      'id': '2',
      'name': 'Smart Watch Ultra',
      'price': 8999,
      'lowestPrice30Days': 8499,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
    },
  ].obs;

  bool isWishlisted(String productId) =>
      wishlistItems.any((product) => product['id'] == productId);

  void toggleProduct(Map<String, dynamic> product) {
    final productId = product['id']?.toString();
    if (productId == null || productId.isEmpty) return;
    if (isWishlisted(productId)) {
      wishlistItems.removeWhere((item) => item['id'] == productId);
      Get.snackbar('Wishlist', 'Product removed from wishlist');
      return;
    }
    wishlistItems.add(Map<String, dynamic>.from(product));
    Get.snackbar('Wishlist', 'Product added to wishlist');
  }

  void removeFromWishlist(String productId) {
    wishlistItems.removeWhere((item) => item['id'] == productId);
    Get.snackbar('Removed', 'Product removed from wishlist');
  }

  void addToCart(String productId) {
    final item = wishlistItems.firstWhereOrNull(
      (product) => product['id'] == productId,
    );
    if (item == null) return;

    final price = (item['price'] as num?)?.toDouble() ?? 0;
    CartController.ensureInitialized().addMapProductToCart({
      ...item,
      'originalPrice': price * 1.5,
      'rating': 4.5,
      'reviewCount': 100,
      'category': 'Wishlist',
      'stock': 50,
    });
  }
}
