import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/demo/demo_account_store.dart';

class PaymentMethodsController extends GetxController {
  static const cardTypes = ['Credit card', 'Debit card'];

  final cards = <Map<String, dynamic>>[].obs;
  final isFormVisible = false.obs;
  final editingCardId = RxnString();
  final cardType = 'Credit card'.obs;
  final makeDefault = false.obs;
  final formKey = GlobalKey<FormState>();

  final holderController = TextEditingController();
  final numberController = TextEditingController();
  final expiryController = TextEditingController();
  final securityCodeController = TextEditingController();

  Map<String, dynamic> get _account =>
      DemoAccountStore.activeUser.value ?? DemoAccountStore.demoUser;

  bool get isEditing => editingCardId.value != null;
  bool get requiresSecurityCode =>
      !isEditing ||
      numberController.text.replaceAll(RegExp(r'\D'), '').isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    final savedCards = _account.putIfAbsent(
      'paymentCards',
      () => <Map<String, dynamic>>[],
    );
    if (savedCards is List) {
      cards.assignAll(savedCards.whereType<Map<String, dynamic>>());
    }
    if (cards.isNotEmpty && !cards.any((card) => card['isDefault'] == true)) {
      cards.first['isDefault'] = true;
      _syncCards();
    }
  }

  @override
  void onClose() {
    holderController.dispose();
    numberController.dispose();
    expiryController.dispose();
    securityCodeController.dispose();
    super.onClose();
  }

  void beginAdd() {
    _clearForm();
    editingCardId.value = null;
    cardType.value = 'Credit card';
    makeDefault.value = cards.isEmpty;
    isFormVisible.value = true;
  }

  void beginEdit(Map<String, dynamic> card) {
    _clearForm();
    editingCardId.value = card['id']?.toString();
    cardType.value = card['type']?.toString() ?? 'Credit card';
    holderController.text = card['holder']?.toString() ?? '';
    expiryController.text = card['expiry']?.toString() ?? '';
    makeDefault.value = card['isDefault'] == true;
    isFormVisible.value = true;
  }

  void cancelForm() {
    _clearForm();
    editingCardId.value = null;
    isFormVisible.value = false;
  }

  void _clearForm() {
    holderController.clear();
    numberController.clear();
    expiryController.clear();
    securityCodeController.clear();
  }

  String? validateHolder(String? value) {
    if ((value ?? '').trim().isEmpty) return 'Enter the name on the card';
    return null;
  }

  String? validateNumber(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty && isEditing) return null;
    if (digits.length < 13 || digits.length > 19 || !_passesLuhn(digits)) {
      return 'Enter a valid card number';
    }
    return null;
  }

  String? validateExpiry(String? value) {
    final match = RegExp(r'^(0[1-9]|1[0-2])/(\d{2})$').firstMatch(value ?? '');
    if (match == null) return 'Use MM/YY';

    final month = int.parse(match.group(1)!);
    final year = 2000 + int.parse(match.group(2)!);
    final now = DateTime.now();
    if (DateTime(year, month + 1).isBefore(DateTime(now.year, now.month + 1))) {
      return 'Card has expired';
    }
    return null;
  }

  String? validateSecurityCode(String? value) {
    if (!requiresSecurityCode) return null;
    if (!RegExp(r'^\d{3,4}$').hasMatch(value ?? '')) {
      return 'Enter a 3 or 4 digit security code';
    }
    return null;
  }

  bool _passesLuhn(String digits) {
    var sum = 0;
    var doubleDigit = false;
    for (var index = digits.length - 1; index >= 0; index--) {
      var digit = int.parse(digits[index]);
      if (doubleDigit) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      doubleDigit = !doubleDigit;
    }
    return sum % 10 == 0;
  }

  String _brandFor(String digits) {
    if (digits.startsWith('4')) return 'Visa';
    if (RegExp(r'^(5[1-5]|2[2-7])').hasMatch(digits)) return 'Mastercard';
    if (RegExp(r'^3[47]').hasMatch(digits)) return 'American Express';
    if (digits.startsWith('60') || digits.startsWith('65')) return 'RuPay';
    return 'Card';
  }

  bool saveCard() {
    final formState = formKey.currentState;
    if (formState == null) {
      Get.snackbar(
        'Card form unavailable',
        'Close and reopen the card form, then try again.',
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    if (!formState.validate()) {
      Get.snackbar(
        'Check card details',
        'Correct the highlighted fields before saving.',
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    final existingIndex = cards.indexWhere(
      (card) => card['id']?.toString() == editingCardId.value,
    );
    final existing = existingIndex < 0 ? null : cards[existingIndex];
    final digits = numberController.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty && existing == null) {
      Get.snackbar(
        'Card number required',
        'Enter the card number before saving.',
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    final previousLastFour =
        existing == null ? '' : existing['last4']?.toString() ?? '';
    final previousBrand =
        existing == null ? 'Card' : existing['brand']?.toString() ?? 'Card';
    final lastFour =
        digits.isEmpty ? previousLastFour : digits.substring(digits.length - 4);
    final brand = digits.isEmpty ? previousBrand : _brandFor(digits);
    final card = <String, dynamic>{
      'id': existing?['id']?.toString() ??
          'card-${DateTime.now().microsecondsSinceEpoch}',
      'type': cardType.value,
      'holder': holderController.text.trim(),
      'brand': brand,
      'last4': lastFour,
      'expiry': expiryController.text.trim(),
      'isDefault': makeDefault.value || cards.isEmpty,
    };

    if (card['isDefault'] == true) {
      for (final saved in cards) {
        saved['isDefault'] = false;
      }
    }
    if (existingIndex < 0) {
      cards.insert(0, card);
    } else {
      cards[existingIndex] = card;
    }
    if (!cards.any((saved) => saved['isDefault'] == true) && cards.isNotEmpty) {
      cards.first['isDefault'] = true;
    }

    _syncCards();
    cancelForm();
    Get.snackbar(
      'Card saved',
      'Only the card brand and last four digits are kept for display.',
      duration: const Duration(seconds: 2),
    );
    return true;
  }

  void setDefault(String cardId) {
    for (final card in cards) {
      card['isDefault'] = card['id']?.toString() == cardId;
    }
    cards.refresh();
    _syncCards();
  }

  void removeCard(String cardId) {
    final wasDefault = cards.any(
      (card) => card['id']?.toString() == cardId && card['isDefault'] == true,
    );
    cards.removeWhere((card) => card['id']?.toString() == cardId);
    if (wasDefault && cards.isNotEmpty) cards.first['isDefault'] = true;
    cards.refresh();
    _syncCards();
  }

  void _syncCards() {
    _account['paymentCards'] = cards.toList();
    if (DemoAccountStore.activeUser.value != null) {
      DemoAccountStore.activeUser.refresh();
    }
  }
}
