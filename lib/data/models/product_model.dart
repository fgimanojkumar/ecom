class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final String image;
  final List<String> images;
  final String category;
  final String subCategory;
  final int stock;
  final List<String> sizes;
  final List<String> colors;
  final bool isWishlisted;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.image,
    required this.images,
    required this.category,
    required this.subCategory,
    required this.stock,
    this.sizes = const [],
    this.colors = const [],
    this.isWishlisted = false,
  });

  double get discount {
    return ((originalPrice - price) / originalPrice * 100).toStringAsFixed(0)
        as double;
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    double? rating,
    int? reviewCount,
    String? image,
    List<String>? images,
    String? category,
    String? subCategory,
    int? stock,
    List<String>? sizes,
    List<String>? colors,
    bool? isWishlisted,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      image: image ?? this.image,
      images: images ?? this.images,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      stock: stock ?? this.stock,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      isWishlisted: isWishlisted ?? this.isWishlisted,
    );
  }
}
