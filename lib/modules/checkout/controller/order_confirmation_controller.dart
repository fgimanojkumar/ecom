import 'package:get/get.dart';

class OrderConfirmationController extends GetxController {
  final orderId = ''.obs;
  final orderDate = ''.obs;
  final estimatedDelivery = ''.obs;
  final totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with order details if available
    orderId.value = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
    orderDate.value = DateTime.now().toString().split('.')[0];
    estimatedDelivery.value =
        DateTime.now().add(const Duration(days: 5)).toString().split('.')[0];
    totalAmount.value = 0.0;
  }
}
