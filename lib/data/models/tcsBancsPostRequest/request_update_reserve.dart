class RequestUpdateReserve {
  String? strClaimNumber;
  String? strSurveyorCode;
  String? dblReserveAmount;
  String? strRemarks;
  String? expenseReserveAmt;

  RequestUpdateReserve({
    this.dblReserveAmount,
    this.strClaimNumber,
    this.strRemarks,
    this.strSurveyorCode,
    this.expenseReserveAmt,
  });

  RequestUpdateReserve.fromJson(Map<String, dynamic> json) {
    dblReserveAmount = json['dblReserveAmount'];
    strClaimNumber = json['strClaimNumber'];
    strRemarks = json['strRemarks'];
    strSurveyorCode = json['strSurveyorCode'];
    expenseReserveAmt = json['expenseReserveAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dblReserveAmount'] = dblReserveAmount;
    data['strClaimNumber'] = strClaimNumber;
    data['strRemarks'] = strRemarks;
    data['strSurveyorCode'] = strSurveyorCode;
    data['expenseReserveAmt'] = expenseReserveAmt;
    return data;
  }
}
