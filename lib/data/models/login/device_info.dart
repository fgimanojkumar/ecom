class DeviceInfo {
  String? platform;
  String? deviceId;
  String? fcmId;
  String? deviceInfo;

  DeviceInfo({
    this.platform,
    this.deviceId,
    this.fcmId,
    this.deviceInfo,
  });

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    deviceId = json['deviceId'];
    fcmId = json['fcmId'];
    deviceInfo = json['deviceInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform;
    data['deviceId'] = deviceId;
    data['fcmId'] = fcmId;
    data['deviceInfo'] = deviceInfo;
    return data;
  }
}
