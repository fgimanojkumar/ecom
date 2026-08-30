import 'package:get/get.dart';
import '../controller/sub_categories_controller.dart';

class SubCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubCategoriesController>(
      () => SubCategoriesController(),
      fenix: true,
    );
  }
}
