import 'package:flutter/foundation.dart';

import '../../environment/environment.dart';
import '../../shared/flutterStorage/flutter_storage.dart';
import '../../shared/flutterStorage/flutter_storage_keys.dart';
import '../../shared/localStorage/local_storage.dart';

Future<Map<String, String>> getHttpHeaders() async {
  String? xAuthToken;
  final LocalStorage localStorage = LocalStorage();

  if (kIsWeb) {
    xAuthToken = await localStorage.getLocalStorage(FlutterStorageKeys().token);
  } else {
    xAuthToken = await FlutterStorage().readStorage(FlutterStorageKeys().token);
    xAuthToken ??= Environment().config!.defaultToken;
  }

  Map<String, String> options = {};
  options = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $xAuthToken',
  };
  return options;
}
