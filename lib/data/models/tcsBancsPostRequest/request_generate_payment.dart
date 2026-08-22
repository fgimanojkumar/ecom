class RequestGeneratePayment {
  String? claimNumber;
  String? docReceiveDate;
  String? finalInvoiceDate;
  String? invoiceNumber;
  String? modeOfPayment;
  String? flag;
  String? userCode;

  RequestGeneratePayment({
    this.claimNumber,
    this.docReceiveDate,
    this.finalInvoiceDate,
    this.invoiceNumber,
    this.modeOfPayment,
    this.flag,
    this.userCode,
  });

  RequestGeneratePayment.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    docReceiveDate = json['docReceiveDate'];
    finalInvoiceDate = json['finalInvoiceDate'];
    invoiceNumber = json['invoiceNumber'];
    modeOfPayment = json['modeOfPayment'];
    flag = json['flag'];
    userCode = json['userCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['docReceiveDate'] = docReceiveDate;
    data['finalInvoiceDate'] = finalInvoiceDate;
    data['invoiceNumber'] = invoiceNumber;
    data['modeOfPayment'] = modeOfPayment;
    data['flag'] = flag;
    data['userCode'] = userCode;
    return data;
  }
}
