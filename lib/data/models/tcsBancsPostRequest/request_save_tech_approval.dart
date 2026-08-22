class RequestSaveTechApproval {
  String? apprRemarks;
  String? claimNumber;
  String? claimSubstatus;
  String? userCode;

  RequestSaveTechApproval({
    this.apprRemarks,
    this.claimNumber,
    this.claimSubstatus,
    this.userCode,
  });

  RequestSaveTechApproval.fromJson(Map<String, dynamic> json) {
    apprRemarks = json['apprRemarks'];
    claimNumber = json['claimNumber'];
    claimSubstatus = json['claimSubstatus'];
    userCode = json['userCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apprRemarks'] = apprRemarks;
    data['claimNumber'] = claimNumber;
    data['claimSubstatus'] = claimSubstatus;
    data['userCode'] = userCode;
    return data;
  }
}
