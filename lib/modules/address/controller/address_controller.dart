import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddressController extends GetxController {
  final RxBool isFormVisible = false.obs;
  final RxString selectedType = 'Home'.obs;
  final RxInt _idCounter = 3.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();

  final addresses = [
    {
      'id': '1',
      'type': 'Home',
      'name': 'John Doe',
      'phone': '9999999999',
      'street': '123 Main St',
      'city': 'Mumbai',
      'state': 'Maharashtra',
      'pincode': '400001',
      'isDefault': true,
    },
    {
      'id': '2',
      'type': 'Office',
      'name': 'John Doe',
      'phone': '9999999999',
      'street': '456 Business Ave',
      'city': 'Bangalore',
      'state': 'Karnataka',
      'pincode': '560001',
      'isDefault': false,
    },
  ].obs;

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    super.onClose();
  }

  void toggleForm() {
    isFormVisible.value = !isFormVisible.value;
  }

  void hideForm() {
    isFormVisible.value = false;
  }

  void selectType(String type) {
    selectedType.value = type;
  }

  void useCurrentLocation() {
    streetController.text = 'Current Location Street';
    cityController.text = 'Mumbai';
    stateController.text = 'Maharashtra';
    pincodeController.text = '400001';
    if (!isFormVisible.value) {
      isFormVisible.value = true;
    }
    Get.snackbar(
      'Location Added',
      'Current location filled in address form',
      duration: const Duration(milliseconds: 1400),
    );
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    streetController.clear();
    cityController.clear();
    stateController.clear();
    pincodeController.clear();
    selectedType.value = 'Home';
  }

  void saveAddress() {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        streetController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        stateController.text.trim().isEmpty ||
        pincodeController.text.trim().isEmpty) {
      Get.snackbar(
        'Missing Details',
        'Please fill all address fields',
        duration: const Duration(milliseconds: 1400),
      );
      return;
    }

    addresses.insert(0, {
      'id': _idCounter.value.toString(),
      'type': selectedType.value,
      'name': nameController.text.trim(),
      'phone': phoneController.text.trim(),
      'street': streetController.text.trim(),
      'city': cityController.text.trim(),
      'state': stateController.text.trim(),
      'pincode': pincodeController.text.trim(),
      'isDefault': addresses.isEmpty,
    });

    _idCounter.value = _idCounter.value + 1;
    clearForm();
    hideForm();

    Get.snackbar(
      'Address Added',
      'Your new address has been saved',
      duration: const Duration(milliseconds: 1400),
    );
  }

  void addAddress() {
    toggleForm();
  }

  void editAddress(String addressId) {
    Get.toNamed('/editAddress', arguments: addressId);
  }

  void deleteAddress(String addressId) {
    addresses.removeWhere((addr) => addr['id'] == addressId);
  }

  void setDefaultAddress(String addressId) {
    for (var addr in addresses) {
      addr['isDefault'] = addr['id'] == addressId;
    }
    addresses.refresh();
  }
}
