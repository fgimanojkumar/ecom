class RequestChangeStakeImoss {
  String? appointmentDt;
  String? appointmentTm;
  String? claimNumber;
  String? partyCode;
  String? stake;
  String? userCode;

  RequestChangeStakeImoss({
    this.appointmentDt,
    this.appointmentTm,
    this.claimNumber,
    this.partyCode,
    this.stake,
    this.userCode,
  });

  RequestChangeStakeImoss.fromJson(Map<String, dynamic> json) {
    appointmentDt = json['appointmentDt'];
    appointmentTm = json['appointmentTm'];
    claimNumber = json['claimNumber'];
    partyCode = json['partyCode'];
    stake = json['stake'];
    userCode = json['userCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentDt'] = appointmentDt;
    data['appointmentTm'] = appointmentTm;
    data['claimNumber'] = claimNumber;
    data['partyCode'] = partyCode;
    data['stake'] = stake;
    data['userCode'] = userCode;
    return data;
  }
}
