import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/widgets/app_toast.dart';

class PaymentRequest {
  final String key;
  final int amountInPaise;
  final String orderId;
  final String merchantName;
  final String description;
  final String? contact;
  final String? email;
  final List<String> wallets;

  const PaymentRequest({
    required this.key,
    required this.amountInPaise,
    required this.orderId,
    required this.merchantName,
    required this.description,
    this.contact,
    this.email,
    this.wallets = const <String>['paytm'],
  });
}

abstract class PaymentGateway {
  void open({
    required PaymentRequest request,
    required void Function(String paymentId) onSuccess,
    required void Function(String message) onError,
    required void Function(String walletName) onExternalWallet,
  });

  void clear();
}

class RazorpayPaymentGateway implements PaymentGateway {
  final Razorpay _razorpay;

  RazorpayPaymentGateway({Razorpay? razorpay})
      : _razorpay = razorpay ?? Razorpay();

  @override
  void open({
    required PaymentRequest request,
    required void Function(String paymentId) onSuccess,
    required void Function(String message) onError,
    required void Function(String walletName) onExternalWallet,
  }) {
    _razorpay.clear();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      onSuccess(response.paymentId ?? '');
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      onError(response.message ?? 'Payment failed');
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      onExternalWallet(response.walletName ?? 'wallet');
    });

    final Map<String, dynamic> options = <String, dynamic>{
      'key': request.key,
      'amount': request.amountInPaise,
      'name': request.merchantName,
      'description': request.description,
      'prefill': <String, String>{
        if (request.contact != null && request.contact!.isNotEmpty)
          'contact': request.contact!,
        if (request.email != null && request.email!.isNotEmpty)
          'email': request.email!,
      },
      'external': <String, List<String>>{
        'wallets': request.wallets,
      },
      'notes': <String, String>{
        'order_id': request.orderId,
      },
    };

    _razorpay.open(options);
  }

  @override
  void clear() {
    _razorpay.clear();
  }
}

class PaymentController extends GetxController {
  PaymentController({
    PaymentGateway? paymentGateway,
    this.razorpayKey = 'rzp_test_1DP5mmOlF5G5ag',
    this.enableUiFeedback = true,
    this.onNavigateToOrderConfirmation,
  }) : _paymentGateway = paymentGateway ?? RazorpayPaymentGateway();

  final PaymentGateway _paymentGateway;
  final String razorpayKey;
  final bool enableUiFeedback;
  final VoidCallback? onNavigateToOrderConfirmation;

  final isProcessing = false.obs;
  final paymentStatus = ''.obs;

  Future<void> initRazorpay(int amountInPaise, String orderId) async {
    if (isProcessing.value) {
      return;
    }

    if (amountInPaise <= 0) {
      _setError('Invalid amount. Please try again.');
      return;
    }

    if (kIsWeb) {
      _setError('Razorpay is not supported for web builds.');
      return;
    }

    isProcessing.value = true;
    paymentStatus.value = 'initiated';

    try {
      _paymentGateway.open(
        request: PaymentRequest(
          key: razorpayKey,
          amountInPaise: amountInPaise,
          orderId: orderId,
          merchantName: 'ShopHub',
          description: 'Payment for Order $orderId',
          contact: '9999999999',
          email: 'user@example.com',
        ),
        onSuccess: _handlePaymentSuccess,
        onError: _handlePaymentError,
        onExternalWallet: _handleExternalWallet,
      );
    } catch (e) {
      _setError('Unable to start payment: $e');
      isProcessing.value = false;
    }
  }

  void _handlePaymentSuccess(String paymentId) {
    paymentStatus.value = 'success';
    isProcessing.value = false;
    _showSuccessToast('Payment completed successfully');
    _showSnackbar('Success', 'Payment completed successfully');

    if (onNavigateToOrderConfirmation != null) {
      onNavigateToOrderConfirmation!.call();
      return;
    }

    Get.toNamed(AppRoutes().paymentSuccess);
  }

  void _handlePaymentError(String message) {
    _setError('Payment failed: $message');
    isProcessing.value = false;
  }

  void _handleExternalWallet(String walletName) {
    paymentStatus.value = 'external_wallet';
    isProcessing.value = false;
    _showSuccessToast('$walletName selected');
    _showSnackbar('External Wallet', '$walletName selected');
  }

  void _setError(String message) {
    paymentStatus.value = 'error';
    _showErrorToast(message);
    _showSnackbar('Error', message);
  }

  void _showSuccessToast(String message) {
    if (!enableUiFeedback) {
      return;
    }

    AppToast.successToast(message);
  }

  void _showErrorToast(String message) {
    if (!enableUiFeedback) {
      return;
    }

    AppToast.errorToast(message);
  }

  void _showSnackbar(String title, String message) {
    if (!enableUiFeedback) {
      return;
    }

    Get.snackbar(title, message);
  }

  @override
  void onClose() {
    _paymentGateway.clear();
    super.onClose();
  }
}
