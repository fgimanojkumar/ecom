import 'package:get/get.dart';

class SubCategoriesController extends GetxController {
  // Parent category id received via Get.arguments
  String? parentCategoryId;

  final subcategories = <Map<String, dynamic>>[].obs;

  // Full map: parentId → list of subcategories
  static const _data = {
    '1': [
      {
        'id': '1-1',
        'name': 'Smartphones',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      },
      {
        'id': '1-2',
        'name': 'Laptops',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
      },
      {
        'id': '1-3',
        'name': 'Tablets',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      },
      {
        'id': '1-4',
        'name': 'Audio',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      },
    ],
    '2': [
      {
        'id': '2-1',
        'name': "Men's Wear",
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      },
      {
        'id': '2-2',
        'name': "Women's Wear",
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
      },
      {
        'id': '2-3',
        'name': 'Kids',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      },
      {
        'id': '2-4',
        'name': 'Footwear',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      },
    ],
    '3': [
      {
        'id': '3-1',
        'name': 'Skincare',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      },
      {
        'id': '3-2',
        'name': 'Hair Care',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
      },
      {
        'id': '3-3',
        'name': 'Makeup',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      },
    ],
    '4': [
      {
        'id': '4-1',
        'name': 'Furniture',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      },
      {
        'id': '4-2',
        'name': 'Kitchen',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      },
      {
        'id': '4-3',
        'name': 'Decor',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJSnrJ5cmEu2ATSO1hEJqhubzMOi0hcut9UxNSKlrOg&s=10',
      },
    ],
    '5': [
      {
        'id': '5-1',
        'name': 'Fitness',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      },
      {
        'id': '5-2',
        'name': 'Outdoor',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      },
      {
        'id': '5-3',
        'name': 'Cricket',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      },
    ],
  };

  @override
  void onInit() {
    super.onInit();
    parentCategoryId = Get.arguments as String?;
    final list = _data[parentCategoryId] ?? _allSubcategories();
    subcategories.assignAll(list);
  }

  // Fallback: flatten all subcategories when no parent is selected
  List<Map<String, dynamic>> _allSubcategories() {
    return _data.values.expand((e) => e).toList();
  }

  void viewSubCategory(String subcategoryId) {
    Get.toNamed('/products', arguments: subcategoryId);
  }
}
