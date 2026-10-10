import 'package:get/get.dart';
import '../../../shared/demo/demo_account_store.dart';

class OrderDetailsController extends GetxController {
  final RxList<Map<String, dynamic>> orders = DemoAccountStore.orders.obs;

  void viewOrderDetails(String orderId) {
    Get.toNamed('/orderTracking', arguments: orderId);
  }
}
