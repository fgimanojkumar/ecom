import 'package:get/get.dart';

import '../../../shared/demo/demo_account_store.dart';

class OrderConfirmationController extends GetxController {
  final Rxn<Map<String, dynamic>> order = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    loadOrder(Get.arguments);
  }

  void loadOrder(dynamic arguments) {
    final orderId = arguments is Map
        ? arguments['orderId']?.toString()
        : arguments?.toString();
    Map<String, dynamic>? selectedOrder;

    if (orderId != null && orderId.isNotEmpty) {
      for (final candidate in DemoAccountStore.orders) {
        if (candidate['id']?.toString() == orderId) {
          selectedOrder = candidate;
          break;
        }
      }
    }

    order.value = selectedOrder ??
        DemoAccountStore.latestOrder ??
        (DemoAccountStore.orders.isNotEmpty
            ? DemoAccountStore.orders.first
            : null);
  }

  Map<String, dynamic>? deliveryAddressFor(Map<String, dynamic> order) {
    final addressId = order['addressId']?.toString();
    for (final address in DemoAccountStore.addresses) {
      if (address['id']?.toString() == addressId) return address;
    }
    return null;
  }

  List<Map<String, dynamic>> itemsFor(Map<String, dynamic> order) {
    final lines = order['lines'];
    if (lines is! List) return const [];
    return lines.whereType<Map<String, dynamic>>().toList();
  }

  double amountFor(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  String formattedDate(dynamic value) {
    final date = DateTime.tryParse(value?.toString() ?? '');
    if (date == null) return 'Date unavailable';
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String estimatedDeliveryFor(dynamic value) {
    final orderDate =
        DateTime.tryParse(value?.toString() ?? '') ?? DateTime.now();
    final start = orderDate.add(const Duration(days: 5));
    final end = orderDate.add(const Duration(days: 7));
    return '${formattedDate(start.toIso8601String())} - ${formattedDate(end.toIso8601String())}';
  }

  String paymentMethodLabel(dynamic value) {
    final method = value?.toString().trim() ?? '';
    if (method.isEmpty) return 'Payment method unavailable';
    return method.toUpperCase() == 'UPI' ? 'UPI' : method;
  }
}
