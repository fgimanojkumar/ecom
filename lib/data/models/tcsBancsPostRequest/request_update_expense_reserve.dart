class RequestUpdateExpenseReserve {
  String? typeOfExpense;
  String? claimNumber;
  String? reserveAmount;
  String? surveyorCode;
  String? remarks;
  String? invoiceNumber;
  String? invoiceDate;
  String? gstExamted;
  String? userCode;

  RequestUpdateExpenseReserve({
    this.typeOfExpense,
    this.claimNumber,
    this.reserveAmount,
    this.surveyorCode,
    this.remarks,
    this.invoiceNumber,
    this.invoiceDate,
    this.gstExamted,
    this.userCode,
  });

  RequestUpdateExpenseReserve.fromJson(Map<String, dynamic> json) {
    typeOfExpense = json['typeOfExpense'];
    claimNumber = json['claimNumber'];
    reserveAmount = json['reserveAmount'];
    surveyorCode = json['surveyorCode'];
    remarks = json['remarks'];
    invoiceNumber = json['invoiceNumber'];
    invoiceDate = json['invoiceDate'];
    gstExamted = json['gstExamted'];
    userCode = json['userCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeOfExpense'] = typeOfExpense;
    data['claimNumber'] = claimNumber;
    data['reserveAmount'] = reserveAmount;
    data['surveyorCode'] = surveyorCode;
    data['remarks'] = remarks;
    data['invoiceNumber'] = invoiceNumber;
    data['invoiceDate'] = invoiceDate;
    data['gstExamted'] = gstExamted;
    data['userCode'] = userCode;
    return data;
  }
}
