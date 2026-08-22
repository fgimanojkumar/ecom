import 'package:get/get.dart';
import '../controller/wishlist_controller.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WishlistController());
  }
}
