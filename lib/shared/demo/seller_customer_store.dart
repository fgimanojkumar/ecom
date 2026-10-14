import 'package:get/get.dart';

import '../../data/models/seller_customer_model.dart';

class SellerCustomerStore {
  SellerCustomerStore._();

  static final RxList<SellerCustomer> customers = <SellerCustomer>[].obs;

  static void seedIfEmpty() {
    if (customers.isNotEmpty) return;
    final now = DateTime.now();
    customers.addAll([
      SellerCustomer(
          id: 'CUS-1',
          name: 'Rohit Verma',
          email: 'rohit.verma@example.com',
          phone: '9876500011',
          joinedDate: now.subtract(const Duration(days: 180)),
          totalOrders: 6,
          totalSpent: 12499,
          status: CustomerStatus.active),
      SellerCustomer(
          id: 'CUS-2',
          name: 'Priya Nair',
          email: 'priya.nair@example.com',
          phone: '9876500022',
          joinedDate: now.subtract(const Duration(days: 90)),
          totalOrders: 3,
          totalSpent: 4599,
          status: CustomerStatus.active),
      SellerCustomer(
          id: 'CUS-3',
          name: 'Aditya Singh',
          email: 'aditya.singh@example.com',
          phone: '9876500033',
          joinedDate: now.subtract(const Duration(days: 365)),
          totalOrders: 1,
          totalSpent: 2499,
          status: CustomerStatus.inactive),
    ]);
  }
}
