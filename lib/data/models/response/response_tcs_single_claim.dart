class ResponseTCSSingleClaim {
  String? claimNo;
  String? policyNo;
  String? contractType;
  String? dateOfReporting;
  String? timeOfReporting;
  String? dateTimeOfLoss;
  String? delayIntimation;
  String? ncbPercentage;
  String? closeProximity;
  String? breakIn;
  String? vipCustomer;
  String? inceptionDate;
  String? expiryDate;
  String? odReserves;
  String? expenseReserves;
  String? idv;
  String? reviewDate;
  String? claimType;
  String? claimSubStatus;
  String? vehicleDetails;
  String? regNo;
  String? registrationNo;
  String? regDate;
  String? make;
  String? model;
  String? engineNo;
  String? engNumAsPerPro;
  String? dgtVin;
  String? chaNumAsPerPro;
  String? colour;
  String? odomReadingAppli;
  String? km;
  String? cc;
  String? mfgYr;
  String? insuredCoName;
  String? surname;
  String? insuredIsCo;
  String? internalEmp;
  String? employeeId;
  String? emailIdAvail;
  String? email;
  String? lossDetails;
  String? dateOfLoss;
  String? timeOfLoss;
  String? natureOfLoss;
  String? causeOfLoss;
  String? majorEventDesc;
  String? lossDesc;
  String? lossDescAsPerProc;
  String? driverDtls;
  String? isParked;
  String? driverName;
  String? drNameAsPerPro;
  String? licenseNo;
  String? licNoAsPerPro;
  String? dlType;
  String? dob;
  String? gender;
  String? age;
  String? issuingRTO;
  String? relation;
  String? drivLicType;
  String? coDriLicIssueDate;
  String? coDriLicExpDate;
  String? coDriLicNum;
  String? coDriLicCat;
  String? coDriverDOB;
  String? coDriverAge;
  String? coDrLicPlacOfIss;
  String? coDriLicType;
  String? numOfOccupents;
  String? expenseReserve;
  String? typeOfReserve;
  String? partyNameStake;
  String? partyNameCode;
  String? expeAmtToBeAppr;
  String? remarks;
  String? garageDtls;
  String? garageName;
  String? garageName1;
  String? city;
  String? getGarageDtls;
  String? contactPerson;
  String? email1;
  String? workTel;
  String? gcn;
  String? gstin;
  String? adr1;
  String? adr2;
  String? adr3;
  String? city1;
  String? state;
  String? survInCityLmt;
  String? modeOfTranspt;
  String? totalKMS;
  String? proposalNo;
  String? survAppointDate;
  String? doDate;
  String? jobOrderDate;
  List<WorkshopForIMOSSList>? workshopForIMOSSList;
  String? pinCode;
  String? subType;
  String? mobile;
  String? odomReaNonAppli;
  String? telephoneH;
  String? telephoneO;

  ResponseTCSSingleClaim({
    this.claimNo,
    this.policyNo,
    this.contractType,
    this.dateOfReporting,
    this.timeOfReporting,
    this.dateTimeOfLoss,
    this.delayIntimation,
    this.ncbPercentage,
    this.closeProximity,
    this.breakIn,
    this.vipCustomer,
    this.inceptionDate,
    this.expiryDate,
    this.odReserves,
    this.expenseReserves,
    this.idv,
    this.reviewDate,
    this.claimType,
    this.claimSubStatus,
    this.vehicleDetails,
    this.regNo,
    this.registrationNo,
    this.regDate,
    this.make,
    this.model,
    this.engineNo,
    this.engNumAsPerPro,
    this.dgtVin,
    this.chaNumAsPerPro,
    this.colour,
    this.odomReadingAppli,
    this.km,
    this.cc,
    this.mfgYr,
    this.insuredCoName,
    this.surname,
    this.insuredIsCo,
    this.internalEmp,
    this.employeeId,
    this.emailIdAvail,
    this.email,
    this.lossDetails,
    this.dateOfLoss,
    this.timeOfLoss,
    this.natureOfLoss,
    this.causeOfLoss,
    this.majorEventDesc,
    this.lossDesc,
    this.lossDescAsPerProc,
    this.driverDtls,
    this.isParked,
    this.driverName,
    this.drNameAsPerPro,
    this.licenseNo,
    this.licNoAsPerPro,
    this.dlType,
    this.dob,
    this.gender,
    this.age,
    this.issuingRTO,
    this.relation,
    this.drivLicType,
    this.coDriLicIssueDate,
    this.coDriLicExpDate,
    this.coDriLicNum,
    this.coDriLicCat,
    this.coDriverDOB,
    this.coDriverAge,
    this.coDrLicPlacOfIss,
    this.coDriLicType,
    this.numOfOccupents,
    this.expenseReserve,
    this.typeOfReserve,
    this.partyNameStake,
    this.partyNameCode,
    this.expeAmtToBeAppr,
    this.remarks,
    this.garageDtls,
    this.garageName,
    this.garageName1,
    this.city,
    this.getGarageDtls,
    this.contactPerson,
    this.email1,
    this.workTel,
    this.gcn,
    this.gstin,
    this.adr1,
    this.adr2,
    this.adr3,
    this.city1,
    this.state,
    this.survInCityLmt,
    this.modeOfTranspt,
    this.totalKMS,
    this.proposalNo,
    this.survAppointDate,
    this.doDate,
    this.jobOrderDate,
    this.workshopForIMOSSList,
    this.pinCode,
    this.subType,
    this.mobile,
    this.odomReaNonAppli,
    this.telephoneH,
    this.telephoneO,
  });

  ResponseTCSSingleClaim.fromJson(Map<String, dynamic> json) {
    claimNo = json['claimNo'];
    policyNo = json['policyNo'];
    contractType = json['contractType'];
    dateOfReporting = json['dateOfReporting'];
    timeOfReporting = json['timeOfReporting'];
    dateTimeOfLoss = json['dateTimeOfLoss'];
    delayIntimation = json['delayIntimation'];
    ncbPercentage = json['ncbPercentage'];
    closeProximity = json['closeProximity'];
    breakIn = json['breakIn'];
    vipCustomer = json['vipCustomer'];
    inceptionDate = json['inceptionDate'];
    expiryDate = json['expiryDate'];
    odReserves = json['odReserves'];
    expenseReserves = json['expenseReserves'];
    idv = json['idv'];
    reviewDate = json['reviewDate'];
    claimType = json['claimType'];
    claimSubStatus = json['claimSubStatus'];
    vehicleDetails = json['vehicleDetails'];
    regNo = json['regNo'];
    registrationNo = json['registrationNo'];
    regDate = json['regDate'];
    make = json['make'];
    model = json['model'];
    engineNo = json['engineNo'];
    engNumAsPerPro = json['engNumAsPerPro'];
    dgtVin = json['dgtVin'];
    chaNumAsPerPro = json['chaNumAsPerPro'];
    colour = json['colour'];
    odomReadingAppli = json['odomReadingAppli'];
    km = json['km'];
    cc = json['cc'];
    mfgYr = json['mfgYr'];
    insuredCoName = json['insuredCoName'];
    surname = json['surname'];
    insuredIsCo = json['insuredIsCo'];
    internalEmp = json['internalEmp'];
    employeeId = json['employeeId'];
    emailIdAvail = json['emailIdAvail'];
    email = json['email'];
    lossDetails = json['lossDetails'];
    dateOfLoss = json['dateOfLoss'];
    timeOfLoss = json['timeOfLoss'];
    natureOfLoss = json['natureOfLoss'];
    causeOfLoss = json['causeOfLoss'];
    majorEventDesc = json['majorEventDesc'];
    lossDesc = json['lossDesc'];
    lossDescAsPerProc = json['lossDescAsPerProc'];
    driverDtls = json['driverDtls'];
    isParked = json['isParked'];
    driverName = json['driverName'];
    drNameAsPerPro = json['drNameAsPerPro'];
    licenseNo = json['licenseNo'];
    licNoAsPerPro = json['licNoAsPerPro'];
    dlType = json['dlType'];
    dob = json['dob'];
    gender = json['gender'];
    age = json['age'];
    issuingRTO = json['issuingRTO'];
    relation = json['relation'];
    drivLicType = json['drivLicType'];
    coDriLicIssueDate = json['coDriLicIssueDate'];
    coDriLicExpDate = json['coDriLicExpDate'];
    coDriLicNum = json['coDriLicNum'];
    coDriLicCat = json['coDriLicCat'];
    coDriverDOB = json['coDriverDOB'];
    coDriverAge = json['coDriverAge'];
    coDrLicPlacOfIss = json['coDrLicPlacOfIss'];
    coDriLicType = json['coDriLicType'];
    numOfOccupents = json['numOfOccupents'];
    expenseReserve = json['expenseReserve'];
    typeOfReserve = json['typeOfReserve'];
    partyNameStake = json['partyNameStake'];
    partyNameCode = json['partyNameCode'];
    expeAmtToBeAppr = json['expeAmtToBeAppr'];
    remarks = json['remarks'];
    garageDtls = json['garageDtls'];
    garageName = json['garageName'];
    garageName1 = json['garageName1'];
    city = json['city'];
    getGarageDtls = json['getGarageDtls'];
    contactPerson = json['contactPerson'];
    email1 = json['email1'];
    workTel = json['workTel'];
    gcn = json['gcn'];
    gstin = json['gstin'];
    adr1 = json['adr1'];
    adr2 = json['adr2'];
    adr3 = json['adr3'];
    city1 = json['city1'];
    state = json['state'];
    survInCityLmt = json['survInCityLmt'];
    modeOfTranspt = json['modeOfTranspt'];
    totalKMS = json['totalKMS'];
    proposalNo = json['proposalNo'];
    survAppointDate = json['survAppointDate'];
    doDate = json['doDate'];
    jobOrderDate = json['jobOrderDate'];
    if (json['workshopForIMOSSList'] != null) {
      workshopForIMOSSList = <WorkshopForIMOSSList>[];
      json['workshopForIMOSSList'].forEach((v) {
        workshopForIMOSSList!.add(WorkshopForIMOSSList.fromJson(v));
      });
    }
    pinCode = json['pinCode'];
    subType = json['subType'];
    mobile = json['mobile'];
    odomReaNonAppli = json['odomReaNonAppli'];
    telephoneH = json['telephoneH'];
    telephoneO = json['telephoneO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNo'] = claimNo;
    data['policyNo'] = policyNo;
    data['contractType'] = contractType;
    data['dateOfReporting'] = dateOfReporting;
    data['timeOfReporting'] = timeOfReporting;
    data['dateTimeOfLoss'] = dateTimeOfLoss;
    data['delayIntimation'] = delayIntimation;
    data['ncbPercentage'] = ncbPercentage;
    data['closeProximity'] = closeProximity;
    data['breakIn'] = breakIn;
    data['vipCustomer'] = vipCustomer;
    data['inceptionDate'] = inceptionDate;
    data['expiryDate'] = expiryDate;
    data['odReserves'] = odReserves;
    data['expenseReserves'] = expenseReserves;
    data['idv'] = idv;
    data['reviewDate'] = reviewDate;
    data['claimType'] = claimType;
    data['claimSubStatus'] = claimSubStatus;
    data['vehicleDetails'] = vehicleDetails;
    data['regNo'] = regNo;
    data['registrationNo'] = registrationNo;
    data['regDate'] = regDate;
    data['make'] = make;
    data['model'] = model;
    data['engineNo'] = engineNo;
    data['engNumAsPerPro'] = engNumAsPerPro;
    data['dgtVin'] = dgtVin;
    data['chaNumAsPerPro'] = chaNumAsPerPro;
    data['colour'] = colour;
    data['odomReadingAppli'] = odomReadingAppli;
    data['km'] = km;
    data['cc'] = cc;
    data['mfgYr'] = mfgYr;
    data['insuredCoName'] = insuredCoName;
    data['surname'] = surname;
    data['insuredIsCo'] = insuredIsCo;
    data['internalEmp'] = internalEmp;
    data['employeeId'] = employeeId;
    data['emailIdAvail'] = emailIdAvail;
    data['email'] = email;
    data['lossDetails'] = lossDetails;
    data['dateOfLoss'] = dateOfLoss;
    data['timeOfLoss'] = timeOfLoss;
    data['natureOfLoss'] = natureOfLoss;
    data['causeOfLoss'] = causeOfLoss;
    data['majorEventDesc'] = majorEventDesc;
    data['lossDesc'] = lossDesc;
    data['lossDescAsPerProc'] = lossDescAsPerProc;
    data['driverDtls'] = driverDtls;
    data['isParked'] = isParked;
    data['driverName'] = driverName;
    data['drNameAsPerPro'] = drNameAsPerPro;
    data['licenseNo'] = licenseNo;
    data['licNoAsPerPro'] = licNoAsPerPro;
    data['dlType'] = dlType;
    data['dob'] = dob;
    data['gender'] = gender;
    data['age'] = age;
    data['issuingRTO'] = issuingRTO;
    data['relation'] = relation;
    data['drivLicType'] = drivLicType;
    data['coDriLicIssueDate'] = coDriLicIssueDate;
    data['coDriLicExpDate'] = coDriLicExpDate;
    data['coDriLicNum'] = coDriLicNum;
    data['coDriLicCat'] = coDriLicCat;
    data['coDriverDOB'] = coDriverDOB;
    data['coDriverAge'] = coDriverAge;
    data['coDrLicPlacOfIss'] = coDrLicPlacOfIss;
    data['coDriLicType'] = coDriLicType;
    data['numOfOccupents'] = numOfOccupents;
    data['expenseReserve'] = expenseReserve;
    data['typeOfReserve'] = typeOfReserve;
    data['partyNameStake'] = partyNameStake;
    data['partyNameCode'] = partyNameCode;
    data['expeAmtToBeAppr'] = expeAmtToBeAppr;
    data['remarks'] = remarks;
    data['garageDtls'] = garageDtls;
    data['garageName'] = garageName;
    data['garageName1'] = garageName1;
    data['city'] = city;
    data['getGarageDtls'] = getGarageDtls;
    data['contactPerson'] = contactPerson;
    data['email1'] = email1;
    data['workTel'] = workTel;
    data['gcn'] = gcn;
    data['gstin'] = gstin;
    data['adr1'] = adr1;
    data['adr2'] = adr2;
    data['adr3'] = adr3;
    data['city1'] = city1;
    data['state'] = state;
    data['survInCityLmt'] = survInCityLmt;
    data['modeOfTranspt'] = modeOfTranspt;
    data['totalKMS'] = totalKMS;
    data['proposalNo'] = proposalNo;
    data['survAppointDate'] = survAppointDate;
    data['doDate'] = doDate;
    data['jobOrderDate'] = jobOrderDate;
    if (workshopForIMOSSList != null) {
      data['workshopForIMOSSList'] =
          workshopForIMOSSList!.map((v) => v.toJson()).toList();
    }
    data['pinCode'] = pinCode;
    data['subType'] = subType;
    data['mobile'] = mobile;
    data['odomReaNonAppli'] = odomReaNonAppli;
    data['telephoneH'] = telephoneH;
    data['telephoneO'] = telephoneO;
    return data;
  }
}

class WorkshopForIMOSSList {
  String? strWorkShopName;
  String? strWorkShopCity;
  String? strWorkShopPinCode;
  String? adr1;
  String? adr2;
  String? adr3;
  String? state;
  String? workTel;
  String? email;
  String? gstin;
  String? strWorkShopCode;

  WorkshopForIMOSSList({
    this.strWorkShopName,
    this.strWorkShopCity,
    this.strWorkShopPinCode,
    this.adr1,
    this.adr2,
    this.adr3,
    this.state,
    this.workTel,
    this.email,
    this.gstin,
    this.strWorkShopCode,
  });

  WorkshopForIMOSSList.fromJson(Map<String, dynamic> json) {
    strWorkShopName = json['strWorkShopName'];
    strWorkShopCity = json['strWorkShopCity'];
    strWorkShopPinCode = json['strWorkShopPinCode'];
    adr1 = json['adr1'];
    adr2 = json['adr2'];
    adr3 = json['adr3'];
    state = json['state'];
    workTel = json['workTel'];
    email = json['email'];
    gstin = json['gstin'];
    strWorkShopCode = json['strWorkShopCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strWorkShopName'] = strWorkShopName;
    data['strWorkShopCity'] = strWorkShopCity;
    data['strWorkShopPinCode'] = strWorkShopPinCode;
    data['adr1'] = adr1;
    data['adr2'] = adr2;
    data['adr3'] = adr3;
    data['state'] = state;
    data['workTel'] = workTel;
    data['email'] = email;
    data['gstin'] = gstin;
    data['strWorkShopCode'] = strWorkShopCode;
    return data;
  }
}
