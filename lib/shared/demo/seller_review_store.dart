import 'package:get/get.dart';

import '../../data/models/seller_review_model.dart';

class SellerReviewStore {
  SellerReviewStore._();

  static final RxList<SellerReview> reviews = <SellerReview>[].obs;

  static void seedIfEmpty() {
    if (reviews.isNotEmpty) return;
    reviews.addAll([
      SellerReview(
          id: 'R-1',
          productName: 'Wireless Earbuds',
          customerName: 'Rohit Verma',
          rating: 5,
          comment: 'Great sound quality, fast delivery!',
          status: ReviewStatus.approved),
      SellerReview(
          id: 'R-2',
          productName: 'Cotton Kurta',
          customerName: 'Priya Nair',
          rating: 4,
          comment: 'Good fabric, sizing runs slightly large.',
          status: ReviewStatus.pending),
      SellerReview(
          id: 'R-3',
          productName: 'Running Shoes',
          customerName: 'Aditya Singh',
          rating: 2,
          comment: 'Sole wore out within a month.',
          status: ReviewStatus.pending),
      SellerReview(
          id: 'R-4',
          productName: 'Smart Watch',
          customerName: 'Sneha Kulkarni',
          rating: 5,
          comment: 'Battery life is excellent.',
          status: ReviewStatus.approved),
    ]);
  }
}
