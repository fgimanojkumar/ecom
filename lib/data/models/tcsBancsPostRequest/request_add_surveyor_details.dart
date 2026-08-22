class RequestAddSurveyorDetails {
  String? userCode;
  List<ClaimSurveyorList>? claimSurveyorList;

  RequestAddSurveyorDetails({
    this.userCode,
    this.claimSurveyorList,
  });

  RequestAddSurveyorDetails.fromJson(Map<String, dynamic> json) {
    userCode = json['userCode'];
    if (json['claimSurveyorList'] != null) {
      claimSurveyorList = <ClaimSurveyorList>[];
      json['claimSurveyorList'].forEach((v) {
        claimSurveyorList!.add(ClaimSurveyorList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userCode'] = userCode;
    if (claimSurveyorList != null) {
      data['claimSurveyorList'] =
          claimSurveyorList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimSurveyorList {
  String? appointmentDate;
  String? appointmentTime;
  String? claimNumber;
  String? reserveExpense;
  String? surveyorCode;

  ClaimSurveyorList({
    this.appointmentDate,
    this.appointmentTime,
    this.claimNumber,
    this.reserveExpense,
    this.surveyorCode,
  });

  ClaimSurveyorList.fromJson(Map<String, dynamic> json) {
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    claimNumber = json['claimNumber'];
    reserveExpense = json['reserveExpense'];
    surveyorCode = json['surveyorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentDate'] = appointmentDate;
    data['appointmentTime'] = appointmentTime;
    data['claimNumber'] = claimNumber;
    data['reserveExpense'] = reserveExpense;
    data['surveyorCode'] = surveyorCode;
    return data;
  }
}
