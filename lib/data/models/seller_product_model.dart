enum ProductStatus { active, inactive, draft }

extension ProductStatusX on ProductStatus {
  String get label => switch (this) {
        ProductStatus.active => 'Active',
        ProductStatus.inactive => 'Inactive',
        ProductStatus.draft => 'Draft',
      };
}

class SellerProduct {
  final String id;
  String name;
  String sku;
  double price;
  int stock;
  ProductStatus status;

  SellerProduct({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.stock,
    required this.status,
  });
}
