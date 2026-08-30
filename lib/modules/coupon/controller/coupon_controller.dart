import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/widgets/app_toast.dart';

class CouponController extends GetxController {
  final RxString appliedCouponCode = ''.obs;

  final RxList<Map<String, dynamic>> coupons = <Map<String, dynamic>>[
    {
      'discount': '10% OFF',
      'code': 'WELCOME10',
      'description': 'Enjoy 10% OFF on Your Order',
      'unlock': 'Applicable on all orders above ₹500',
      'expiryDate': DateTime(2026, 8, 23),
      'terms': 'T&Cs Apply',
      'gradientColors': [Color(0xFF0F6B43), Color.fromARGB(255, 145, 197, 169)],
    },
    {
      'discount': '15% OFF',
      'code': 'SHOP15',
      'description': 'Save 15% OFF on Fashion Collection',
      'unlock': 'Applicable on Fashion category only',
      'expiryDate': DateTime(2026, 8, 20),
      'terms': 'T&Cs Apply',
      'gradientColors': [Color(0xFF4776E6), Color(0xFF8E54E9)],
    },
    {
      'discount': '25% OFF',
      'code': 'DEAL25',
      'description': 'Flat 25% OFF on Electronics',
      'unlock': 'Applicable on Electronics above ₹2500',
      'expiryDate': DateTime(2026, 9, 1),
      'terms': 'T&Cs Apply',
      'gradientColors': [Color(0xFFFF6B35), Color(0xFFFF8E53)],
    },
    {
      'discount': '15% OFF',
      'code': 'HOME15',
      'description': 'Save 15% OFF on Home Essentials',
      'unlock': 'Applicable on Home category above ₹900',
      'expiryDate': DateTime(2026, 9, 10),
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

  void applyCoupon(String code) {
    appliedCouponCode.value = code;
    AppToast.successToast('Coupon "$code" applied successfully!');
  }

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
