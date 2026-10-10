import 'package:get/get.dart';

import '../../../shared/demo/demo_account_store.dart';

class ReturnsController extends GetxController {
  static const List<String> filters = [
    'All',
    'In progress',
    'Eligible',
  ];

  static const List<String> steps = [
    'Return pickup scheduled',
    'Item picked up',
    'Item received for inspection',
    'Refund sent to your original payment method',
    'Refund credited to your bank account',
  ];

  final RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;
  final RxString activeFilter = 'All'.obs;
  final Rxn<Map<String, dynamic>> selectedOrder = Rxn<Map<String, dynamic>>();
  final RxInt currentStep = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    refreshOrders();
    selectOrder(Get.arguments);
  }

  List<Map<String, dynamic>> get returnOrders =>
      orders.where((order) => order['returnRequestStatus'] != null).toList();

  List<Map<String, dynamic>> get eligibleOrders => orders
      .where(
          (order) => order['status']?.toString().toLowerCase() == 'delivered')
      .where((order) => order['returnRequestStatus'] == null)
      .toList();

  List<Map<String, dynamic>> get visibleOrders {
    switch (activeFilter.value) {
      case 'In progress':
        return returnOrders;
      case 'Eligible':
        return eligibleOrders;
      default:
        return [...returnOrders, ...eligibleOrders];
    }
  }

  void refreshOrders() {
    orders.assignAll(DemoAccountStore.orders);
  }

  void selectFilter(String filter) {
    if (filters.contains(filter)) activeFilter.value = filter;
  }

  void selectOrder(dynamic arguments) {
    final orderId = arguments is Map
        ? arguments['orderId']?.toString()
        : arguments?.toString();
    Map<String, dynamic>? order;

    if (orderId != null && orderId.isNotEmpty) {
      for (final candidate in orders) {
        if (candidate['id']?.toString() == orderId) {
          order = candidate;
          break;
        }
      }
    }

    order ??= orders.firstWhereOrNull(
      (candidate) => candidate['returnRequestStatus'] != null,
    );
    selectedOrder.value = order;
    currentStep.value = order == null
        ? -1
        : stepForStatus(order['returnRequestStatus']?.toString() ?? '');
  }

  int stepForStatus(String status) {
    final value = status.toLowerCase();
    if (value.contains('credit') ||
        value.contains('refunded') ||
        value.contains('paid')) {
      return 4;
    }
    if (value.contains('initiated') ||
        value.contains('processing') ||
        value.contains('processed') ||
        value.contains('transferred')) {
      return 3;
    }
    if (value.contains('received') || value.contains('inspection')) return 2;
    if (value.contains('picked') ||
        value.contains('collected') ||
        value.contains('transit') ||
        value.contains('on the way')) {
      return 1;
    }
    if (value.contains('request') ||
        value.contains('approved') ||
        value.contains('pickup') ||
        value.contains('scheduled')) {
      return 0;
    }
    return -1;
  }

  String currentDescription(int step) {
    switch (step) {
      case 0:
        return 'Your return request is recorded. Pickup is being scheduled.';
      case 1:
        return 'The courier has collected your item and it is on its way back.';
      case 2:
        return 'The return center has received the item for inspection.';
      case 3:
        return 'The refund has been sent to your original payment method.';
      default:
        return 'The refund has been credited to the bank account linked to your payment method.';
    }
  }

  String statusLabel(Map<String, dynamic> order) {
    final status = order['returnRequestStatus']?.toString();
    if (status == null || status.isEmpty) return 'Return available';
    final step = stepForStatus(status);
    return step < 0 ? status : steps[step];
  }

  void requestReturn(Map<String, dynamic> order) {
    if (order['status']?.toString().toLowerCase() != 'delivered' ||
        order['returnRequestStatus'] != null) {
      return;
    }

    order['returnRequestStatus'] = 'Requested';
    orders.refresh();
    selectOrder(order['id']);
    Get.toNamed('/returnStatus', arguments: order['id']);
  }

  void openReturnStatus(Map<String, dynamic> order) {
    selectOrder(order['id']);
    Get.toNamed('/returnStatus', arguments: order['id']);
  }
}
