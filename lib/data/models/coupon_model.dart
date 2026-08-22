enum CouponType { percentage, fixed }

class Coupon {
  final String id;
  final String code;
  final String description;
  final CouponType type;
  final double discountValue;
  final double? maxDiscount;
  final double minOrderAmount;
  final DateTime validFrom;
  final DateTime validUntil;
  final int usageLimit;
  final int usedCount;
  final bool isActive;
  final List<String>? applicableCategories;

  Coupon({
    required this.id,
    required this.code,
    required this.description,
    required this.type,
    required this.discountValue,
    this.maxDiscount,
    required this.minOrderAmount,
    required this.validFrom,
    required this.validUntil,
    required this.usageLimit,
    required this.usedCount,
    required this.isActive,
    this.applicableCategories,
  });

  bool get isValid {
    final now = DateTime.now();
    return isActive &&
        now.isAfter(validFrom) &&
        now.isBefore(validUntil) &&
        usedCount < usageLimit;
  }

  double calculateDiscount(double amount) {
    if (type == CouponType.percentage) {
      double discount = amount * (discountValue / 100);
      if (maxDiscount != null && discount > maxDiscount!) {
        return maxDiscount!;
      }
      return discount;
    } else {
      return discountValue;
    }
  }
}
