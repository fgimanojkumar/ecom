import 'package:intl/intl.dart';

enum OrderStatus { pending, confirmed, shipped, delivered, cancelled, returned }

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final OrderStatus status;
  final double totalAmount;
  final String deliveryAddress;
  final String paymentMethod;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String trackingId;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.status,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.orderDate,
    this.deliveryDate,
    required this.trackingId,
  });

  String get formattedDate => DateFormat('dd MMM yyyy').format(orderDate);
  String get statusText => status.name.toUpperCase();
}

class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final int quantity;
  final double price;
  final String selectedSize;
  final String selectedColor;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.price,
    required this.selectedSize,
    required this.selectedColor,
  });

  double get subtotal => price * quantity;
}
