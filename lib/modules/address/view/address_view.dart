import 'package:imoss/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imoss/shared/utils/responsive_util.dart';
import 'package:imoss/shared/widgets/premium_app_bar.dart';

import '../controller/address_controller.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PremiumAppBar(
        title: 'My Addresses',
        showBackButton: true,
      ),
      body: SafeArea(
        child: ResponsiveContent(
          addHorizontalPadding: true,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    children: [
                      if (!controller.isFormVisible.value) ...[
                        _buildCurrentLocationCard(),
                        const SizedBox(height: 14),
                      ],
                      _buildAddAddressButton(),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        child: controller.isFormVisible.value
                            ? Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: _buildAddressForm(),
                              )
                            : const SizedBox.shrink(),
                      ),
                      if (!controller.isFormVisible.value) ...[
                        const SizedBox(height: 18),
                        const Text(
                          'Saved Addresses',
                          style: TextStyle(
                            color: AppColors.black1,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(
                          controller.addresses.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _addressCard(controller.addresses[index]),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentLocationCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.white2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.white1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.my_location_rounded,
              color: AppColors.primary1,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use Current Location',
                  style: TextStyle(
                    color: AppColors.black1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Auto-fill your address details quickly',
                  style: TextStyle(
                    color: AppColors.muteIconColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: controller.useCurrentLocation,
            child: const Text(
              'Use',
              style: TextStyle(
                color: AppColors.primary1,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAddressButton() {
    return GestureDetector(
      onTap: controller.addAddress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.primary1,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary1.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_location_alt_rounded,
                color: AppColors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Add New Address',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressForm() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.white2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Address Details',
            style: TextStyle(
              color: AppColors.black1,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _buildTypeSelector(),
          const SizedBox(height: 12),
          _textField(controller.nameController, 'Full Name'),
          const SizedBox(height: 10),
          _textField(
            controller.phoneController,
            'Phone Number',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 10),
          _textField(controller.streetController, 'Street Address'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _textField(controller.cityController, 'City')),
              const SizedBox(width: 10),
              Expanded(child: _textField(controller.stateController, 'State')),
            ],
          ),
          const SizedBox(height: 10),
          _textField(
            controller.pincodeController,
            'Pincode',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    controller.clearForm();
                    controller.hideForm();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.white2),
                    foregroundColor: AppColors.muteIconColor,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.saveAddress();
                    controller.hideForm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary1,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Address',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    const types = ['Home', 'Office', 'Other'];

    return Obx(
      () => Row(
        children: types
            .map(
              (type) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(type),
                  selected: controller.selectedType.value == type,
                  onSelected: (_) => controller.selectType(type),
                  selectedColor: AppColors.white1,
                  backgroundColor: AppColors.white1,
                  side: BorderSide(
                    color: controller.selectedType.value == type
                        ? AppColors.primary1
                        : AppColors.white2,
                  ),
                  labelStyle: TextStyle(
                    color: controller.selectedType.value == type
                        ? AppColors.primary1
                        : AppColors.muteIconColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _addressCard(Map<String, dynamic> address) {
    final isDefault = address['isDefault'] as bool? ?? false;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDefault ? AppColors.primary1 : AppColors.white2,
          width: isDefault ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _tag(address['type'] as String? ?? 'Home', AppColors.primary1),
              if (isDefault) ...[
                const SizedBox(width: 8),
                _tag('Default', AppColors.statusBtnGreen),
              ],
              const Spacer(),
              PopupMenuButton<String>(
                color: AppColors.white,
                onSelected: (value) {
                  final id = address['id'] as String;
                  if (value == 'edit') controller.editAddress(id);
                  if (value == 'default') controller.setDefaultAddress(id);
                  if (value == 'delete') controller.deleteAddress(id);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  if (!isDefault)
                    const PopupMenuItem(
                      value: 'default',
                      child: Text('Set as Default'),
                    ),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                icon: const Icon(Icons.more_vert_rounded,
                    color: AppColors.muteIconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            address['name'] as String? ?? '',
            style: const TextStyle(
              color: AppColors.black1,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            address['phone'] as String? ?? '',
            style: const TextStyle(
              color: AppColors.muteIconColor,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${address['street']}, ${address['city']}, ${address['state']} - ${address['pincode']}',
            style: const TextStyle(
              color: AppColors.black2,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _textField(
    TextEditingController fieldController,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: fieldController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.muteIconColor,
          fontSize: 13,
        ),
        filled: true,
        fillColor: AppColors.white1,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
