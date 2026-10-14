enum ReviewStatus { pending, approved, hidden }

extension ReviewStatusX on ReviewStatus {
  String get label => switch (this) {
        ReviewStatus.pending => 'Pending',
        ReviewStatus.approved => 'Approved',
        ReviewStatus.hidden => 'Hidden',
      };
}

class SellerReview {
  final String id;
  final String productName;
  final String customerName;
  final int rating;
  final String comment;
  ReviewStatus status;

  SellerReview({
    required this.id,
    required this.productName,
    required this.customerName,
    required this.rating,
    required this.comment,
    required this.status,
  });
}
