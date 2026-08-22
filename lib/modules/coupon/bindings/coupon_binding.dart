import 'package:get/get.dart';

import '../controller/coupon_controller.dart';

class CouponBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponController>(() => CouponController());
  }
}
