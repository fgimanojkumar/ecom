import 'package:get/get.dart';

import '../../data/models/seller_offer_model.dart';

class SellerOfferStore {
  SellerOfferStore._();

  static final RxList<SellerOffer> offers = <SellerOffer>[].obs;

  static void seedIfEmpty() {
    if (offers.isNotEmpty) return;
    final now = DateTime.now();
    offers.addAll([
      SellerOffer(
          id: 'OFF-1',
          code: 'FESTIVE20',
          description: 'Festive season discount',
          discountType: DiscountType.percentage,
          discountValue: 20,
          expiryDate: now.add(const Duration(days: 15)),
          used: 34,
          usageLimit: 200,
          status: OfferStatus.active),
      SellerOffer(
          id: 'OFF-2',
          code: 'FLAT100',
          description: 'Flat cashback on orders above \u20b9999',
          discountType: DiscountType.fixed,
          discountValue: 100,
          expiryDate: now.add(const Duration(days: 5)),
          used: 120,
          usageLimit: 150,
          status: OfferStatus.active),
      SellerOffer(
          id: 'OFF-3',
          code: 'SUMMER10',
          description: 'Summer clearance',
          discountType: DiscountType.percentage,
          discountValue: 10,
          expiryDate: now.subtract(const Duration(days: 20)),
          used: 400,
          usageLimit: 400,
          status: OfferStatus.expired),
    ]);
  }
}
