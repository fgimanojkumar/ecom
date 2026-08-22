import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/login/device_info.dart';

class DeviceLocationData {
  DeviceLocationData._internal();

  static final DeviceLocationData _instance = DeviceLocationData._internal();

  factory DeviceLocationData() {
    return _instance;
  }

  getDeviceData() async {
    DeviceInfo deviceInfo = DeviceInfo();
    if (kIsWeb) {
      deviceInfo.deviceId = 'NA';
      deviceInfo.platform = 'WEB';
      deviceInfo.fcmId = 'NO-AVAILABLE';
      deviceInfo.deviceInfo = 'additional device info';
    } else {
      deviceInfo.deviceId = await getDeviceId();
      deviceInfo.platform = (Platform.isAndroid) ? 'Android' : 'iOS';
      deviceInfo.fcmId = 'NO-AVAILABLE';
      deviceInfo.deviceInfo = 'additional device info';
    }

    return deviceInfo;
  }

  getDeviceId() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      return androidDeviceInfo.id;
    } else {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    }
  }
}
