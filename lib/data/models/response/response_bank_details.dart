class ResponseBankDetails {
  int? errorCode;
  String? errorDescription;
  String? bankName;
  String? branchName;
  String? ifscCode;
  String? micrCode;
  String? swiftCode;

  ResponseBankDetails({
    this.errorCode,
    this.errorDescription,
    this.bankName,
    this.branchName,
    this.ifscCode,
    this.micrCode,
    this.swiftCode,
  });

  ResponseBankDetails.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    ifscCode = json['ifscCode'];
    micrCode = json['micrCode'];
    swiftCode = json['swiftCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['bankName'] = bankName;
    data['branchName'] = branchName;
    data['ifscCode'] = ifscCode;
    data['micrCode'] = micrCode;
    data['swiftCode'] = swiftCode;
    return data;
  }
}
