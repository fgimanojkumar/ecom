import 'package:get/get.dart';

import '../../data/models/seller_product_model.dart';

class SellerProductStore {
  SellerProductStore._();

  static final RxList<SellerProduct> products = <SellerProduct>[].obs;

  static void seedIfEmpty() {
    if (products.isNotEmpty) return;
    products.addAll([
      SellerProduct(
          id: 'P-1001',
          name: 'Wireless Earbuds',
          sku: 'WE-BLK-01',
          price: 1899,
          stock: 42,
          status: ProductStatus.active),
      SellerProduct(
          id: 'P-1002',
          name: 'Cotton Kurta',
          sku: 'CK-BLU-M',
          price: 899,
          stock: 15,
          status: ProductStatus.active),
      SellerProduct(
          id: 'P-1003',
          name: 'Running Shoes',
          sku: 'RS-WHT-42',
          price: 2499,
          stock: 0,
          status: ProductStatus.inactive),
      SellerProduct(
          id: 'P-1004',
          name: 'Smart Watch',
          sku: 'SW-BLK-01',
          price: 3499,
          stock: 8,
          status: ProductStatus.active),
      SellerProduct(
          id: 'P-1005',
          name: 'Table Lamp',
          sku: 'TL-WOOD-01',
          price: 1299,
          stock: 20,
          status: ProductStatus.draft),
    ]);
  }
}
