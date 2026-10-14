enum TransactionType { sale, payout, refund }

enum TransactionStatus { pending, settled, failed, refunded }

extension TransactionTypeX on TransactionType {
  String get label => switch (this) {
        TransactionType.sale => 'Sale',
        TransactionType.payout => 'Payout',
        TransactionType.refund => 'Refund',
      };
}

extension TransactionStatusX on TransactionStatus {
  String get label => switch (this) {
        TransactionStatus.pending => 'Pending',
        TransactionStatus.settled => 'Settled',
        TransactionStatus.failed => 'Failed',
        TransactionStatus.refunded => 'Refunded',
      };
}

class SellerTransaction {
  final String id;
  final String orderId;
  final TransactionType type;
  final double amount;
  final TransactionStatus status;
  final DateTime date;

  SellerTransaction({
    required this.id,
    required this.orderId,
    required this.type,
    required this.amount,
    required this.status,
    required this.date,
  });
}
