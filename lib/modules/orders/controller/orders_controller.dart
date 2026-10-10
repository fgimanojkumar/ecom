import 'package:get/get.dart';
import '../../../shared/demo/demo_account_store.dart';

class OrdersController extends GetxController {
  final RxList<Map<String, dynamic>> orders = DemoAccountStore.orders.obs;
  final selectedStatus = 'Total'.obs;

  void selectStatus(String status) {
    selectedStatus.value = status;
  }

  void viewOrderDetails(String orderId) {
    Get.toNamed('/orderDetails', arguments: orderId);
  }
}
