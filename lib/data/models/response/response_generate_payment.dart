class ResponseGeneratePayment {
  int? errorCode;
  String? errorDescription;
  String? status;
  List<PaymentCycleOutputDTOList>? paymentCycleOutputDTOList;

  ResponseGeneratePayment({
    this.errorCode,
    this.errorDescription,
    this.status,
    this.paymentCycleOutputDTOList,
  });

  ResponseGeneratePayment.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    status = json['status'];
    if (json['paymentCycleOutputDTOList'] != null) {
      paymentCycleOutputDTOList = <PaymentCycleOutputDTOList>[];
      json['paymentCycleOutputDTOList'].forEach((v) {
        paymentCycleOutputDTOList!
            .add(PaymentCycleOutputDTOList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['status'] = status;
    if (paymentCycleOutputDTOList != null) {
      data['paymentCycleOutputDTOList'] =
          paymentCycleOutputDTOList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentCycleOutputDTOList {
  String? paymentId;
  String? referenceId;
  String? cgstAmount;
  String? sgstAmount;
  String? igstAmount;
  String? tdsAmount;
  String? totalAmountIncTax;
  String? ugstAmount;
  String? taxInvoiceNo;
  String? taxInvoiceDt;
  String? assessmentNo;
  String? paymentApprNo;
  String? gstPercentage;
  String? paymentGroup;
  String? tcs;
  String? ncbRecovery;
  String? paymentMode;
  String? surveyGstAmount;

  PaymentCycleOutputDTOList({
    this.paymentId,
    this.referenceId,
    this.cgstAmount,
    this.sgstAmount,
    this.igstAmount,
    this.tdsAmount,
    this.totalAmountIncTax,
    this.ugstAmount,
    this.taxInvoiceNo,
    this.taxInvoiceDt,
    this.assessmentNo,
    this.paymentApprNo,
    this.gstPercentage,
    this.paymentGroup,
    this.tcs,
    this.ncbRecovery,
    this.paymentMode,
    this.surveyGstAmount,
  });

  PaymentCycleOutputDTOList.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    referenceId = json['referenceId'];
    cgstAmount = json['cgstAmount'];
    sgstAmount = json['sgstAmount'];
    igstAmount = json['igstAmount'];
    tdsAmount = json['tdsAmount'];
    totalAmountIncTax = json['totalAmountIncTax'];
    ugstAmount = json['ugstAmount'];
    taxInvoiceNo = json['taxInvoiceNo'];
    taxInvoiceDt = json['taxInvoiceDt'];
    assessmentNo = json['assessmentNo'];
    paymentApprNo = json['paymentApprNo'];
    gstPercentage = json['gstPercentage'];
    paymentGroup = json['paymentGroup'];
    tcs = json['tcs'];
    ncbRecovery = json['ncbRecovery'];
    paymentMode = json['paymentMode'];
    surveyGstAmount = json['surveyGstAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentId'] = paymentId;
    data['referenceId'] = referenceId;
    data['cgstAmount'] = cgstAmount;
    data['sgstAmount'] = sgstAmount;
    data['igstAmount'] = igstAmount;
    data['tdsAmount'] = tdsAmount;
    data['totalAmountIncTax'] = totalAmountIncTax;
    data['ugstAmount'] = ugstAmount;
    data['taxInvoiceNo'] = taxInvoiceNo;
    data['taxInvoiceDt'] = taxInvoiceDt;
    data['assessmentNo'] = assessmentNo;
    data['paymentApprNo'] = paymentApprNo;
    data['gstPercentage'] = gstPercentage;
    data['paymentGroup'] = paymentGroup;
    data['tcs'] = tcs;
    data['ncbRecovery'] = ncbRecovery;
    data['paymentMode'] = paymentMode;
    data['surveyGstAmount'] = surveyGstAmount;
    return data;
  }
}
