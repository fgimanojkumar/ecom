class RequestUpdateNeftDetails {
  String? userCode;
  List<NeftDetailsList>? neftDetailsList;

  RequestUpdateNeftDetails({
    this.userCode,
    this.neftDetailsList,
  });

  RequestUpdateNeftDetails.fromJson(Map<String, dynamic> json) {
    userCode = json['userCode'];
    if (json['neftDetailsList'] != null) {
      neftDetailsList = <NeftDetailsList>[];
      json['neftDetailsList'].forEach((v) {
        neftDetailsList!.add(NeftDetailsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userCode'] = userCode;
    if (neftDetailsList != null) {
      data['neftDetailsList'] =
          neftDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NeftDetailsList {
  String? accHldrName;
  String? accNumber;
  String? accType;
  String? bankName;
  String? claimNumber;
  String? ifscCode;
  String? partyCode;
  String? branchName;

  NeftDetailsList({
    this.accHldrName,
    this.accNumber,
    this.accType,
    this.bankName,
    this.claimNumber,
    this.ifscCode,
    this.partyCode,
    this.branchName,
  });

  NeftDetailsList.fromJson(Map<String, dynamic> json) {
    accHldrName = json['accHldrName'];
    accNumber = json['accNumber'];
    accType = json['accType'];
    bankName = json['bankName'];
    claimNumber = json['claimNumber'];
    ifscCode = json['ifscCode'];
    partyCode = json['partyCode'];
    branchName = json['branchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accHldrName'] = accHldrName;
    data['accNumber'] = accNumber;
    data['accType'] = accType;
    data['bankName'] = bankName;
    data['claimNumber'] = claimNumber;
    data['ifscCode'] = ifscCode;
    data['partyCode'] = partyCode;
    data['branchName'] = branchName;
    return data;
  }
}
