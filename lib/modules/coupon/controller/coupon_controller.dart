import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/style/app_colors.dart';
import 'package:imoss/shared/widgets/app_toast.dart';

class CouponController extends GetxController {
  static CouponController ensureInitialized() {
    if (Get.isRegistered<CouponController>()) {
      return Get.find<CouponController>();
    }
    return Get.put(CouponController());
  }

  final RxString appliedCouponCode = ''.obs;

  final RxList<Map<String, dynamic>> coupons = <Map<String, dynamic>>[
    {
      'discount': '10% OFF',
      'code': 'WELCOME10',
      'description': 'Enjoy 10% OFF on Your Order',
      'unlock': 'Applicable on all orders above ₹500',
      'minimumSubtotal': 500.0,
      'categories': <String>[],
      'expiryDate': DateTime(2027, 8, 23),
      'terms': 'T&Cs Apply',
      'gradientColors': [AppColors.gradientStart, AppColors.gradientEnd],
    },
    {
      'discount': '15% OFF',
      'code': 'SHOP15',
      'description': 'Save 15% OFF on Fashion Collection',
      'unlock': 'Applicable on Fashion category only',
      'minimumSubtotal': 0.0,
      'categories': <String>['Fashion'],
      'expiryDate': DateTime(2027, 8, 20),
      'terms': 'T&Cs Apply',
      'gradientColors': [Color(0xFF4776E6), Color(0xFF8E54E9)],
    },
    {
      'discount': '25% OFF',
      'code': 'DEAL25',
      'description': 'Flat 25% OFF on Electronics',
      'unlock': 'Applicable on Electronics above ₹2500',
      'minimumSubtotal': 2500.0,
      'categories': <String>['Electronics'],
      'expiryDate': DateTime(2027, 9, 1),
      'terms': 'T&Cs Apply',
      'gradientColors': [Color(0xFFFF6B35), Color(0xFFFF8E53)],
    },
    {
      'discount': '30% OFF',
      'code': 'SUMMER30',
      'description': 'Save 30% on selected summer products',
      'unlock': 'Demo offer for selected summer products',
      'minimumSubtotal': 0.0,
      'categories': <String>[],
      'expiryDate': DateTime(2027, 9, 1),
      'terms': 'T&Cs Apply',
      'gradientColors': [Color(0xFFEF6C43), Color(0xFFF4A261)],
    },
    {
      'discount': '20% OFF',
      'code': 'WEEKEND20',
      'description': 'Save 20% on selected products',
      'unlock': 'Demo offer on selected products',
      'minimumSubtotal': 0.0,
      'categories': <String>[],
      'expiryDate': DateTime(2027, 9, 1),
      'terms': 'T&Cs Apply',
      'gradientColors': [Color(0xFF4776E6), Color(0xFF8E54E9)],
    },
    {
      'discount': '15% OFF',
      'code': 'HOME15',
      'description': 'Save 15% OFF on Home Essentials',
      'unlock': 'Applicable on Home category above ₹900',
      'minimumSubtotal': 900.0,
      'categories': <String>['Home'],
      'expiryDate': DateTime(2027, 9, 10),
      'terms': 'T&Cs Apply',
      'gradientColors': [Color(0xFF5B4DCC), Color(0xFFC850C0)],
    },
  ].obs;

  bool isExpired(Map<String, dynamic> coupon) {
    final date = coupon['expiryDate'];
    if (date is DateTime) return date.isBefore(DateTime.now());
    return false;
  }

  String expiryLabel(Map<String, dynamic> coupon) {
    final date = coupon['expiryDate'];
    if (date is! DateTime) return '';
    final now = DateTime.now();
    if (date.isBefore(now)) return 'Expired';
    final diff = date.difference(now);
    if (diff.inDays == 0) return 'Expires today';
    if (diff.inDays == 1) return 'Expires tomorrow';
    return 'Expires in ${diff.inDays} days';
  }

  bool applyCoupon(
    String code, {
    double cartSubtotal = 0,
    Iterable<String> cartCategories = const <String>[],
  }) {
    final normalizedCode = code.trim().toUpperCase();
    final coupon = coupons.firstWhereOrNull(
      (item) => item['code'] == normalizedCode,
    );
    if (coupon == null) {
      AppToast.errorToast('That coupon code is not valid.');
      return false;
    }
    if (isExpired(coupon)) {
      AppToast.errorToast('This coupon has expired.');
      return false;
    }
    final minimumSubtotal =
        (coupon['minimumSubtotal'] as num?)?.toDouble() ?? 0;
    if (cartSubtotal < minimumSubtotal) {
      AppToast.errorToast(
        'Add items worth ₹${minimumSubtotal.toStringAsFixed(0)} to use this coupon.',
      );
      return false;
    }
    final requiredCategories =
        (coupon['categories'] as List?)?.cast<String>() ?? const <String>[];
    if (requiredCategories.isNotEmpty &&
        !cartCategories.any(
          (category) => requiredCategories.any(
            (required) => required.toLowerCase() == category.toLowerCase(),
          ),
        )) {
      AppToast.errorToast(
        'This coupon is not valid for the products in your cart.',
      );
      return false;
    }
    appliedCouponCode.value = normalizedCode;
    AppToast.successToast('Coupon "$normalizedCode" applied successfully!');
    return true;
  }

  Map<String, dynamic>? detailsFor(String code) => coupons.firstWhereOrNull(
        (coupon) => coupon['code'] == code,
      );

  void removeCoupon() {
    final code = appliedCouponCode.value;
    appliedCouponCode.value = '';
    AppToast.successToast('Coupon "$code" removed.');
  }

  String getTerms(String code) {
    return '• Coupon "$code" is valid for a limited period only.\n'
        '• Applicable on select products only.\n'
        '• Cannot be combined with any other offer.\n'
        '• Minimum cart value may be required.\n'
        '• Discount excludes taxes and delivery charges.\n'
        '• Non-transferable and non-refundable.\n'
        '• Management reserves the right to modify or withdraw the offer at any time.\n'
        '• For queries, contact customer support.';
  }
}
