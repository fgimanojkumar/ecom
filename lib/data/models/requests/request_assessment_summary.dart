class RequestAssessmentSummary {
  String? strAssessmentType;
  String? strClaimNumber;

  RequestAssessmentSummary({
    this.strAssessmentType,
    this.strClaimNumber,
  });

  RequestAssessmentSummary.fromJson(Map<String, dynamic> json) {
    strAssessmentType = json['strAssessmentType'];
    strClaimNumber = json['strClaimNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strAssessmentType'] = strAssessmentType;
    data['strClaimNumber'] = strClaimNumber;
    return data;
  }
}
