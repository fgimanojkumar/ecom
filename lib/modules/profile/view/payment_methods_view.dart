import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/utils/responsive_util.dart';
import '../../../shared/widgets/common_dropdown_field.dart';
import '../../../shared/widgets/common_input_field.dart';
import '../../../shared/widgets/premium_app_bar.dart';
import '../controller/payment_methods_controller.dart';

class PaymentMethodsView extends GetView<PaymentMethodsController> {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'Payment Methods',
        showBackButton: true,
      ),
      body: ResponsiveContent(
        addHorizontalPadding: true,
        child: Obx(
          () => ListView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saved cards',
                          style: TextStyle(
                            color: AppColors.black1,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Manage your credit and debit cards',
                          style: TextStyle(
                            color: AppColors.black2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Add card',
                    onPressed: controller.beginAdd,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary1,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.add_card_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _privacyNote(),
              if (controller.isFormVisible.value) ...[
                const SizedBox(height: 16),
                _cardForm(),
              ],
              if (controller.cards.isEmpty && !controller.isFormVisible.value)
                _emptyState()
              else ...[
                if (controller.cards.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  for (final card in controller.cards) ...[
                    _savedCard(context, card),
                    const SizedBox(height: 14),
                  ],
                ],
              ],
              if (!controller.isFormVisible.value)
                SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: controller.beginAdd,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add a card'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary1,
                      side: const BorderSide(color: AppColors.primary1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _privacyNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FAF5),
        borderRadius: BorderRadius.circular(11),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline_rounded, color: AppColors.success, size: 17),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'For your safety, the full card number and security code are never saved. Only masked card details are kept for display.',
              style: TextStyle(
                color: AppColors.black2,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 22),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      decoration: BoxDecoration(
        color: AppColors.white1,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.white2),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.credit_card_outlined,
            color: AppColors.muteIconColor,
            size: 34,
          ),
          SizedBox(height: 10),
          Text(
            'No saved cards',
            style: TextStyle(
              color: AppColors.black1,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Add a card to keep its masked details available for checkout.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black2,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _savedCard(BuildContext context, Map<String, dynamic> card) {
    final cardId = card['id']?.toString() ?? '';
    final isDefault = card['isDefault'] == true;
    final brand = card['brand']?.toString() ?? 'Card';
    final last4 = card['last4']?.toString() ?? '----';

    return Column(
      children: [
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 176),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF243044), Color(0xFF394C66)],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${card['type'] ?? 'Card'} · $brand',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'DEFAULT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                '••••  ••••  ••••  $last4',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _cardMeta(
                        'CARDHOLDER', card['holder']?.toString() ?? ''),
                  ),
                  const SizedBox(width: 12),
                  _cardMeta('EXPIRES', card['expiry']?.toString() ?? ''),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(4, 6, 0, 0),
          child: Row(
            children: [
              TextButton.icon(
                onPressed:
                    isDefault ? null : () => controller.setDefault(cardId),
                icon: Icon(
                  isDefault
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: 18,
                ),
                label: Text(isDefault ? 'Default card' : 'Make default'),
                style: TextButton.styleFrom(
                  foregroundColor:
                      isDefault ? AppColors.success : AppColors.black2,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Edit card',
                onPressed: () => controller.beginEdit(card),
                icon: const Icon(Icons.edit_outlined, size: 19),
              ),
              IconButton(
                tooltip: 'Remove card',
                onPressed: () => _confirmRemove(context, cardId),
                color: AppColors.error,
                icon: const Icon(Icons.delete_outline_rounded, size: 19),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardMeta(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 8,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value.isEmpty ? '—' : value.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _cardForm() {
    final isEditing = controller.isEditing;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.white2),
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEditing ? 'Edit card details' : 'Add a card',
              style: const TextStyle(
                color: AppColors.black1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            CommonDropdownField<String>(
              value: controller.cardType.value,
              options: PaymentMethodsController.cardTypes
                  .map((type) => CommonDropdownOption<String>(
                        value: type,
                        label: type,
                        icon: Icons.credit_card_rounded,
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) controller.cardType.value = value;
              },
              labelText: 'Card type',
              radius: 12,
            ),
            const SizedBox(height: 12),
            CommonInputField.formField(
              controller: controller.numberController,
              labelText: 'Card number',
              hintText: isEditing
                  ? 'Leave blank to keep the saved number'
                  : '1234-5678-9012-3456',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLength: 23,
              inputFormatters: [_CardNumberInputFormatter()],
              prefixWidget: const Icon(Icons.credit_card_outlined),
              validator: controller.validateNumber,
              radius: 12,
            ),
            const SizedBox(height: 12),
            CommonInputField.formField(
              controller: controller.holderController,
              labelText: 'Name on card',
              hintText: 'As shown on the card',
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: controller.validateHolder,
              radius: 12,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CommonInputField.formField(
                    controller: controller.expiryController,
                    labelText: 'Expiry',
                    hintText: 'MM/YY',
                    keyboardType: TextInputType.datetime,
                    maxLength: 5,
                    inputFormatters: [_CardExpiryInputFormatter()],
                    validator: controller.validateExpiry,
                    radius: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CommonInputField.formField(
                    controller: controller.securityCodeController,
                    labelText: 'CVV / CVC',
                    hintText: '3 or 4 digits',
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 4,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: controller.validateSecurityCode,
                    radius: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(
              () => SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                value: controller.makeDefault.value,
                onChanged: (value) => controller.makeDefault.value = value,
                activeThumbColor: AppColors.primary1,
                title: const Text(
                  'Set as default card',
                  style: TextStyle(
                    color: AppColors.black1,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.cancelForm,
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: controller.saveCard,
                    icon: const Icon(Icons.save_outlined, size: 17),
                    label: Text(isEditing ? 'Save changes' : 'Save card'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary1,
                      foregroundColor: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmRemove(BuildContext context, String cardId) async {
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove saved card?'),
        content: const Text(
          'This removes the masked card details from this account.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (shouldRemove == true) controller.removeCard(cardId);
  }
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final rawDigits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final digits =
        rawDigits.length > 19 ? rawDigits.substring(0, 19) : rawDigits;
    final cursorPosition = newValue.selection.isValid
        ? newValue.selection.baseOffset.clamp(0, newValue.text.length)
        : newValue.text.length;
    final cursorDigits = newValue.text
        .substring(0, cursorPosition)
        .replaceAll(RegExp(r'\D'), '')
        .length
        .clamp(0, digits.length);
    final formatted = _groupDigits(digits, 4, '-');
    final formattedCursor =
        cursorDigits == 0 ? 0 : cursorDigits + ((cursorDigits - 1) ~/ 4);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formattedCursor.clamp(0, formatted.length),
      ),
    );
  }
}

class _CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final rawDigits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final digits = rawDigits.length > 4 ? rawDigits.substring(0, 4) : rawDigits;
    final cursorPosition = newValue.selection.isValid
        ? newValue.selection.baseOffset.clamp(0, newValue.text.length)
        : newValue.text.length;
    final cursorDigits = newValue.text
        .substring(0, cursorPosition)
        .replaceAll(RegExp(r'\D'), '')
        .length
        .clamp(0, digits.length);
    final formatted = digits.length > 2
        ? '${digits.substring(0, 2)}/${digits.substring(2)}'
        : digits;
    final formattedCursor = cursorDigits > 2 ? cursorDigits + 1 : cursorDigits;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formattedCursor.clamp(0, formatted.length),
      ),
    );
  }
}

String _groupDigits(String digits, int groupSize, String separator) {
  final output = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && index % groupSize == 0) output.write(separator);
    output.write(digits[index]);
  }
  return output.toString();
}
