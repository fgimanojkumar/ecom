import 'package:get/get.dart';
import '../controller/order_confirmation_controller.dart';

class OrderConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderConfirmationController());
  }
}
