import 'package:get/get.dart';

class PaymentSuccessController extends GetxController {
  final RxString transactionId = '00003938237022'.obs;
  final RxString amount = '\$418.00'.obs;
  final RxString paymentMethod = 'Master Card'.obs;
  final RxString paymentDate = 'Sat, 25 Apr 2026'.obs;
  final RxString paymentTime = '18:31:27'.obs;
  final RxString recipientName = 'Devon Lane'.obs;

  void downloadReceipt() {
    Get.snackbar(
      'Receipt Downloaded',
      'PDF receipt has been downloaded successfully',
      duration: const Duration(seconds: 2),
    );
  }

  void shareReceipt() {
    Get.snackbar(
      'Share Receipt',
      'Share options opened',
      duration: const Duration(seconds: 2),
    );
  }

  void backToHome() {
    Get.offAllNamed('/home');
  }
}
