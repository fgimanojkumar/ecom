import 'package:get/get.dart';
import '../controller/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    // fenix: true lets the controller be recreated if disposed while another
    // page on the stack still holds a reference (e.g. /categories + /subcategories).
    Get.lazyPut<CategoriesController>(
      () => CategoriesController(),
      fenix: true,
    );
  }
}
