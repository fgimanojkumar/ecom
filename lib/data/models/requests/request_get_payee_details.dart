class RequestGetPayeeDetails {
  String? claimNumber;
  String? partyCode;

  RequestGetPayeeDetails({
    this.claimNumber,
    this.partyCode,
  });

  RequestGetPayeeDetails.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    partyCode = json['partyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['partyCode'] = partyCode;
    return data;
  }
}
