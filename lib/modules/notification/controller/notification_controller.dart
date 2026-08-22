import 'package:get/get.dart';

class NotificationController extends GetxController {
  final notifications = [
    {
      'id': '1',
      'title': 'Order Confirmed',
      'message': 'Your order ORD-001 has been confirmed',
      'type': 'order',
      'time': '2 hours ago',
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'Special Offer',
      'message': '50% off on electronics. Shop now!',
      'type': 'offer',
      'time': '5 hours ago',
      'isRead': false,
    },
    {
      'id': '3',
      'title': 'Order Shipped',
      'message': 'Your order is on the way',
      'type': 'order',
      'time': '1 day ago',
      'isRead': true,
    },
  ].obs;

  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n['id'] == notificationId);
    if (index >= 0) {
      notifications[index]['isRead'] = true;
      notifications.refresh();
    }
  }

  void deleteNotification(String notificationId) {
    notifications.removeWhere((n) => n['id'] == notificationId);
  }

  void markAllRead() {
    for (final n in notifications) {
      n['isRead'] = true;
    }
    notifications.refresh();
  }

  bool get hasUnread => notifications.any((n) => n['isRead'] == false);
}
