import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final selectedCategoryId = ''.obs;

  final categories = [
    {
      'id': '1',
      'name': 'Electronics',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      'icon': '0xe7fd',
    },
    {
      'id': '2',
      'name': 'Fashion',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
      'icon': '0xe280',
    },
    {
      'id': '3',
      'name': 'Beauty',
      'image':
          'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=600',
      'icon': '0xe888',
    },
    {
      'id': '5',
      'name': 'Sports',
      'image':
          'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=600',
      'icon': '0xe926',
    },
    {
      'id': '6',
      'name': 'Mobiles & Tablets',
      'image':
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=600',
      'icon': '0xe325',
    },
    {
      'id': '7',
      'name': 'Groceries',
      'image':
          'https://images.unsplash.com/photo-1542838132-92c53300491e?w=600',
      'icon': '0xe8cc',
    },
    {
      'id': '8',
      'name': 'Footwear',
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600',
      'icon': '0xe54c',
    },
    {
      'id': '9',
      'name': 'Books',
      'image':
          'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=600',
      'icon': '0xe865',
    },
    {
      'id': '10',
      'name': 'Toys & Baby',
      'image':
          'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=600',
      'icon': '0xe332',
    },
    {
      'id': '11',
      'name': 'Jewellery',
      'image':
          'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=600',
      'icon': '0xe8f6',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    if (categories.isNotEmpty) {
      selectedCategoryId.value = categories.first['id'] as String;
    }
  }

  void selectCategory(String categoryId) {
    selectedCategoryId.value = categoryId;
  }

  void viewCategory(String categoryId) {
    Get.toNamed('/home');
  }
}
