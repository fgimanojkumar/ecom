import 'package:intl/intl.dart';

/// Order lifecycle mirrored from the admin dashboard (hgfedcba orders module).
enum SellerOrderStatus {
  pending,
  confirmed,
  packed,
  shipped,
  outForDelivery,
  delivered,
  cancelled,
  returned,
}

extension SellerOrderStatusX on SellerOrderStatus {
  String get label {
    switch (this) {
      case SellerOrderStatus.pending:
        return 'Pending';
      case SellerOrderStatus.confirmed:
        return 'Confirmed';
      case SellerOrderStatus.packed:
        return 'Packed';
      case SellerOrderStatus.shipped:
        return 'Shipped';
      case SellerOrderStatus.outForDelivery:
        return 'Out for Delivery';
      case SellerOrderStatus.delivered:
        return 'Delivered';
      case SellerOrderStatus.cancelled:
        return 'Cancelled';
      case SellerOrderStatus.returned:
        return 'Returned';
    }
  }

  /// Next status a seller can move the order to, null when it's a terminal state.
  SellerOrderStatus? get next {
    switch (this) {
      case SellerOrderStatus.pending:
        return SellerOrderStatus.confirmed;
      case SellerOrderStatus.confirmed:
        return SellerOrderStatus.packed;
      case SellerOrderStatus.packed:
        return SellerOrderStatus.shipped;
      case SellerOrderStatus.shipped:
        return SellerOrderStatus.outForDelivery;
      case SellerOrderStatus.outForDelivery:
        return SellerOrderStatus.delivered;
      case SellerOrderStatus.delivered:
      case SellerOrderStatus.cancelled:
      case SellerOrderStatus.returned:
        return null;
    }
  }
}

class SellerOrderStatusEvent {
  final SellerOrderStatus status;
  final DateTime timestamp;
  final String? note;

  SellerOrderStatusEvent({
    required this.status,
    required this.timestamp,
    this.note,
  });

  String get formattedTime => DateFormat('dd MMM, hh:mm a').format(timestamp);
}

class SellerOrderItem {
  final String productName;
  final String productImage;
  final int quantity;
  final double price;

  SellerOrderItem({
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.price,
  });

  double get subtotal => price * quantity;
}

class SellerOrder {
  final String id;
  final String customerName;
  final String customerPhone;
  final String shippingAddress;
  final String paymentMethod;
  final List<SellerOrderItem> items;
  final DateTime orderDate;
  SellerOrderStatus status;
  final List<SellerOrderStatusEvent> statusHistory;

  SellerOrder({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.items,
    required this.orderDate,
    required this.status,
    List<SellerOrderStatusEvent>? statusHistory,
  }) : statusHistory = statusHistory ??
            [
              SellerOrderStatusEvent(status: status, timestamp: orderDate),
            ];

  double get totalAmount => items.fold(0, (sum, item) => sum + item.subtotal);

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  String get formattedDate =>
      DateFormat('dd MMM yyyy, hh:mm a').format(orderDate);

  void updateStatus(SellerOrderStatus newStatus, {String? note}) {
    status = newStatus;
    statusHistory.add(
      SellerOrderStatusEvent(
        status: newStatus,
        timestamp: DateTime.now(),
        note: note,
      ),
    );
  }
}
