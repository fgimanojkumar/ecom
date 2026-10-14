import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../data/models/seller_order_model.dart';
import '../style/app_colors.dart';

/// Shows an instant "new order" alert the moment an order comes in -
/// local system notification (with sound) when the app is backgrounded,
/// plus an in-app sound + banner when the seller is already using the app.
/// This mirrors the Flipkart/Amazon seller-app new-order alert experience.
class OrderNotificationService extends GetxService {
  static OrderNotificationService get to => Get.find();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'new_order_channel';
  static const _channelName = 'New Orders';
  static const _channelDescription =
      'Alerts you instantly when a new order is placed';

  Future<OrderNotificationService> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    try {
      await _localNotifications.initialize(
        settings:
            const InitializationSettings(android: androidInit, iOS: iosInit),
        onDidReceiveNotificationResponse: _onNotificationTap,
      );

      final androidPlugin =
          _localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelId,
          _channelName,
          description: _channelDescription,
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
        ),
      );
      await androidPlugin?.requestNotificationsPermission();
    } catch (e) {
      log('OrderNotificationService init failed: $e');
    }
    return this;
  }

  void _onNotificationTap(NotificationResponse response) {
    final orderId = response.payload;
    if (orderId != null && orderId.isNotEmpty) {
      Get.toNamed('/sellerOrderDetail', arguments: orderId);
    }
  }

  /// Builds a minimal [SellerOrder] out of an FCM `data` payload so a real
  /// backend push (`type: new_order`) can drive the same alert pipeline
  /// used by the demo order simulator.
  static SellerOrder orderFromPushData(Map<String, dynamic> data) {
    return SellerOrder(
      id: data['orderId']?.toString() ??
          'ORD-${DateTime.now().millisecondsSinceEpoch}',
      customerName: data['customerName']?.toString() ?? 'New Customer',
      customerPhone: data['customerPhone']?.toString() ?? '',
      shippingAddress: data['address']?.toString() ?? '',
      paymentMethod: data['paymentMethod']?.toString() ?? 'N/A',
      items: [
        SellerOrderItem(
          productName: data['productName']?.toString() ?? 'Item',
          productImage: 'resources/images/login_img.png',
          quantity: int.tryParse(data['quantity']?.toString() ?? '1') ?? 1,
          price: double.tryParse(data['amount']?.toString() ?? '0') ?? 0,
        ),
      ],
      orderDate: DateTime.now(),
      status: SellerOrderStatus.pending,
    );
  }

  /// Fires the full "new order" alert: system notification + sound +
  /// an in-app banner if the seller is currently looking at the app.
  Future<void> notifyNewOrder(SellerOrder order) async {
    final amount = order.totalAmount.toStringAsFixed(0);
    final title = '🛎️ New Order Received!';
    final body =
        '${order.id} • ${order.customerName} • ₹$amount (${order.itemCount} item${order.itemCount > 1 ? 's' : ''})';

    // Audible cue immediately, independent of the system notification sound.
    SystemSound.play(SystemSoundType.alert);
    HapticFeedback.heavyImpact();

    try {
      await _localNotifications.show(
        id: order.id.hashCode,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentSound: true,
            presentAlert: true,
            presentBadge: true,
          ),
        ),
        payload: order.id,
      );
    } catch (e) {
      log('Failed to show local notification: $e');
    }

    _showInAppBanner(title: title, body: body, orderId: order.id);
  }

  void _showInAppBanner({
    required String title,
    required String body,
    required String orderId,
  }) {
    final context = Get.overlayContext ?? Get.context;
    if (context == null) return;

    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      title,
      body,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary1,
      colorText: AppColors.white,
      icon: const Icon(Icons.notifications_active_rounded,
          color: AppColors.white),
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(12),
      borderRadius: 14,
      isDismissible: true,
      onTap: (_) => Get.toNamed('/sellerOrderDetail', arguments: orderId),
      mainButton: TextButton(
        onPressed: () => Get.toNamed('/sellerOrderDetail', arguments: orderId),
        child: const Text('VIEW', style: TextStyle(color: AppColors.white)),
      ),
    );
  }
}
