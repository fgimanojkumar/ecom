class ResponseTechApprovalRemark {
  int? errorCode;
  String? errorDescription;
  String? claimSubstatus;
  String? comments;

  ResponseTechApprovalRemark({
    this.errorCode,
    this.errorDescription,
    this.claimSubstatus,
    this.comments,
  });

  ResponseTechApprovalRemark.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    claimSubstatus = json['claimSubstatus'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['claimSubstatus'] = claimSubstatus;
    data['comments'] = comments;
    return data;
  }
}
