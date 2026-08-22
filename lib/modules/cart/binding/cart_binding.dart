import 'package:get/get.dart';
import '../controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    CartController.ensureInitialized();
  }
}
