class ResponseClaimHistory {
  String? claimNumber;
  String? policyNumber;
  String? lossDate;
  String? claimType;
  String? status;
  String? branch;
  String? paymentAmt;

  ResponseClaimHistory({
    this.claimNumber,
    this.policyNumber,
    this.lossDate,
    this.claimType,
    this.status,
    this.branch,
    this.paymentAmt,
  });

  ResponseClaimHistory.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    policyNumber = json['policyNumber'];
    lossDate = json['lossDate'];
    claimType = json['claimType'];
    status = json['status'];
    branch = json['branch'];
    paymentAmt = json['paymentAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['policyNumber'] = policyNumber;
    data['lossDate'] = lossDate;
    data['claimType'] = claimType;
    data['status'] = status;
    data['branch'] = branch;
    data['paymentAmt'] = paymentAmt;
    return data;
  }
}
