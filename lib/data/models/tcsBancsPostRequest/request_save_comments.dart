class RequestSaveComments {
  List<SaveAllCmntsList>? saveAllCmntsList;

  RequestSaveComments({this.saveAllCmntsList});

  RequestSaveComments.fromJson(Map<String, dynamic> json) {
    if (json['saveAllCmntsList'] != null) {
      saveAllCmntsList = <SaveAllCmntsList>[];
      json['saveAllCmntsList'].forEach((v) {
        saveAllCmntsList!.add(SaveAllCmntsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (saveAllCmntsList != null) {
      data['saveAllCmntsList'] =
          saveAllCmntsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaveAllCmntsList {
  String? claimNumber;
  String? claimSubStatus;
  String? createdBy;
  String? createdOn;
  String? shortNote;
  String? longNote;

  SaveAllCmntsList({
    this.claimNumber,
    this.claimSubStatus,
    this.createdBy,
    this.createdOn,
    this.shortNote,
    this.longNote,
  });

  SaveAllCmntsList.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    claimSubStatus = json['claimSubStatus'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    shortNote = json['shortNote'];
    longNote = json['longNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['claimSubStatus'] = claimSubStatus;
    data['createdBy'] = createdBy;
    data['createdOn'] = createdOn;
    data['shortNote'] = shortNote;
    data['longNote'] = longNote;
    return data;
  }
}
