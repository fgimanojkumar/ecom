class ResponseAssessmentSummary {
  List<AssessmentSummary>? assessmentSummary;
  String? totalAddOnAmount;
  String? totalAmount;
  String? addTowingChanges;
  String? lessVoluntaryExcess;
  String? lessCompulsaryExcess;
  String? lessSalvage;
  String? netLiability;
  String? benifittedAddOnAmount;
  String? totalLiabilityAmount;

  ResponseAssessmentSummary({
    this.assessmentSummary,
    this.totalAddOnAmount,
    this.totalAmount,
    this.addTowingChanges,
    this.lessVoluntaryExcess,
    this.lessCompulsaryExcess,
    this.lessSalvage,
    this.netLiability,
    this.benifittedAddOnAmount,
    this.totalLiabilityAmount,
  });

  ResponseAssessmentSummary.fromJson(Map<String, dynamic> json) {
    if (json['assessmentSummary'] != null) {
      assessmentSummary = <AssessmentSummary>[];
      json['assessmentSummary'].forEach((v) {
        assessmentSummary!.add(AssessmentSummary.fromJson(v));
      });
    }
    totalAddOnAmount = json['totalAddOnAmount'];
    totalAmount = json['totalAmount'];
    addTowingChanges = json['addTowingChanges'];
    lessVoluntaryExcess = json['lessVoluntaryExcess'];
    lessCompulsaryExcess = json['lessCompulsaryExcess'];
    lessSalvage = json['lessSalvage'];
    netLiability = json['netLiability'];
    benifittedAddOnAmount = json['benifittedAddOnAmount'];
    totalLiabilityAmount = json['totalLiabilityAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (assessmentSummary != null) {
      data['assessmentSummary'] =
          assessmentSummary!.map((v) => v.toJson()).toList();
    }
    data['totalAddOnAmount'] = totalAddOnAmount;
    data['totalAmount'] = totalAmount;
    data['addTowingChanges'] = addTowingChanges;
    data['lessVoluntaryExcess'] = lessVoluntaryExcess;
    data['lessCompulsaryExcess'] = lessCompulsaryExcess;
    data['lessSalvage'] = lessSalvage;
    data['netLiability'] = netLiability;
    data['benifittedAddOnAmount'] = benifittedAddOnAmount;
    data['totalLiabilityAmount'] = totalLiabilityAmount;
    return data;
  }
}

class AssessmentSummary {
  String? slno;
  String? category;
  String? amount;
  String? totalAmount;
  String? hsnSAC;
  String? gstrate;
  String? gstamount;

  AssessmentSummary({
    this.slno,
    this.category,
    this.amount,
    this.totalAmount,
    this.hsnSAC,
    this.gstrate,
    this.gstamount,
  });

  AssessmentSummary.fromJson(Map<String, dynamic> json) {
    slno = json['slno'];
    category = json['category'];
    amount = json['amount'];
    totalAmount = json['totalAmount'];
    hsnSAC = json['hsn_SAC'];
    gstrate = json['gstrate'];
    gstamount = json['gstamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slno'] = slno;
    data['category'] = category;
    data['amount'] = amount;
    data['totalAmount'] = totalAmount;
    data['hsn_SAC'] = hsnSAC;
    data['gstrate'] = gstrate;
    data['gstamount'] = gstamount;
    return data;
  }
}
