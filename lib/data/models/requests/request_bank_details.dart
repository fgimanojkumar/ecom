class RequestBankDetails {
  String? ifscCode;

  RequestBankDetails({this.ifscCode});

  RequestBankDetails.fromJson(Map<String, dynamic> json) {
    ifscCode = json['ifscCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ifscCode'] = ifscCode;
    return data;
  }
}
