import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

import '../../data/models/seller_order_model.dart';

/// In-memory demo data source standing in for the seller orders backend.
/// Also simulates new orders arriving in real time (like Flipkart/Amazon
/// seller apps) so the new-order notification flow can be demonstrated
/// end-to-end before a real backend/socket is wired in.
class SellerOrderStore {
  SellerOrderStore._();

  static final RxList<SellerOrder> orders = <SellerOrder>[].obs;
  static Timer? _simulatorTimer;

  static final _random = Random();
  static const _customerNames = [
    'Rohit Verma',
    'Priya Nair',
    'Aditya Singh',
    'Sneha Kulkarni',
    'Imran Shaikh',
    'Kavya Reddy',
  ];
  static const _products = [
    'Wireless Earbuds',
    'Cotton Kurta',
    'Running Shoes',
    'Smart Watch',
    'Backpack',
    'Table Lamp',
  ];

  static void seedIfEmpty() {
    if (orders.isNotEmpty) return;
    final now = DateTime.now();
    orders.addAll([
      SellerOrder(
        id: 'ORD-20098',
        customerName: 'Rohit Verma',
        customerPhone: '9876500011',
        shippingAddress: '221, MG Road, Pune, MH 411001',
        paymentMethod: 'UPI',
        items: [
          SellerOrderItem(
            productName: 'Wireless Earbuds',
            productImage: 'resources/images/login_img.png',
            quantity: 1,
            price: 1899,
          ),
        ],
        orderDate: now.subtract(const Duration(hours: 2)),
        status: SellerOrderStatus.pending,
      ),
      SellerOrder(
        id: 'ORD-20097',
        customerName: 'Priya Nair',
        customerPhone: '9876500022',
        shippingAddress: '14, Lake View Apartments, Kochi, KL 682001',
        paymentMethod: 'Card',
        items: [
          SellerOrderItem(
            productName: 'Cotton Kurta',
            productImage: 'resources/images/login_img.png',
            quantity: 2,
            price: 899,
          ),
        ],
        orderDate: now.subtract(const Duration(hours: 6)),
        status: SellerOrderStatus.confirmed,
      ),
      SellerOrder(
        id: 'ORD-20095',
        customerName: 'Aditya Singh',
        customerPhone: '9876500033',
        shippingAddress: '7, Sector 21, Noida, UP 201301',
        paymentMethod: 'COD',
        items: [
          SellerOrderItem(
            productName: 'Running Shoes',
            productImage: 'resources/images/login_img.png',
            quantity: 1,
            price: 2499,
          ),
        ],
        orderDate: now.subtract(const Duration(days: 1)),
        status: SellerOrderStatus.shipped,
      ),
      SellerOrder(
        id: 'ORD-20090',
        customerName: 'Sneha Kulkarni',
        customerPhone: '9876500044',
        shippingAddress: '56, FC Road, Pune, MH 411004',
        paymentMethod: 'UPI',
        items: [
          SellerOrderItem(
            productName: 'Smart Watch',
            productImage: 'resources/images/login_img.png',
            quantity: 1,
            price: 3499,
          ),
        ],
        orderDate: now.subtract(const Duration(days: 3)),
        status: SellerOrderStatus.delivered,
      ),
      SellerOrder(
        id: 'ORD-20085',
        customerName: 'Imran Shaikh',
        customerPhone: '9876500055',
        shippingAddress: '9, Andheri West, Mumbai, MH 400058',
        paymentMethod: 'Card',
        items: [
          SellerOrderItem(
            productName: 'Backpack',
            productImage: 'resources/images/login_img.png',
            quantity: 1,
            price: 1599,
          ),
        ],
        orderDate: now.subtract(const Duration(days: 5)),
        status: SellerOrderStatus.cancelled,
      ),
    ]);
  }

  /// Called whenever a new order should be added (new real order, or demo tick).
  static void addIncomingOrder(void Function(SellerOrder order) onAdded) {
    final name = _customerNames[_random.nextInt(_customerNames.length)];
    final product = _products[_random.nextInt(_products.length)];
    final qty = 1 + _random.nextInt(2);
    final price = (300 + _random.nextInt(2500)).toDouble();
    final order = SellerOrder(
      id: 'ORD-${20100 + orders.length + _random.nextInt(900)}',
      customerName: name,
      customerPhone: '98765${(10000 + _random.nextInt(89999))}',
      shippingAddress: 'New order delivery address, India',
      paymentMethod: _random.nextBool() ? 'UPI' : 'COD',
      items: [
        SellerOrderItem(
          productName: product,
          productImage: 'resources/images/login_img.png',
          quantity: qty,
          price: price,
        ),
      ],
      orderDate: DateTime.now(),
      status: SellerOrderStatus.pending,
    );
    orders.insert(0, order);
    onAdded(order);
  }

  /// Starts the demo "new order" stream. Replace with a real socket/FCM
  /// driven trigger once the backend pushes live order events.
  static void startDemoIncomingOrders(
    void Function(SellerOrder order) onNewOrder,
  ) {
    _simulatorTimer?.cancel();
    _simulatorTimer = Timer.periodic(const Duration(seconds: 35), (_) {
      addIncomingOrder(onNewOrder);
    });
  }

  static void stopDemoIncomingOrders() {
    _simulatorTimer?.cancel();
    _simulatorTimer = null;
  }
}
