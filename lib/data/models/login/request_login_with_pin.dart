import 'device_info.dart';

class RequestLoginWithPin {
  String? username;
  String? pin;
  String? partnerType;
  DeviceInfo? deviceInfo;

  RequestLoginWithPin({
    this.username,
    this.pin,
    this.partnerType,
    this.deviceInfo,
  });

  RequestLoginWithPin.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    pin = json['pin'];
    partnerType = json['partnerType'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['pin'] = pin;
    data['partnerType'] = partnerType;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    return data;
  }
}
