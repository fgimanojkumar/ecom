class RequestTCSClaimList {
  String? strClaimNumber;
  String? strLastSyncdate;
  String? strSurveyorCode;

  RequestTCSClaimList({
    this.strClaimNumber,
    this.strLastSyncdate,
    this.strSurveyorCode,
  });

  RequestTCSClaimList.fromJson(Map<String, dynamic> json) {
    strClaimNumber = json['strClaimNumber'];
    strLastSyncdate = json['strLastSyncdate'];
    strSurveyorCode = json['strSurveyorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strClaimNumber'] = strClaimNumber;
    data['strLastSyncdate'] = strLastSyncdate;
    data['strSurveyorCode'] = strSurveyorCode;
    return data;
  }
}
