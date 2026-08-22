import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/flutterStorage/flutter_storage.dart';
import '../../../shared/flutterStorage/flutter_storage_keys.dart';
import '../../../shared/widgets/app_loader.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    checkLocalData();
  }

  checkLocalData() async {
    String? loginDetails = await FlutterStorage().readStorage(
      FlutterStorageKeys().token,
    );
    // Get.toNamed(AppRoutes().login);

    if (loginDetails == null) {
      Get.toNamed(AppRoutes().login);
    } else {
      Get.toNamed(AppRoutes().loginWithPin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLoader.onScreenLoaderWithScaffold();
  }
}
