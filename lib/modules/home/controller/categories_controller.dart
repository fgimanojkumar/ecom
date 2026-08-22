import 'package:get/get.dart';

class CategoriesController extends GetxController {
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
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAPf_062JKWOBQr9rKxfyjLtlwzCn6Wwx_fJ6vQDIAgQ&s=10',
      'icon': '0xe888',
    },
    {
      'id': '4',
      'name': 'Home',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR86kczML_kdfQjmwvRHp1IZCPFbH-HGah5_aV20HwoBw&s=10',
      'icon': '0xe88a',
    },
    {
      'id': '5',
      'name': 'Sports',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvRPlWzR86Xg8pC8XAz_FTllGOta5N0-nDOMsPp96btw&s=10',
      'icon': '0xe926',
    },
  ].obs;

  void viewCategory(String categoryId) {
    Get.toNamed('/products', arguments: categoryId);
  }
}
