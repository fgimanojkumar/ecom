import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final selectedAddressId = ''.obs;
  final selectedPaymentMethod = 'razorpay'.obs;

  final addresses = [
    {
      'id': '1',
      'name': 'Home',
      'street': '123 Main St',
      'city': 'Mumbai',
      'state': 'Maharashtra',
      'pincode': '400001',
    },
    {
      'id': '2',
      'name': 'Office',
      'street': '456 Business Ave',
      'city': 'Bangalore',
      'state': 'Karnataka',
      'pincode': '560001',
    },
  ].obs;

  final paymentMethods = [
    {'id': 'razorpay', 'name': 'Razorpay', 'icon': 'payment'},
    {'id': 'debit', 'name': 'Debit Card', 'icon': 'credit_card'},
    {'id': 'credit', 'name': 'Credit Card', 'icon': 'credit_card'},
    {'id': 'upi', 'name': 'UPI', 'icon': 'phone_android'},
    {'id': 'wallet', 'name': 'Wallet', 'icon': 'account_balance_wallet'},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    if (addresses.isNotEmpty) {
      selectedAddressId.value = addresses[0]['id']!;
    }
  }

  Future<void> initiatePayment() async {
    if (selectedAddressId.isEmpty) {
      Get.snackbar('Error', 'Please select an address');
      return;
    }

    Get.snackbar('Processing', 'Initiating payment...');
    // Razorpay integration logic here
    await Future.delayed(const Duration(seconds: 2));
    Get.toNamed('/orderConfirmation');
  }
}
