import 'package:get/get.dart';

import '../../data/models/seller_return_model.dart';

class SellerReturnStore {
  SellerReturnStore._();

  static final RxList<SellerReturn> returns = <SellerReturn>[].obs;

  static void seedIfEmpty() {
    if (returns.isNotEmpty) return;
    returns.addAll([
      SellerReturn(
          id: 'RTN-005',
          orderId: 'ORD-001250',
          customerName: 'Ravi Verma',
          productName: 'Cotton T-Shirt',
          reason: 'Wrong size',
          status: ReturnStatus.pending,
          submittedAt: DateTime(2026, 7, 16)),
      SellerReturn(
          id: 'RTN-004',
          orderId: 'ORD-001240',
          customerName: 'Nisha Patel',
          productName: 'Running Shoes',
          reason: 'Changed mind',
          status: ReturnStatus.approved,
          submittedAt: DateTime(2026, 7, 16)),
      SellerReturn(
          id: 'RTN-003',
          orderId: 'ORD-001230',
          customerName: 'Meera Das',
          productName: 'Backpack',
          reason: 'Damaged on arrival',
          status: ReturnStatus.inTransit,
          submittedAt: DateTime(2026, 7, 15)),
      SellerReturn(
          id: 'RTN-002',
          orderId: 'ORD-001220',
          customerName: 'Kavya Reddy',
          productName: 'Table Lamp',
          reason: 'Not as described',
          status: ReturnStatus.completed,
          submittedAt: DateTime(2026, 7, 14)),
      SellerReturn(
          id: 'RTN-006',
          orderId: 'ORD-001257',
          customerName: 'Sanya Kapoor',
          productName: 'Sunscreen SPF 50',
          reason: 'Item damaged in transit',
          status: ReturnStatus.pending,
          submittedAt: DateTime(2026, 7, 16)),
    ]);
  }
}
