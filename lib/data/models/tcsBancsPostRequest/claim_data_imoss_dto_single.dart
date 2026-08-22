class ClaimDataImossDTOSingle {
  String? claimNumber;
  String? riskCover;
  String? assessmentType;
  String? finalInvoiceDate;
  String? invoiceNumber;
  String? modeOfPayment;
  String? docReceiveDate;
  String? cashless;
  String? salvageAmt;
  InsuredDetails? insuredDetails;
  LossInformation? lossInformation;
  ClaimDates? claimDates;
  DriverDetails? driverDetails;
  VehicleDetails? vehicleDetails;
  PolicyDetails? policyDetails;
  List<SplmntryAsstDetlsList>? splmntryAsstDetlsList;

  ClaimDataImossDTOSingle({
    this.claimNumber,
    this.riskCover,
    this.assessmentType,
    this.finalInvoiceDate,
    this.invoiceNumber,
    this.modeOfPayment,
    this.docReceiveDate,
    this.cashless,
    this.salvageAmt,
    this.insuredDetails,
    this.lossInformation,
    this.claimDates,
    this.driverDetails,
    this.vehicleDetails,
    this.policyDetails,
    this.splmntryAsstDetlsList,
  });

  ClaimDataImossDTOSingle.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    riskCover = json['riskCover'];
    assessmentType = json['assessmentType'];
    finalInvoiceDate = json['finalInvoiceDate'];
    invoiceNumber = json['invoiceNumber'];
    modeOfPayment = json['modeOfPayment'];
    docReceiveDate = json['docReceiveDate'];
    cashless = json['cashless'];
    salvageAmt = json['salvageAmt'];
    insuredDetails = (json['insuredDetails'] != null)
        ? InsuredDetails.fromJson(json['insuredDetails'])
        : null;
    lossInformation = json['lossInformation'] != null
        ? LossInformation.fromJson(json['lossInformation'])
        : null;
    claimDates = json['claimDates'] != null
        ? ClaimDates.fromJson(json['claimDates'])
        : null;
    driverDetails = json['driverDetails'] != null
        ? DriverDetails.fromJson(json['driverDetails'])
        : null;
    vehicleDetails = json['vehicleDetails'] != null
        ? VehicleDetails.fromJson(json['vehicleDetails'])
        : null;
    policyDetails = json['policyDetails'] != null
        ? PolicyDetails.fromJson(json['policyDetails'])
        : null;
    if (json['splmntryAsstDetlsList'] != null) {
      splmntryAsstDetlsList = <SplmntryAsstDetlsList>[];
      json['splmntryAsstDetlsList'].forEach((v) {
        splmntryAsstDetlsList!.add(SplmntryAsstDetlsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['riskCover'] = (riskCover == null) ? 'OD' : riskCover;
    data['assessmentType'] = assessmentType;
    data['finalInvoiceDate'] =
        (finalInvoiceDate == null) ? '' : finalInvoiceDate;
    data['invoiceNumber'] = (invoiceNumber == null) ? '' : invoiceNumber;
    data['modeOfPayment'] = (modeOfPayment == null) ? '' : modeOfPayment;
    data['docReceiveDate'] = (docReceiveDate == null) ? '' : docReceiveDate;
    data['cashless'] = (cashless == null) ? 'No' : cashless;
    data['salvageAmt'] = (salvageAmt == null) ? '0' : salvageAmt;
    if (insuredDetails != null) {
      data['insuredDetails'] = insuredDetails!.toJson();
    } else {
      data['insuredDetails'] = {};
    }
    if (lossInformation != null) {
      data['lossInformation'] = lossInformation!.toJson();
    } else {
      data['lossInformation'] = {};
    }
    if (claimDates != null) {
      data['claimDates'] = claimDates!.toJson();
    } else {
      data['claimDates'] = {};
    }
    if (driverDetails != null) {
      data['driverDetails'] = driverDetails!.toJson();
    } else {
      data['driverDetails'] = {};
    }
    if (vehicleDetails != null) {
      data['vehicleDetails'] = vehicleDetails!.toJson();
    } else {
      data['vehicleDetails'] = {};
    }
    if (policyDetails != null) {
      data['policyDetails'] = policyDetails!.toJson();
    } else {
      data['policyDetails'] = {};
    }
    if (splmntryAsstDetlsList != null) {
      data['splmntryAsstDetlsList'] =
          splmntryAsstDetlsList!.map((v) => v.toJson()).toList();
    } else {
      data['splmntryAsstDetlsList'] = {};
    }
    return data;
  }
}

class InsuredDetails {
  String? insMobNumber;
  String? altMobNumber;
  String? altMobNmBlgTo;
  String? insrdEmailId;
  String? altEmailid;
  String? corrAddrIsSame;
  String? empClaim;
  String? isPlcyHldrEmp;
  String? empNumber;

  InsuredDetails({
    this.insMobNumber,
    this.altMobNumber,
    this.altMobNmBlgTo,
    this.insrdEmailId,
    this.altEmailid,
    this.corrAddrIsSame,
    this.empClaim,
    this.isPlcyHldrEmp,
    this.empNumber,
  });

  InsuredDetails.fromJson(Map<String, dynamic> json) {
    insMobNumber = json['insMobNumber'];
    altMobNumber = json['altMobNumber'];
    altMobNmBlgTo = json['altMobNmBlgTo'];
    insrdEmailId = json['insrdEmailId'];
    altEmailid = json['altEmailid'];
    corrAddrIsSame = json['corrAddrIsSame'];
    empClaim = json['empClaim'];
    isPlcyHldrEmp = json['isPlcyHldrEmp'];
    empNumber = json['empNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['insMobNumber'] = insMobNumber;
    data['altMobNumber'] = altMobNumber;
    data['altMobNmBlgTo'] = altMobNmBlgTo;
    data['insrdEmailId'] = insrdEmailId;
    data['altEmailid'] = altEmailid;
    data['corrAddrIsSame'] = corrAddrIsSame;
    data['empClaim'] = empClaim;
    data['isPlcyHldrEmp'] = isPlcyHldrEmp;
    data['empNumber'] = empNumber;
    return data;
  }
}

class LossInformation {
  String? settlmntType;
  String? clmIntmMobNum;
  String? catEventCode;
  String? spotSurvey;
  String? leftToRepairer;
  String? policeRpt;
  String? firGdNumber;
  String? policeRptDt;
  String? psName;
  String? lossState;
  String? tpInvlmnt;
  String? tpLossType;
  String? tpDescription;
  String? statusPerClmExmnr;
  String? remarks;
  String? majorEventDesc;

  LossInformation({
    this.settlmntType,
    this.clmIntmMobNum,
    this.catEventCode,
    this.spotSurvey,
    this.leftToRepairer,
    this.policeRpt,
    this.firGdNumber,
    this.policeRptDt,
    this.psName,
    this.lossState,
    this.tpInvlmnt,
    this.tpLossType,
    this.tpDescription,
    this.statusPerClmExmnr,
    this.remarks,
    this.majorEventDesc,
  });

  LossInformation.fromJson(Map<String, dynamic> json) {
    settlmntType = json['settlmntType'];
    clmIntmMobNum = json['clmIntmMobNum'];
    catEventCode = json['catEventCode'];
    spotSurvey = json['spotSurvey'];
    leftToRepairer = json['leftToRepairer'];
    policeRpt = json['policeRpt'];
    firGdNumber = json['firGdNumber'];
    policeRptDt = json['policeRptDt'];
    psName = json['psName'];
    lossState = json['lossState'];
    tpInvlmnt = json['tpInvlmnt'];
    tpLossType = json['tpLossType'];
    tpDescription = json['tpDescription'];
    statusPerClmExmnr = json['statusPerClmExmnr'];
    remarks = json['remarks'];
    majorEventDesc = json['majorEventDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['settlmntType'] = settlmntType;
    data['clmIntmMobNum'] = clmIntmMobNum;
    data['catEventCode'] = catEventCode;
    data['spotSurvey'] = spotSurvey;
    data['leftToRepairer'] = leftToRepairer;
    data['policeRpt'] = policeRpt;
    data['firGdNumber'] = firGdNumber;
    data['policeRptDt'] = policeRptDt;
    data['psName'] = psName;
    data['lossState'] = lossState;
    data['tpInvlmnt'] = tpInvlmnt;
    data['tpLossType'] = tpLossType;
    data['tpDescription'] = tpDescription;
    data['statusPerClmExmnr'] = statusPerClmExmnr;
    data['remarks'] = remarks;
    data['majorEventDesc'] = majorEventDesc;
    return data;
  }
}

class ClaimDates {
  String? estimateDate;
  String? estimateNumber;
  String? estimateAmount;
  String? spotSurveyTime;
  String? finalSurveyDateAndTime;
  String? jobOrderDate;
  String? reInspectionRequired;
  String? reInspectionRemarks;
  String? reInspectionDate;
  String? invoiceDate;
  String? lastDocumentReceivedDate;
  String? dvReceivedDate;
  String? doDate;
  String? isThisATotalLossClaim;

  //not available in actual request
  String? reviewDate;
  String? inspectionDate;
  String? repairStartDate;
  String? repairEndDate;
  String? repairApprovalDate;
  String? extensionGrantDate;
  String? estimateGrantDateRemarks;

  ClaimDates({
    this.estimateDate,
    this.estimateNumber,
    this.estimateAmount,
    this.spotSurveyTime,
    this.finalSurveyDateAndTime,
    this.jobOrderDate,
    this.reInspectionRequired,
    this.reInspectionRemarks,
    this.reInspectionDate,
    this.invoiceDate,
    this.lastDocumentReceivedDate,
    this.dvReceivedDate,
    this.doDate,
    this.isThisATotalLossClaim,
    this.reviewDate,
    this.inspectionDate,
    this.repairStartDate,
    this.repairEndDate,
    this.repairApprovalDate,
    this.extensionGrantDate,
    this.estimateGrantDateRemarks,
  });

  ClaimDates.fromJson(Map<String, dynamic> json) {
    estimateDate = json['estimateDate'];
    estimateNumber = json['estimateNumber'];
    estimateAmount = json['estimateAmount'];
    spotSurveyTime = json['spotSurveyTime'];
    finalSurveyDateAndTime = json['finalSurveyDateAndTime'];
    jobOrderDate = json['jobOrderDate'];
    reInspectionRequired = json['reInspectionRequired'];
    reInspectionRemarks = json['reInspectionRemarks'];
    reInspectionDate = json['reInspectionDate'];
    invoiceDate = json['invoiceDate'];
    lastDocumentReceivedDate = json['lastDocumentReceivedDate'];
    dvReceivedDate = json['dvReceivedDate'];
    doDate = json['doDate'];
    isThisATotalLossClaim = json['isThisATotalLossClaim'];

    reviewDate = json['reviewDate'];
    inspectionDate = json['inspectionDate'];

    repairStartDate = json['repairStartDate'];
    repairEndDate = json['repairEndDate'];
    repairApprovalDate = json['repairApprovalDate'];
    extensionGrantDate = json['extensionGrantDate'];
    estimateGrantDateRemarks = json['estimateGrantDateRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['estimateDate'] = estimateDate;
    data['estimateNumber'] = estimateNumber;
    data['estimateAmount'] = estimateAmount;
    data['spotSurveyTime'] = spotSurveyTime;
    data['finalSurveyDateAndTime'] = finalSurveyDateAndTime;
    data['jobOrderDate'] = jobOrderDate;
    data['reInspectionRequired'] = reInspectionRequired;
    data['reInspectionRemarks'] = reInspectionRemarks;
    data['reInspectionDate'] = reInspectionDate;
    data['invoiceDate'] = invoiceDate;
    data['lastDocumentReceivedDate'] = lastDocumentReceivedDate;
    data['dvReceivedDate'] = dvReceivedDate;
    data['doDate'] = doDate;
    data['isThisATotalLossClaim'] = isThisATotalLossClaim;

    data['reviewDate'] = reviewDate;
    data['inspectionDate'] = inspectionDate;
    data['repairStartDate'] = repairStartDate;
    data['repairEndDate'] = repairEndDate;
    data['repairApprovalDate'] = repairApprovalDate;
    data['extensionGrantDate'] = extensionGrantDate;
    data['estimateGrantDateRemarks'] = estimateGrantDateRemarks;

    return data;
  }
}

class DriverDetails {
  String? whoDriving;
  String? driverName;
  String? drivrNmPerProce;
  String? driverDOB;
  String? driverAge;
  String? driverLicType;
  String? coDriverName;
  String? coDriverLicNum;
  String? coDrivrNmPerProce;
  String? coDrivrLicNmPerPro;
  String? coDrivrLicCat;
  String? coDrivrDOB;
  String? coDrivrAge;
  String? coDrivLicIssuDt;
  String? coDrivLicExpDt;
  String? coDrivLicPlceOfIssu;
  String? numOfOccupents;
  String? drivrLicNum;
  String? drivrLicCat;
  String? drivLicIssuDt;
  String? drivLicExpDt;
  String? drivLicPlceOfIssu;

  String? coDriverDlType;
  String? driverRelation;

  DriverDetails({
    this.whoDriving,
    this.driverName,
    this.drivrNmPerProce,
    this.driverDOB,
    this.driverAge,
    this.driverLicType,
    this.coDriverName,
    this.coDriverLicNum,
    this.coDrivrNmPerProce,
    this.coDrivrLicNmPerPro,
    this.coDrivrLicCat,
    this.coDrivrDOB,
    this.coDrivrAge,
    this.coDrivLicIssuDt,
    this.coDrivLicExpDt,
    this.coDrivLicPlceOfIssu,
    this.numOfOccupents,
    this.drivrLicNum,
    this.drivrLicCat,
    this.drivLicIssuDt,
    this.drivLicExpDt,
    this.drivLicPlceOfIssu,
    this.coDriverDlType,
    this.driverRelation,
  });

  DriverDetails.fromJson(Map<String, dynamic> json) {
    whoDriving = json['whoDriving'];
    driverName = json['driverName'];
    drivrNmPerProce = json['drivrNmPerProce'];
    driverDOB = json['driverDOB'];
    driverAge = json['driverAge'];
    driverLicType = json['driverLicType'];
    coDriverName = json['coDriverName'];
    coDriverLicNum = json['coDriverLicNum'];
    coDrivrNmPerProce = json['coDrivrNmPerProce'];
    coDrivrLicNmPerPro = json['coDrivrLicNmPerPro'];
    coDrivrLicCat = json['coDrivrLicCat'];
    coDrivrDOB = json['coDrivrDOB'];
    coDrivrAge = json['coDrivrAge'];
    coDrivLicIssuDt = json['coDrivLicIssuDt'];
    coDrivLicExpDt = json['coDrivLicExpDt'];
    coDrivLicPlceOfIssu = json['coDrivLicPlceOfIssu'];
    numOfOccupents = json['numOfOccupents'];
    drivrLicNum = json['drivrLicNum'];
    drivrLicCat = json['drivrLicCat'];
    drivLicIssuDt = json['drivLicIssuDt'];
    drivLicExpDt = json['drivLicExpDt'];
    drivLicPlceOfIssu = json['drivLicPlceOfIssu'];

    coDriverDlType = json['coDriverDlType'];
    driverRelation = json['driverRelation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['whoDriving'] = whoDriving;
    data['driverName'] = driverName;
    data['drivrNmPerProce'] = drivrNmPerProce;
    data['driverDOB'] = driverDOB;
    data['driverAge'] = driverAge;
    data['driverLicType'] = driverLicType;
    data['coDriverName'] = coDriverName;
    data['coDriverLicNum'] = coDriverLicNum;
    data['coDrivrNmPerProce'] = coDrivrNmPerProce;
    data['coDrivrLicNmPerPro'] = coDrivrLicNmPerPro;
    data['coDrivrLicCat'] = coDrivrLicCat;
    data['coDrivrDOB'] = coDrivrDOB;
    data['coDrivrAge'] = coDrivrAge;
    data['coDrivLicIssuDt'] = coDrivLicIssuDt;
    data['coDrivLicExpDt'] = coDrivLicExpDt;
    data['coDrivLicPlceOfIssu'] = coDrivLicPlceOfIssu;
    data['numOfOccupents'] = numOfOccupents;
    data['drivrLicNum'] = drivrLicNum;
    data['drivrLicCat'] = drivrLicCat;
    data['drivLicIssuDt'] = drivLicIssuDt;
    data['drivLicExpDt'] = drivLicExpDt;
    data['drivLicPlceOfIssu'] = drivLicPlceOfIssu;

    data['coDriverDlType'] = coDriverDlType;
    data['driverRelation'] = driverRelation;
    return data;
  }
}

class VehicleDetails {
  String? chassisNum;
  String? chassisNumPerProc;
  String? engineNum;
  String? enginNumPerProc;
  String? regNumber;
  String? subtype;
  String? vehiclSpeci;
  String? vehiclRegDate;
  String? odomReadAppli;
  String? odomReading;
  String? odomResnForNonAppli;
  String? fuelType;
  String? fitnessApplicable;
  String? fitnessExpDt;
  String? fitnesAppliRmrks;
  String? permitAppli;
  String? rtPermitStrtDt;
  String? rtPermitExpDt;
  String? prmitAppliRmrks;
  String? prmitAuthoAppli;
  String? prmitAuthoStDt;
  String? prmitAuthoEndDt;
  String? prmitAuthoRmrks;
  String? roadTaxExpDt;
  String? color;

  VehicleDetails({
    this.chassisNum,
    this.chassisNumPerProc,
    this.engineNum,
    this.enginNumPerProc,
    this.regNumber,
    this.subtype,
    this.vehiclSpeci,
    this.vehiclRegDate,
    this.odomReadAppli,
    this.odomReading,
    this.odomResnForNonAppli,
    this.fuelType,
    this.fitnessApplicable,
    this.fitnessExpDt,
    this.fitnesAppliRmrks,
    this.permitAppli,
    this.rtPermitStrtDt,
    this.rtPermitExpDt,
    this.prmitAppliRmrks,
    this.prmitAuthoAppli,
    this.prmitAuthoStDt,
    this.prmitAuthoEndDt,
    this.prmitAuthoRmrks,
    this.roadTaxExpDt,
    this.color,
  });

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    chassisNum = json['chassisNum'];
    chassisNumPerProc = json['chassisNumPerProc'];
    engineNum = json['engineNum'];
    enginNumPerProc = json['enginNumPerProc'];
    regNumber = json['regNumber'];
    subtype = json['subtype'];
    vehiclSpeci = json['vehiclSpeci'];
    vehiclRegDate = json['vehiclRegDate'];
    odomReadAppli = json['odomReadAppli'];
    odomReading = json['odomReading'];
    odomResnForNonAppli = json['odomResnForNonAppli'];
    fuelType = json['fuelType'];
    fitnessApplicable = json['fitnessApplicable'];
    fitnessExpDt = json['fitnessExpDt'];
    fitnesAppliRmrks = json['fitnesAppliRmrks'];
    permitAppli = json['permitAppli'];
    rtPermitStrtDt = json['rtPermitStrtDt'];
    rtPermitExpDt = json['rtPermitExpDt'];
    prmitAppliRmrks = json['prmitAppliRmrks'];
    prmitAuthoAppli = json['prmitAuthoAppli'];
    prmitAuthoStDt = json['prmitAuthoStDt'];
    prmitAuthoEndDt = json['prmitAuthoEndDt'];
    prmitAuthoRmrks = json['prmitAuthoRmrks'];
    roadTaxExpDt = json['roadTaxExpDt'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chassisNum'] = chassisNum;
    data['chassisNumPerProc'] = chassisNumPerProc;
    data['engineNum'] = engineNum;
    data['enginNumPerProc'] = enginNumPerProc;
    data['regNumber'] = regNumber;
    data['subtype'] = subtype;
    data['vehiclSpeci'] = vehiclSpeci;
    data['vehiclRegDate'] = vehiclRegDate;
    data['odomReadAppli'] = odomReadAppli;
    data['odomReading'] = odomReading;
    data['odomResnForNonAppli'] = odomResnForNonAppli;
    data['fuelType'] = fuelType;
    data['fitnessApplicable'] = fitnessApplicable;
    data['fitnessExpDt'] = fitnessExpDt;
    data['fitnesAppliRmrks'] = fitnesAppliRmrks;
    data['permitAppli'] = permitAppli;
    data['rtPermitStrtDt'] = rtPermitStrtDt;
    data['rtPermitExpDt'] = rtPermitExpDt;
    data['prmitAppliRmrks'] = prmitAppliRmrks;
    data['prmitAuthoAppli'] = prmitAuthoAppli;
    data['prmitAuthoStDt'] = prmitAuthoStDt;
    data['prmitAuthoEndDt'] = prmitAuthoEndDt;
    data['prmitAuthoRmrks'] = prmitAuthoRmrks;
    data['roadTaxExpDt'] = roadTaxExpDt;
    data['color'] = color;
    return data;
  }
}

class PolicyDetails {
  String? wrkshpWithinCityLmts;
  String? descOfLossPerProc;
  String? dlayResonForReg;
  String? techApprRmrks;
  String? aprveTechApprRmrks;
  String? rejTechApprRmrk;
  String? rcCanceled;

  String? majorEventDesc;
  String? modeOfTransport;
  String? totalKm;

  PolicyDetails({
    this.wrkshpWithinCityLmts = 'Y',
    this.descOfLossPerProc,
    this.dlayResonForReg,
    this.techApprRmrks,
    this.aprveTechApprRmrks,
    this.rejTechApprRmrk,
    this.rcCanceled,
    this.majorEventDesc,
    this.modeOfTransport,
    this.totalKm,
  });

  PolicyDetails.fromJson(Map<String, dynamic> json) {
    wrkshpWithinCityLmts = json['wrkshpWithinCityLmts'];
    descOfLossPerProc = json['descOfLossPerProc'];
    dlayResonForReg = json['dlayResonForReg'];
    techApprRmrks = json['techApprRmrks'];
    aprveTechApprRmrks = json['aprveTechApprRmrks'];
    rejTechApprRmrk = json['rejTechApprRmrk'];
    rcCanceled = json['rcCanceled'];

    majorEventDesc = json['majorEventDesc'];
    modeOfTransport = json['modeOfTransport'];
    totalKm = json['totalKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wrkshpWithinCityLmts'] = wrkshpWithinCityLmts;
    data['descOfLossPerProc'] = descOfLossPerProc;
    data['dlayResonForReg'] = dlayResonForReg;
    data['techApprRmrks'] = techApprRmrks;
    data['aprveTechApprRmrks'] = aprveTechApprRmrks;
    data['rejTechApprRmrk'] = rejTechApprRmrk;
    data['rcCanceled'] = rcCanceled;

    data['majorEventDesc'] = majorEventDesc;
    data['modeOfTransport'] = modeOfTransport;
    data['totalKm'] = totalKm;
    return data;
  }
}

class SplmntryAsstDetlsList {
  String? partName;
  String? allowDisallow;
  String? partNumber;
  String? jobDesc;
  String? partType;
  String? partyName;
  String? quantity;
  String? unitPrice;
  String? gstSparePart;
  String? hsnCode;
  String? labrCodeRemoRefitting;
  String? gstRemoRefitting;
  String? sacCodeRemReftng;
  String? remoRefitting;
  String? gstDntingRepair;
  String? sacCodDntingRepair;
  String? dentingRepair;
  String? labrCodePnting;
  String? gstOnPnting;
  String? sacCodPnting;
  String? painting;
  String? depreciation;
  String? engineProtect;
  String? imt23;
  String? lossOfKey;
  String? consoPaintMatrl;
  String? partAssmntRmrk;
  String? labrAssmentRmrk;

  SplmntryAsstDetlsList({
    this.partName = '',
    this.allowDisallow = '',
    this.partNumber = '',
    this.jobDesc = '',
    this.partType = '',
    this.partyName = '',
    this.quantity = '',
    this.unitPrice = '',
    this.gstSparePart = '',
    this.hsnCode = '',
    this.labrCodeRemoRefitting = '',
    this.gstRemoRefitting = '',
    this.sacCodeRemReftng = '',
    this.remoRefitting = '',
    // this.labrCodDntingRepair = '',
    this.gstDntingRepair = '',
    this.sacCodDntingRepair = '',
    this.dentingRepair = '',
    this.labrCodePnting = '',
    this.gstOnPnting = '',
    this.sacCodPnting = '',
    this.painting = '',
    this.depreciation = '',
    this.engineProtect = '',
    this.imt23 = '',
    this.lossOfKey = '',
    this.consoPaintMatrl = '',
    this.partAssmntRmrk = '',
    this.labrAssmentRmrk = '',
  });

  SplmntryAsstDetlsList.fromJson(Map<String, dynamic> json) {
    partName = json['partName'];
    allowDisallow = json['allowDisallow'];
    partNumber = json['partNumber'];
    jobDesc = json['jobDesc'];
    partType = json['partType'];
    partyName = json['partyName'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    gstSparePart = json['gstSparePart'];
    hsnCode = json['hsnCode'];
    labrCodeRemoRefitting = json['labrCodeRemoRefitting'];
    gstRemoRefitting = json['gstRemoRefitting'];
    sacCodeRemReftng = json['sacCodeRemReftng'];
    remoRefitting = json['remoRefitting'];
    // labrCodDntingRepair = json['labrCodDntingRepair'];
    gstDntingRepair = json['gstDntingRepair'];
    sacCodDntingRepair = json['sacCodDntingRepair'];
    dentingRepair = json['dentingRepair'];
    labrCodePnting = json['labrCodePnting'];
    gstOnPnting = json['gstOnPnting'];
    sacCodPnting = json['sacCodPnting'];
    painting = json['painting'];
    depreciation = json['depreciation'];
    engineProtect = json['engineProtect'];
    imt23 = json['imt23'];
    lossOfKey = json['lossOfKey'];
    consoPaintMatrl = json['consoPaintMatrl'];
    partAssmntRmrk = json['partAssmntRmrk'];
    labrAssmentRmrk = json['labrAssmentRmrk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partName'] = partName;
    data['allowDisallow'] = allowDisallow;
    data['partNumber'] = partNumber;
    data['jobDesc'] = jobDesc;
    data['partType'] = partType;
    data['partyName'] = partyName;
    data['quantity'] = quantity;
    data['unitPrice'] = unitPrice;
    data['gstSparePart'] = gstSparePart;
    data['hsnCode'] = hsnCode;
    data['labrCodeRemoRefitting'] = labrCodeRemoRefitting;
    data['gstRemoRefitting'] = gstRemoRefitting;
    data['sacCodeRemReftng'] = sacCodeRemReftng;
    data['remoRefitting'] = remoRefitting;
    // data['labrCodDntingRepair'] = labrCodDntingRepair;
    data['gstDntingRepair'] = gstDntingRepair;
    data['sacCodDntingRepair'] = sacCodDntingRepair;
    data['dentingRepair'] = dentingRepair;
    data['labrCodePnting'] = labrCodePnting;
    data['gstOnPnting'] = gstOnPnting;
    data['sacCodPnting'] = sacCodPnting;
    data['painting'] = painting;
    data['depreciation'] = depreciation;
    data['engineProtect'] = engineProtect;
    data['imt23'] = imt23;
    data['lossOfKey'] = lossOfKey;
    data['consoPaintMatrl'] = consoPaintMatrl;
    data['partAssmntRmrk'] = partAssmntRmrk;
    data['labrAssmentRmrk'] = labrAssmentRmrk;
    return data;
  }
}

class SplmntryAsstDetlsList1 {
  SplmntryAsstDetlsList1({
    required this.partName,
    required this.allowDisallow,
    required this.partNumber,
    required this.jobDesc,
    required this.partType,
    required this.partyName,
    required this.quantity,
    required this.unitPrice,
    required this.gstSparePart,
    required this.hsnCode,
    required this.labrCodeRemoRefitting,
    required this.gstRemoRefitting,
    required this.sacCodeRemReftng,
    required this.remoRefitting,
    required this.gstDntingRepair,
    required this.sacCodDntingRepair,
    required this.dentingRepair,
    required this.labrCodePnting,
    required this.gstOnPnting,
    required this.sacCodPnting,
    required this.painting,
    required this.depreciation,
    required this.engineProtect,
    required this.imt23,
    required this.lossOfKey,
    required this.consoPaintMatrl,
    required this.partAssmntRmrk,
    required this.labrAssmentRmrk,

});
  final String partName;
  final String allowDisallow;
  final String partNumber;
  final String jobDesc;
  final String partType;
  final String partyName;
  final String quantity;
  final String unitPrice;
  final String gstSparePart;
  final String hsnCode;
  final String labrCodeRemoRefitting;
  final String gstRemoRefitting;
  final String sacCodeRemReftng;
  final String remoRefitting;
  final String gstDntingRepair;
  final String sacCodDntingRepair;
  final String dentingRepair;
  final String labrCodePnting;
  final String gstOnPnting;
  final String sacCodPnting;
  final String painting;
  final String depreciation;
  final String engineProtect;
  final String imt23;
  final String lossOfKey;
  final String consoPaintMatrl;
  final String partAssmntRmrk;
  final String labrAssmentRmrk;

  factory SplmntryAsstDetlsList1.fromJson(Map<String, dynamic> json) => SplmntryAsstDetlsList1 (
    partName : json['partName'],
    allowDisallow : json['allowDisallow'],
    partNumber : json['partNumber'],
    jobDesc : json['jobDesc'],
    partType : json['partType'],
    partyName : json['partyName'],
    quantity : json['quantity'],
    unitPrice : json['unitPrice'],
    gstSparePart : json['gstSparePart'],
    hsnCode : json['hsnCode'],
    labrCodeRemoRefitting : json['labrCodeRemoRefitting'],
    gstRemoRefitting : json['gstRemoRefitting'],
    sacCodeRemReftng : json['sacCodeRemReftng'],
    remoRefitting : json['remoRefitting'],
    // labrCodDntingRepair = json['labrCodDntingRepair'];
    gstDntingRepair : json['gstDntingRepair'],
    sacCodDntingRepair : json['sacCodDntingRepair'],
    dentingRepair : json['dentingRepair'],
    labrCodePnting : json['labrCodePnting'],
    gstOnPnting : json['gstOnPnting'],
    sacCodPnting : json['sacCodPnting'],
    painting : json['painting'],
    depreciation : json['depreciation'],
    engineProtect : json['engineProtect'],
    imt23 : json['imt23'],
    lossOfKey : json['lossOfKey'],
    consoPaintMatrl : json['consoPaintMatrl'],
    partAssmntRmrk : json['partAssmntRmrk'],
    labrAssmentRmrk : json['labrAssmentRmrk'],
  );

  Map<String, dynamic> toJson() => {
    'partName' : partName,
    'allowDisallow' : allowDisallow,
    'partNumber' : partNumber,
    'jobDesc' : jobDesc,
    'partType' : partType,
    'partyName' : partyName,
    'quantity' : quantity,
    'unitPrice' : unitPrice,
    'gstSparePart' : gstSparePart,
    'hsnCode' : hsnCode,
    'labrCodeRemoRefitting' : labrCodeRemoRefitting,
    'gstRemoRefitting' : gstRemoRefitting,
    'sacCodeRemReftng' : sacCodeRemReftng,
    'remoRefitting' : remoRefitting,
    // data['labrCodDntingRepair'] = labrCodDntingRepair;
    'gstDntingRepair' : gstDntingRepair,
    'sacCodDntingRepair' : sacCodDntingRepair,
    'dentingRepair' : dentingRepair,
    'labrCodePnting' : labrCodePnting,
    'gstOnPnting' : gstOnPnting,
    'sacCodPnting' : sacCodPnting,
    'painting' : painting,
    'depreciation' : depreciation,
    'engineProtect' : engineProtect,
    'imt23' : imt23,
    'lossOfKey' : lossOfKey,
    'consoPaintMatrl' : consoPaintMatrl,
    'partAssmntRmrk' : partAssmntRmrk,
    'labrAssmentRmrk' : labrAssmentRmrk,
  };
}
