import 'package:get/get.dart';
import '../controller/support_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SupportController());
  }
}
