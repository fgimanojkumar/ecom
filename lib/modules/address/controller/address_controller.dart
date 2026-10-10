import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../shared/demo/demo_account_store.dart';
import '../../../shared/utils/location_util.dart';

class AddressController extends GetxController {
  static AddressController ensureInitialized() {
    if (Get.isRegistered<AddressController>()) {
      return Get.find<AddressController>();
    }
    return Get.put(AddressController(), permanent: true);
  }

  final RxBool isFormVisible = false.obs;
  final RxString selectedType = 'Home'.obs;
  final RxInt _idCounter = 3.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();

  final RxList<Map<String, dynamic>> addresses = DemoAccountStore.addresses.obs;

  Map<String, dynamic>? get selectedAddress {
    for (final address in addresses) {
      if (address['isDefault'] == true) return address;
    }
    return addresses.isEmpty ? null : addresses.first;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    buildingController.dispose();
    landmarkController.dispose();
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

  Future<void> fillAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    final address = await LocationUtil.getAddressFromCoordinates(
      latitude,
      longitude,
    );
    if (address == null) {
      Get.snackbar(
        'Address not found',
        'Please enter the address details manually.',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    streetController.text = address['street'] ?? '';
    cityController.text = address['city'] ?? '';
    stateController.text = address['state'] ?? '';
    pincodeController.text = address['pincode'] ?? '';

    if (address.values.any((value) => value.isEmpty)) {
      Get.snackbar(
        'Location added',
        'Review the address and complete any missing fields before saving.',
        duration: const Duration(seconds: 3),
      );
    } else {
      Get.snackbar(
        'Location added',
        'Review or edit the filled address before saving.',
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> useCurrentLocation() async {
    isFormVisible.value = true;
    try {
      final coordinates = await LocationUtil.getLatLong();
      if (coordinates is! List || coordinates.length < 2) {
        throw StateError('Current location is unavailable.');
      }
      await fillAddressFromCoordinates(
        (coordinates[0] as num).toDouble(),
        (coordinates[1] as num).toDouble(),
      );
    } catch (_) {
      Get.snackbar(
        'Location unavailable',
        'Allow location access or choose a point on the map.',
        duration: const Duration(seconds: 2),
      );
    }
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    streetController.clear();
    buildingController.clear();
    landmarkController.clear();
    cityController.clear();
    stateController.clear();
    pincodeController.clear();
    selectedType.value = 'Home';
  }

  bool saveAddress() {
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
      return false;
    }

    addresses.insert(0, {
      'id': _idCounter.value.toString(),
      'type': selectedType.value,
      'name': nameController.text.trim(),
      'phone': phoneController.text.trim(),
      'street': streetController.text.trim(),
      'building': buildingController.text.trim(),
      'landmark': landmarkController.text.trim(),
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
    return true;
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
