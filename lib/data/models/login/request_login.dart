import 'device_info.dart';

class RequestLogin {
  String? username;
  String? password;
  String? partnerType;
  DeviceInfo? deviceInfo;

  RequestLogin({
    this.username,
    this.password,
    this.partnerType,
    this.deviceInfo,
  });

  RequestLogin.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    partnerType = json['partnerType'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['partnerType'] = partnerType;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    return data;
  }
}
