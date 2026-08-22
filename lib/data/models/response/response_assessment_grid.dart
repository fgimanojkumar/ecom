class ResponseAssessmentGrid {
  int? errorCode;
  String? errorDescription;
  List<AssessmentGrid>? assessmentGrid;

  ResponseAssessmentGrid({
    this.errorCode,
    this.errorDescription,
    this.assessmentGrid,
  });

  ResponseAssessmentGrid.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    if (json['assessmentGrid'] != null) {
      assessmentGrid = <AssessmentGrid>[];
      json['assessmentGrid'].forEach((v) {
        assessmentGrid!.add(AssessmentGrid.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    if (assessmentGrid != null) {
      data['assessmentGrid'] =
          assessmentGrid!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssessmentGrid {
  String? partName;
  String? allowFlag;
  String? partNumber;
  String? jobDescription;
  String? partType;
  String? payee;
  String? quantity;
  String? untiPrice;
  String? gstOnParts;
  String? partHSN;
  String? labourCodeRemoveRefit;
  String? gstRemoveRefit;
  String? sacCodeRemoveRefit;
  String? labourAmountRemoveRefit;
  String? labourCodeDentingRepair;
  String? gstDentingRepair;
  String? sacCodeDentingRepair;
  String? labourAmountDentingRepair;
  String? labourCodePainting;
  String? gstPainting;
  String? sacCodePainting;
  String? labourAmountPainting;
  String? depreciationShield;
  String? engineProtect;
  String? imt23;
  String? lossOfKey;
  String? consolidatePaintMaterial;
  String? partAssessmentRemarks;
  String? labourAssessmentRemarks;

  AssessmentGrid({
    this.partName,
    this.allowFlag,
    this.partNumber,
    this.jobDescription,
    this.partType,
    this.payee,
    this.quantity,
    this.untiPrice,
    this.gstOnParts,
    this.partHSN,
    this.labourCodeRemoveRefit,
    this.gstRemoveRefit,
    this.sacCodeRemoveRefit,
    this.labourAmountRemoveRefit,
    this.labourCodeDentingRepair,
    this.gstDentingRepair,
    this.sacCodeDentingRepair,
    this.labourAmountDentingRepair,
    this.labourCodePainting,
    this.gstPainting,
    this.sacCodePainting,
    this.labourAmountPainting,
    this.depreciationShield,
    this.engineProtect,
    this.imt23,
    this.lossOfKey,
    this.consolidatePaintMaterial,
    this.partAssessmentRemarks,
    this.labourAssessmentRemarks,
  });

  AssessmentGrid.fromJson(Map<String, dynamic> json) {
    partName = json['partName'];
    allowFlag = json['allowFlag'];
    partNumber = json['partNumber'];
    jobDescription = json['jobDescription'];
    partType = json['partType'];
    payee = json['payee'];
    quantity = json['quantity'];
    untiPrice = json['untiPrice'];
    gstOnParts = json['gstOnParts'];
    partHSN = json['partHSN'];
    labourCodeRemoveRefit = json['labourCodeRemoveRefit'];
    gstRemoveRefit = json['gstRemoveRefit'];
    sacCodeRemoveRefit = json['sacCodeRemoveRefit'];
    labourAmountRemoveRefit = json['labourAmountRemoveRefit'];
    labourCodeDentingRepair = json['labourCodeDentingRepair'];
    gstDentingRepair = json['gstDentingRepair'];
    sacCodeDentingRepair = json['sacCodeDentingRepair'];
    labourAmountDentingRepair = json['labourAmountDentingRepair'];
    labourCodePainting = json['labourCodePainting'];
    gstPainting = json['gstPainting'];
    sacCodePainting = json['sacCodePainting'];
    labourAmountPainting = json['labourAmountPainting'];
    depreciationShield = json['depreciationShield'];
    engineProtect = json['engineProtect'];
    imt23 = json['imt23'];
    lossOfKey = json['lossOfKey'];
    consolidatePaintMaterial = json['consolidatePaintMaterial'];
    partAssessmentRemarks = json['partAssessmentRemarks'];
    labourAssessmentRemarks = json['labourAssessmentRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partName'] = partName;
    data['allowFlag'] = allowFlag;
    data['partNumber'] = partNumber;
    data['jobDescription'] = jobDescription;
    data['partType'] = partType;
    data['payee'] = payee;
    data['quantity'] = quantity;
    data['untiPrice'] = untiPrice;
    data['gstOnParts'] = gstOnParts;
    data['partHSN'] = partHSN;
    data['labourCodeRemoveRefit'] = labourCodeRemoveRefit;
    data['gstRemoveRefit'] = gstRemoveRefit;
    data['sacCodeRemoveRefit'] = sacCodeRemoveRefit;
    data['labourAmountRemoveRefit'] = labourAmountRemoveRefit;
    data['labourCodeDentingRepair'] = labourCodeDentingRepair;
    data['gstDentingRepair'] = gstDentingRepair;
    data['sacCodeDentingRepair'] = sacCodeDentingRepair;
    data['labourAmountDentingRepair'] = labourAmountDentingRepair;
    data['labourCodePainting'] = labourCodePainting;
    data['gstPainting'] = gstPainting;
    data['sacCodePainting'] = sacCodePainting;
    data['labourAmountPainting'] = labourAmountPainting;
    data['depreciationShield'] = depreciationShield;
    data['engineProtect'] = engineProtect;
    data['imt23'] = imt23;
    data['lossOfKey'] = lossOfKey;
    data['consolidatePaintMaterial'] = consolidatePaintMaterial;
    data['partAssessmentRemarks'] = partAssessmentRemarks;
    data['labourAssessmentRemarks'] = labourAssessmentRemarks;
    return data;
  }
}
