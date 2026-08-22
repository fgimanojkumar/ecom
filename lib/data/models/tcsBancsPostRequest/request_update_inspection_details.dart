class RequestUpdateInspectionDetails {
  String? claimNumber;
  String? reinspDate;
  String? reinspRequired;
  String? remarks;
  String? userCode;

  RequestUpdateInspectionDetails({
    this.claimNumber,
    this.reinspDate,
    this.reinspRequired,
    this.remarks,
    this.userCode,
  });

  RequestUpdateInspectionDetails.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    reinspDate = json['reinspDate'];
    reinspRequired = json['reinspRequired'];
    remarks = json['remarks'];
    userCode = json['userCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['reinspDate'] = reinspDate;
    data['reinspRequired'] = reinspRequired;
    data['remarks'] = remarks;
    data['userCode'] = userCode;
    return data;
  }
}
