class ResponseComments {
  String? errorCode;
  String? errorDescription;
  String? createdOn;
  String? createdBy;
  String? noteDescription1;
  String? claimSubstatus;
  String? noteDescription2;

  ResponseComments({
    this.errorCode,
    this.errorDescription,
    this.createdOn,
    this.createdBy,
    this.noteDescription1,
    this.claimSubstatus,
    this.noteDescription2,
  });

  ResponseComments.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    noteDescription1 = json['noteDescription1'];
    claimSubstatus = json['claimSubstatus'];
    noteDescription2 = json['noteDescription2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['createdOn'] = createdOn;
    data['createdBy'] = createdBy;
    data['noteDescription1'] = noteDescription1;
    data['claimSubstatus'] = claimSubstatus;
    data['noteDescription2'] = noteDescription2;
    return data;
  }
}
