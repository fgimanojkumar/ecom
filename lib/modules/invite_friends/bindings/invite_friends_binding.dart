import 'package:get/get.dart';

import '../controller/invite_friends_controller.dart';

class InviteFriendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InviteFriendsController>(() => InviteFriendsController());
  }
}
