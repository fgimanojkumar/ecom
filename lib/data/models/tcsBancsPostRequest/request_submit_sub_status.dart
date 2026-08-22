class RequestSubmitSubStatus {
  String? claimNumber;
  String? claimSubstatus;
  String? userCode;

  RequestSubmitSubStatus(
      {this.claimNumber, this.claimSubstatus, this.userCode});

  RequestSubmitSubStatus.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    claimSubstatus = json['claimSubstatus'];
    userCode = json['userCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['claimSubstatus'] = claimSubstatus;
    data['userCode'] = userCode;
    return data;
  }
}
