import 'package:get/get.dart';
import '../../../shared/demo/demo_account_store.dart';
import '../../cart/controller/cart_controller.dart';

class CheckoutController extends GetxController {
  final activeStep = 0.obs;
  final selectedAddressId = ''.obs;
  final selectedBillingAddressId = ''.obs;
  final useDeliveryAddressForBilling = true.obs;
  final selectedPaymentMethod = 'razorpay'.obs;

  final RxList<Map<String, dynamic>> addresses = DemoAccountStore.addresses.obs;

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
      selectedBillingAddressId.value = addresses[0]['id']!;
    }
  }

  bool continueToNextStep() {
    if (activeStep.value == 0) {
      if (selectedAddressId.isEmpty) {
        Get.snackbar(
            'Address required', 'Select a delivery address to continue.');
        return false;
      }
      if (!useDeliveryAddressForBilling.value &&
          selectedBillingAddressId.isEmpty) {
        Get.snackbar('Billing address required',
            'Select a billing address to continue.');
        return false;
      }
    }
    if (activeStep.value < 3) activeStep.value++;
    return true;
  }

  void goToPreviousStep() {
    if (activeStep.value > 0) activeStep.value--;
  }

  Future<void> initiatePayment() async {
    if (selectedAddressId.isEmpty) {
      Get.snackbar('Error', 'Please select an address');
      return;
    }

    if (await DemoAccountStore.restoreSession() == null) {
      Get.snackbar('Sign in required', 'Sign in with the demo account first.');
      Get.toNamed('/login');
      return;
    }

    final cartController = CartController.ensureInitialized();
    if (cartController.cartItems.isEmpty) {
      Get.snackbar('Cart is empty', 'Add an item before placing your order.');
      Get.offNamed('/home');
      return;
    }
    Get.snackbar('Demo payment', 'Completing your test order...');
    await Future.delayed(const Duration(milliseconds: 700));

    final order = DemoAccountStore.recordOrder(
      itemCount: cartController.itemCount,
      subtotal: cartController.discountedSubtotal,
      shipping: CartController.shippingCharge,
      tax: cartController.tax,
      total: cartController.total,
      addressId: selectedAddressId.value,
      billingAddressId: useDeliveryAddressForBilling.value
          ? selectedAddressId.value
          : selectedBillingAddressId.value,
      paymentMethod: selectedPaymentMethod.value,
      lines: cartController.cartItems
          .map(
            (item) => <String, dynamic>{
              'name': item.product.name,
              'image': item.product.image,
              'qty': item.quantity,
              'price': item.product.price,
            },
          )
          .toList(),
    );
    cartController.cartItems.clear();
    cartController.update();
    Get.toNamed('/orderConfirmation', arguments: order['id']);
  }
}
