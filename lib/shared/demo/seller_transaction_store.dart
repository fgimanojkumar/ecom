import 'package:get/get.dart';

import '../../data/models/seller_transaction_model.dart';

class SellerTransactionStore {
  SellerTransactionStore._();

  static final RxList<SellerTransaction> transactions =
      <SellerTransaction>[].obs;

  static void seedIfEmpty() {
    if (transactions.isNotEmpty) return;
    final now = DateTime.now();
    transactions.addAll([
      SellerTransaction(
          id: 'TXN-1001',
          orderId: 'ORD-20098',
          type: TransactionType.sale,
          amount: 1899,
          status: TransactionStatus.settled,
          date: now.subtract(const Duration(days: 1))),
      SellerTransaction(
          id: 'TXN-1002',
          orderId: 'ORD-20097',
          type: TransactionType.sale,
          amount: 1798,
          status: TransactionStatus.pending,
          date: now.subtract(const Duration(hours: 5))),
      SellerTransaction(
          id: 'TXN-1003',
          orderId: 'ORD-20090',
          type: TransactionType.refund,
          amount: 3499,
          status: TransactionStatus.refunded,
          date: now.subtract(const Duration(days: 3))),
      SellerTransaction(
          id: 'TXN-1004',
          orderId: '-',
          type: TransactionType.payout,
          amount: 25000,
          status: TransactionStatus.settled,
          date: now.subtract(const Duration(days: 7))),
    ]);
  }
}
