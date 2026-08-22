class ResponseGetPayeeDetails {
  int? errorCode;
  String? errorDescription;
  PayeeBankDetails? payeeBankDetails;
  PayeeAddrDetails? payeeAddrDetails;

  ResponseGetPayeeDetails({
    this.errorCode,
    this.errorDescription,
    this.payeeBankDetails,
    this.payeeAddrDetails,
  });

  ResponseGetPayeeDetails.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    payeeBankDetails = json['payeeBankDetails'] != null
        ? PayeeBankDetails.fromJson(json['payeeBankDetails'])
        : null;
    payeeAddrDetails = json['payeeAddrDetails'] != null
        ? PayeeAddrDetails.fromJson(json['payeeAddrDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    if (payeeBankDetails != null) {
      data['payeeBankDetails'] = payeeBankDetails!.toJson();
    }
    if (payeeAddrDetails != null) {
      data['payeeAddrDetails'] = payeeAddrDetails!.toJson();
    }
    return data;
  }
}

class PayeeBankDetails {
  String? partyCode;
  String? accountNo;
  String? accountType;
  String? micrCode;
  String? ifscCode;
  String? bankCode;
  String? branchName;
  String? createdBy;
  String? createdDtTm;
  String? bankName;

  PayeeBankDetails({
    this.partyCode,
    this.accountNo,
    this.accountType,
    this.micrCode,
    this.ifscCode,
    this.bankCode,
    this.branchName,
    this.createdBy,
    this.createdDtTm,
    this.bankName,
  });

  PayeeBankDetails.fromJson(Map<String, dynamic> json) {
    partyCode = json['partyCode'];
    accountNo = json['accountNo'];
    accountType = json['accountType'];
    micrCode = json['micrCode'];
    ifscCode = json['ifscCode'];
    bankCode = json['bankCode'];
    branchName = json['branchName'];
    createdBy = json['createdBy'];
    createdDtTm = json['createdDtTm'];
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partyCode'] = partyCode;
    data['accountNo'] = accountNo;
    data['accountType'] = accountType;
    data['micrCode'] = micrCode;
    data['ifscCode'] = ifscCode;
    data['bankCode'] = bankCode;
    data['branchName'] = branchName;
    data['createdBy'] = createdBy;
    data['createdDtTm'] = createdDtTm;
    data['bankName'] = bankName;
    return data;
  }
}

class PayeeAddrDetails {
  String? partyCode;
  String? contactType;
  String? partyName;
  String? addr1;
  String? addr2;
  String? addr3;
  String? city;
  String? postCode;
  String? state;
  String? country;
  String? createdBy;
  String? createDtTm;
  String? updatedBy;
  String? updateDtTm;
  String? homeTel;
  String? workTel;

  PayeeAddrDetails({
    this.partyCode,
    this.contactType,
    this.partyName,
    this.addr1,
    this.addr2,
    this.addr3,
    this.city,
    this.postCode,
    this.state,
    this.country,
    this.createdBy,
    this.createDtTm,
    this.updatedBy,
    this.updateDtTm,
    this.homeTel,
    this.workTel,
  });

  PayeeAddrDetails.fromJson(Map<String, dynamic> json) {
    partyCode = json['partyCode'];
    contactType = json['contactType'];
    partyName = json['partyName'];
    addr1 = json['addr1'];
    addr2 = json['addr2'];
    addr3 = json['addr3'];
    city = json['city'];
    postCode = json['postCode'];
    state = json['state'];
    country = json['country'];
    createdBy = json['createdBy'];
    createDtTm = json['createDtTm'];
    updatedBy = json['updatedBy'];
    updateDtTm = json['updateDtTm'];
    homeTel = json['homeTel'];
    workTel = json['workTel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partyCode'] = partyCode;
    data['contactType'] = contactType;
    data['partyName'] = partyName;
    data['addr1'] = addr1;
    data['addr2'] = addr2;
    data['addr3'] = addr3;
    data['city'] = city;
    data['postCode'] = postCode;
    data['state'] = state;
    data['country'] = country;
    data['createdBy'] = createdBy;
    data['createDtTm'] = createDtTm;
    data['updatedBy'] = updatedBy;
    data['updateDtTm'] = updateDtTm;
    data['homeTel'] = homeTel;
    data['workTel'] = workTel;
    return data;
  }
}
