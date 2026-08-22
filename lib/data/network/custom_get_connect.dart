import 'package:get/get_connect/connect.dart';

class CustomGetConnect extends GetConnect {
  CustomGetConnect() {
    allowAutoSignedCert = true;
    timeout = const Duration(seconds: 30);
  }
}
