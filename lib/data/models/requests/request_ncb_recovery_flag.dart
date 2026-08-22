class RequestNcbRecoveryFlag {
  String? serviceName;
  String? strClaimNo;

  RequestNcbRecoveryFlag({this.serviceName, this.strClaimNo});

  RequestNcbRecoveryFlag.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    strClaimNo = json['strClaimNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceName'] = serviceName;
    data['strClaimNo'] = strClaimNo;
    return data;
  }
}
