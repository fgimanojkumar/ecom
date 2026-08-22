import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  final orders = [
    {
      'id': 'ORD-001',
      'date': '2024-01-15',
      'items': 3,
      'total': 5950.0,
      'status': 'Delivered',
      'statusColor': 'green',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
    },
    {
      'id': 'ORD-002',
      'date': '2024-01-20',
      'items': 2,
      'total': 3999.0,
      'status': 'In Transit',
      'statusColor': 'blue',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
    },
    {
      'id': 'ORD-003',
      'date': '2024-01-25',
      'items': 1,
      'total': 899.0,
      'status': 'Pending',
      'statusColor': 'orange',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
    },
  ].obs;

  void viewOrderDetails(String orderId) {
    Get.toNamed('/orderTracking', arguments: orderId);
  }
}
