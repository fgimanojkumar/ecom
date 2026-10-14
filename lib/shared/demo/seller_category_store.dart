import 'package:get/get.dart';

import '../../data/models/seller_category_model.dart';

class SellerCategoryStore {
  SellerCategoryStore._();

  static final RxList<SellerCategory> categories = <SellerCategory>[].obs;

  static void seedIfEmpty() {
    if (categories.isNotEmpty) return;
    categories.addAll([
      SellerCategory(
          id: 'C-1',
          name: 'Electronics',
          description: 'Earbuds, watches and gadgets',
          gstRate: 18,
          hsnCode: '8518',
          productCount: 12,
          status: CategoryStatus.active),
      SellerCategory(
          id: 'C-2',
          name: 'Fashion',
          description: 'Apparel and accessories',
          gstRate: 5,
          hsnCode: '6109',
          productCount: 24,
          status: CategoryStatus.active),
      SellerCategory(
          id: 'C-3',
          name: 'Home & Living',
          description: 'Lamps, decor and furnishings',
          gstRate: 12,
          hsnCode: '9405',
          productCount: 7,
          status: CategoryStatus.inactive),
    ]);
  }
}
