class ResponseIibEnquiry {
  bool? success;
  String? message;
  String? payload;
  String? error;

  ResponseIibEnquiry({this.success, this.message, this.payload, this.error});

  ResponseIibEnquiry.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    payload = json['payload'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['payload'] = payload;
    data['error'] = error;
    return data;
  }
}
