class Review {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String userImage;
  final double rating;
  final String title;
  final String comment;
  final List<String> images;
  final DateTime reviewDate;
  final int helpfulCount;
  final int unhelpfulCount;
  final bool isVerifiedPurchase;

  Review({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.title,
    required this.comment,
    required this.images,
    required this.reviewDate,
    required this.helpfulCount,
    required this.unhelpfulCount,
    required this.isVerifiedPurchase,
  });
}
