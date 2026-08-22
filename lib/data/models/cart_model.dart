import 'product_model.dart';

class CartItem {
  final String id;
  final Product product;
  int quantity;
  final String selectedSize;
  final String selectedColor;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
  });

  double get subtotal => product.price * quantity;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}

class Cart {
  final List<CartItem> items;
  final double taxRate;
  final double deliveryCharge;

  Cart({
    required this.items,
    this.taxRate = 0.18,
    this.deliveryCharge = 50.0,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.subtotal);
  double get tax => subtotal * taxRate;
  double get total => subtotal + tax + deliveryCharge;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
