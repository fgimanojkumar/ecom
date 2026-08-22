class RequestCompleteSurvey {
  String? strClaimNumber;
  String? strSurveyDate;
  String? strUserCode;

  RequestCompleteSurvey({
    this.strClaimNumber,
    this.strSurveyDate,
    this.strUserCode,
  });

  RequestCompleteSurvey.fromJson(Map<String, dynamic> json) {
    strClaimNumber = json['strClaimNumber'];
    strSurveyDate = json['strSurveyDate'];
    strUserCode = json['strUserCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strClaimNumber'] = strClaimNumber;
    data['strSurveyDate'] = strSurveyDate;
    data['strUserCode'] = strUserCode;
    return data;
  }
}
