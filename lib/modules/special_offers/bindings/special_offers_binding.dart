import 'package:get/get.dart';
import '../controller/special_offers_controller.dart';

class SpecialOffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecialOffersController>(
      () => SpecialOffersController(),
    );
  }
}
