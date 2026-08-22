class RequestCreateAppPin {
  String? username;
  String? pin;

  RequestCreateAppPin({
    this.username,
    this.pin,
  });

  RequestCreateAppPin.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['pin'] = pin;
    return data;
  }
}
