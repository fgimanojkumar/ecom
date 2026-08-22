class RequestAddWorkshopDetails {
  String? userCode;
  List<ClaimWorkshopList>? claimWorkshopList;

  RequestAddWorkshopDetails({
    this.userCode,
    this.claimWorkshopList,
  });

  RequestAddWorkshopDetails.fromJson(Map<String, dynamic> json) {
    userCode = json['userCode'];
    if (json['claimWorkshopList'] != null) {
      claimWorkshopList = <ClaimWorkshopList>[];
      json['claimWorkshopList'].forEach((v) {
        claimWorkshopList!.add(ClaimWorkshopList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userCode'] = userCode;
    if (claimWorkshopList != null) {
      data['claimWorkshopList'] =
          claimWorkshopList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimWorkshopList {
  String? claimNumber;
  String? workshopCode;
  String? approvalDate;

  ClaimWorkshopList({
    this.claimNumber,
    this.workshopCode,
    this.approvalDate,
  });

  ClaimWorkshopList.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    workshopCode = json['workshopCode'];
    approvalDate = json['approvalDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['workshopCode'] = workshopCode;
    data['approvalDate'] = approvalDate;
    return data;
  }
}
