enum CustomerStatus { active, inactive }

extension CustomerStatusX on CustomerStatus {
  String get label => this == CustomerStatus.active ? 'Active' : 'Inactive';
}

class SellerCustomer {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime joinedDate;
  final int totalOrders;
  final double totalSpent;
  final CustomerStatus status;

  SellerCustomer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.joinedDate,
    required this.totalOrders,
    required this.totalSpent,
    required this.status,
  });
}
