import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends GetxController {
  LocalStorage._internal();

  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  setLocalStorage(String key, dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  getLocalStorage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);
    return value;
  }

  removeStorageItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
