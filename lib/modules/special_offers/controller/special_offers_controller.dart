import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';
import '../../coupon/controller/coupon_controller.dart';

class SpecialOffersController extends GetxController {
  final RxList<Map<String, String>> offers = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadOffers();
  }

  void _loadOffers() {
    offers.assignAll([
      {
        'discount': '25%',
        'code': 'DEAL25',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
        'time': '08:44:32',
      },
      {
        'discount': '30%',
        'code': 'SUMMER30',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
        'time': '05:22:15',
      },
      {
        'discount': '20%',
        'code': 'WEEKEND20',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
        'time': '12:15:45',
      },
      {
        'discount': '10%',
        'code': 'WELCOME10',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
        'time': '03:30:20',
      },
      {
        'discount': '15%',
        'code': 'SHOP15',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
        'time': '07:10:00',
      },
    ]);
  }

  void claimOffer(String code) {
    final couponController = CouponController.ensureInitialized();
    final cart = CartController.ensureInitialized();
    couponController.applyCoupon(
      code,
      cartSubtotal: cart.subtotal,
      cartCategories:
          cart.cartItems.map((item) => item.product.category).toSet(),
    );
    Get.toNamed('/home');
  }
}
