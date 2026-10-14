enum OfferStatus { active, expired, scheduled }

enum DiscountType { percentage, fixed }

extension OfferStatusX on OfferStatus {
  String get label => switch (this) {
        OfferStatus.active => 'Active',
        OfferStatus.expired => 'Expired',
        OfferStatus.scheduled => 'Scheduled',
      };
}

class SellerOffer {
  final String id;
  String code;
  String description;
  DiscountType discountType;
  double discountValue;
  DateTime expiryDate;
  int used;
  int usageLimit;
  OfferStatus status;

  SellerOffer({
    required this.id,
    required this.code,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.expiryDate,
    required this.used,
    required this.usageLimit,
    required this.status,
  });

  String get discountLabel => discountType == DiscountType.percentage
      ? '${discountValue.toStringAsFixed(0)}% off'
      : '\u20b9${discountValue.toStringAsFixed(0)} off';
}
