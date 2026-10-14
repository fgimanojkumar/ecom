enum ReturnStatus {
  pending,
  approved,
  issued,
  inTransit,
  qualityCheck,
  completed,
  rejected,
}

extension ReturnStatusX on ReturnStatus {
  String get label => switch (this) {
        ReturnStatus.pending => 'Pending',
        ReturnStatus.approved => 'Approved',
        ReturnStatus.issued => 'Return Issued',
        ReturnStatus.inTransit => 'In Transit',
        ReturnStatus.qualityCheck => 'Quality Check',
        ReturnStatus.completed => 'Completed',
        ReturnStatus.rejected => 'Rejected',
      };
}

class SellerReturn {
  final String id;
  final String orderId;
  final String customerName;
  final String productName;
  final String reason;
  final DateTime submittedAt;
  ReturnStatus status;

  SellerReturn({
    required this.id,
    required this.orderId,
    required this.customerName,
    required this.productName,
    required this.reason,
    required this.status,
    DateTime? submittedAt,
  }) : submittedAt = submittedAt ?? DateTime.now();
}
