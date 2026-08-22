class RequestDigitalClaimForm {
  String? claimNumber;
  String? surveyorCode;
  String? lastSyncdate;

  RequestDigitalClaimForm({
    this.claimNumber,
    this.surveyorCode,
    this.lastSyncdate,
  });

  RequestDigitalClaimForm.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    surveyorCode = json['surveyorCode'];
    lastSyncdate = json['lastSyncdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['surveyorCode'] = surveyorCode;
    data['lastSyncdate'] = lastSyncdate;
    return data;
  }
}
