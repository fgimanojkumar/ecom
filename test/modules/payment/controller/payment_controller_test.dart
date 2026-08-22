import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:imoss/modules/payment/controller/payment_controller.dart';

class _FakePaymentGateway implements PaymentGateway {
  PaymentRequest? latestRequest;
  bool openCalled = false;
  bool clearCalled = false;
  bool throwOnOpen = false;

  void Function(String paymentId)? _onSuccess;
  void Function(String message)? _onError;
  void Function(String walletName)? _onExternalWallet;

  @override
  void open({
    required PaymentRequest request,
    required void Function(String paymentId) onSuccess,
    required void Function(String message) onError,
    required void Function(String walletName) onExternalWallet,
  }) {
    if (throwOnOpen) {
      throw Exception('open failed');
    }

    openCalled = true;
    latestRequest = request;
    _onSuccess = onSuccess;
    _onError = onError;
    _onExternalWallet = onExternalWallet;
  }

  @override
  void clear() {
    clearCalled = true;
  }

  void triggerSuccess(String paymentId) {
    _onSuccess?.call(paymentId);
  }

  void triggerError(String message) {
    _onError?.call(message);
  }

  void triggerExternalWallet(String walletName) {
    _onExternalWallet?.call(walletName);
  }
}

void main() {
  setUp(() {
    Get.testMode = true;
  });

  test('initRazorpay opens gateway with expected request payload', () async {
    final fakeGateway = _FakePaymentGateway();
    final controller = PaymentController(
      paymentGateway: fakeGateway,
      razorpayKey: 'rzp_test_123',
      enableUiFeedback: false,
    );

    await controller.initRazorpay(41600, 'ORD-001');

    expect(fakeGateway.openCalled, isTrue);
    expect(controller.isProcessing.value, isTrue);
    expect(controller.paymentStatus.value, 'initiated');
    expect(fakeGateway.latestRequest?.amountInPaise, 41600);
    expect(fakeGateway.latestRequest?.orderId, 'ORD-001');
    expect(fakeGateway.latestRequest?.key, 'rzp_test_123');
  });

  test('success callback updates status and triggers navigation callback',
      () async {
    final fakeGateway = _FakePaymentGateway();
    var didNavigate = false;

    final controller = PaymentController(
      paymentGateway: fakeGateway,
      enableUiFeedback: false,
      onNavigateToOrderConfirmation: () {
        didNavigate = true;
      },
    );

    await controller.initRazorpay(41600, 'ORD-002');
    fakeGateway.triggerSuccess('pay_123');

    expect(controller.paymentStatus.value, 'success');
    expect(controller.isProcessing.value, isFalse);
    expect(didNavigate, isTrue);
  });

  test('error callback updates status and stops processing', () async {
    final fakeGateway = _FakePaymentGateway();
    final controller = PaymentController(
      paymentGateway: fakeGateway,
      enableUiFeedback: false,
    );

    await controller.initRazorpay(41600, 'ORD-003');
    fakeGateway.triggerError('network');

    expect(controller.paymentStatus.value, 'error');
    expect(controller.isProcessing.value, isFalse);
  });

  test('external wallet callback updates status and stops processing',
      () async {
    final fakeGateway = _FakePaymentGateway();
    final controller = PaymentController(
      paymentGateway: fakeGateway,
      enableUiFeedback: false,
    );

    await controller.initRazorpay(41600, 'ORD-004');
    fakeGateway.triggerExternalWallet('paytm');

    expect(controller.paymentStatus.value, 'external_wallet');
    expect(controller.isProcessing.value, isFalse);
  });

  test('invalid amount does not open payment gateway', () async {
    final fakeGateway = _FakePaymentGateway();
    final controller = PaymentController(
      paymentGateway: fakeGateway,
      enableUiFeedback: false,
    );

    await controller.initRazorpay(0, 'ORD-005');

    expect(fakeGateway.openCalled, isFalse);
    expect(controller.paymentStatus.value, 'error');
    expect(controller.isProcessing.value, isFalse);
  });

  test('open exception moves controller to error state', () async {
    final fakeGateway = _FakePaymentGateway()..throwOnOpen = true;
    final controller = PaymentController(
      paymentGateway: fakeGateway,
      enableUiFeedback: false,
    );

    await controller.initRazorpay(41600, 'ORD-006');

    expect(controller.paymentStatus.value, 'error');
    expect(controller.isProcessing.value, isFalse);
  });

  test('onClose clears payment gateway listeners', () {
    final fakeGateway = _FakePaymentGateway();
    final controller = PaymentController(
      paymentGateway: fakeGateway,
      enableUiFeedback: false,
    );

    controller.onClose();

    expect(fakeGateway.clearCalled, isTrue);
  });
}
