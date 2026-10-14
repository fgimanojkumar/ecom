enum CategoryStatus { active, inactive }

extension CategoryStatusX on CategoryStatus {
  String get label => this == CategoryStatus.active ? 'Active' : 'Inactive';
}

class SellerCategory {
  final String id;
  String name;
  String description;
  double gstRate;
  String hsnCode;
  int productCount;
  CategoryStatus status;

  SellerCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.gstRate,
    required this.hsnCode,
    required this.productCount,
    required this.status,
  });
}
