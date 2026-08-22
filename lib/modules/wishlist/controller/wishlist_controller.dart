import 'package:get/get.dart';

class WishlistController extends GetxController {
  final wishlistItems = [
    {
      'id': '1',
      'name': 'Premium Wireless Headphones',
      'price': 3999,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
    },
    {
      'id': '2',
      'name': 'Smart Watch Ultra',
      'price': 8999,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
    },
  ].obs;

  void removeFromWishlist(String productId) {
    wishlistItems.removeWhere((item) => item['id'] == productId);
    Get.snackbar('Removed', 'Product removed from wishlist');
  }

  void addToCart(String productId) {
    Get.snackbar('Added', 'Product added to cart');
  }
}
