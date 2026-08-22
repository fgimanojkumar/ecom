import 'package:get/get.dart';
import '../controller/order_details_controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderDetailsController());
  }
}
