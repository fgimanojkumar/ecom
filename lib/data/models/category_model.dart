class Category {
  final String id;
  final String name;
  final String image;
  final String icon;
  final List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.icon,
    required this.subCategories,
  });
}

class SubCategory {
  final String id;
  final String name;
  final String image;
  final String categoryId;

  SubCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.categoryId,
  });
}
