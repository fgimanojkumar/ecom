class ResponseSearchDocument {
  String? parentFolderIndex;
  String? referenceFlag;
  String? loginUserRights;
  String? documentIndex;
  String? documentVersionNo;
  String? documentName;
  String? ownerIndex;
  String? creationDateTime;
  String? revisedDateTime;
  String? accessDateTime;
  DataDefinition? dataDefinition;
  String? versionFlag;
  String? documentType;
  String? iSIndex;
  List<String>? noOfPages;
  String? documentSize;
  String? enableLog;
  String? documentLock;
  String? comment;
  String? author;
  String? fTSFlag;
  String? docStatus;
  String? expiryDateTime;
  String? finalizedFlag;
  String? finalizedDateTime;
  String? checkoutStatus;
  String? owner;
  String? createdByAppName;
  String? docOrderNo;
  String? filedByUser;
  String? pullPrintFlag;
  String? thumbnailFlag;
  String? originalFolderLocation;
  String? annotationFlag;
  String? linkDocFlag;
  String? iSSecureFlag;
  String? signFlag;
  String? ownerType;
  String? recordFlag;
  OwnerInfo? ownerInfo;

  ResponseSearchDocument({
    this.parentFolderIndex,
    this.referenceFlag,
    this.loginUserRights,
    this.documentIndex,
    this.documentVersionNo,
    this.documentName,
    this.ownerIndex,
    this.creationDateTime,
    this.revisedDateTime,
    this.accessDateTime,
    this.dataDefinition,
    this.versionFlag,
    this.documentType,
    this.iSIndex,
    this.noOfPages,
    this.documentSize,
    this.enableLog,
    this.documentLock,
    this.comment,
    this.author,
    this.fTSFlag,
    this.docStatus,
    this.expiryDateTime,
    this.finalizedFlag,
    this.finalizedDateTime,
    this.checkoutStatus,
    this.owner,
    this.createdByAppName,
    this.docOrderNo,
    this.filedByUser,
    this.pullPrintFlag,
    this.thumbnailFlag,
    this.originalFolderLocation,
    this.annotationFlag,
    this.linkDocFlag,
    this.iSSecureFlag,
    this.signFlag,
    this.ownerType,
    this.recordFlag,
    this.ownerInfo,
  });

  ResponseSearchDocument.fromJson(Map<String, dynamic> json) {
    parentFolderIndex = json['ParentFolderIndex'];
    referenceFlag = json['ReferenceFlag'];
    loginUserRights = json['LoginUserRights'];
    documentIndex = json['DocumentIndex'];
    documentVersionNo = json['DocumentVersionNo'];
    documentName = json['DocumentName'];
    ownerIndex = json['OwnerIndex'];
    creationDateTime = json['CreationDateTime'];
    revisedDateTime = json['RevisedDateTime'];
    accessDateTime = json['AccessDateTime'];
    dataDefinition = json['DataDefinition'] != null
        ? DataDefinition.fromJson(json['DataDefinition'])
        : null;
    versionFlag = json['VersionFlag'];
    documentType = json['DocumentType'];
    iSIndex = json['ISIndex'];
    noOfPages = json['NoOfPages'].cast<String>();
    documentSize = json['DocumentSize'];
    enableLog = json['EnableLog'];
    documentLock = json['DocumentLock'];
    comment = json['Comment'];
    author = json['Author'];
    fTSFlag = json['FTSFlag'];
    docStatus = json['DocStatus'];
    expiryDateTime = json['ExpiryDateTime'];
    finalizedFlag = json['FinalizedFlag'];
    finalizedDateTime = json['FinalizedDateTime'];
    checkoutStatus = json['CheckoutStatus'];
    owner = json['Owner'];
    createdByAppName = json['CreatedByAppName'];
    docOrderNo = json['DocOrderNo'];
    filedByUser = json['FiledByUser'];
    pullPrintFlag = json['PullPrintFlag'];
    thumbnailFlag = json['ThumbnailFlag'];
    originalFolderLocation = json['OriginalFolderLocation'];
    annotationFlag = json['AnnotationFlag'];
    linkDocFlag = json['LinkDocFlag'];
    iSSecureFlag = json['ISSecureFlag'];
    signFlag = json['SignFlag'];
    ownerType = json['OwnerType'];
    recordFlag = json['RecordFlag'];
    ownerInfo = json['OwnerInfo'] != null
        ? OwnerInfo.fromJson(json['OwnerInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ParentFolderIndex'] = parentFolderIndex;
    data['ReferenceFlag'] = referenceFlag;
    data['LoginUserRights'] = loginUserRights;
    data['DocumentIndex'] = documentIndex;
    data['DocumentVersionNo'] = documentVersionNo;
    data['DocumentName'] = documentName;
    data['OwnerIndex'] = ownerIndex;
    data['CreationDateTime'] = creationDateTime;
    data['RevisedDateTime'] = revisedDateTime;
    data['AccessDateTime'] = accessDateTime;
    if (dataDefinition != null) {
      data['DataDefinition'] = dataDefinition!.toJson();
    }
    data['VersionFlag'] = versionFlag;
    data['DocumentType'] = documentType;
    data['ISIndex'] = iSIndex;
    data['NoOfPages'] = noOfPages;
    data['DocumentSize'] = documentSize;
    data['EnableLog'] = enableLog;
    data['DocumentLock'] = documentLock;
    data['Comment'] = comment;
    data['Author'] = author;
    data['FTSFlag'] = fTSFlag;
    data['DocStatus'] = docStatus;
    data['ExpiryDateTime'] = expiryDateTime;
    data['FinalizedFlag'] = finalizedFlag;
    data['FinalizedDateTime'] = finalizedDateTime;
    data['CheckoutStatus'] = checkoutStatus;
    data['Owner'] = owner;
    data['CreatedByAppName'] = createdByAppName;
    data['DocOrderNo'] = docOrderNo;
    data['FiledByUser'] = filedByUser;
    data['PullPrintFlag'] = pullPrintFlag;
    data['ThumbnailFlag'] = thumbnailFlag;
    data['OriginalFolderLocation'] = originalFolderLocation;
    data['AnnotationFlag'] = annotationFlag;
    data['LinkDocFlag'] = linkDocFlag;
    data['ISSecureFlag'] = iSSecureFlag;
    data['SignFlag'] = signFlag;
    data['OwnerType'] = ownerType;
    data['RecordFlag'] = recordFlag;
    if (ownerInfo != null) {
      data['OwnerInfo'] = ownerInfo!.toJson();
    }
    return data;
  }
}

class DataDefinition {
  String? dataDefIndex;
  String? dataDefName;

  DataDefinition({
    this.dataDefIndex,
    this.dataDefName,
  });

  DataDefinition.fromJson(Map<String, dynamic> json) {
    dataDefIndex = json['DataDefIndex'];
    dataDefName = json['DataDefName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DataDefIndex'] = dataDefIndex;
    data['DataDefName'] = dataDefName;
    return data;
  }
}

class OwnerInfo {
  String? index;
  String? name;
  String? type;
  String? familyName;

  OwnerInfo({
    this.index,
    this.name,
    this.type,
    this.familyName,
  });

  OwnerInfo.fromJson(Map<String, dynamic> json) {
    index = json['Index'];
    name = json['Name'];
    type = json['Type'];
    familyName = json['FamilyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Index'] = index;
    data['Name'] = name;
    data['Type'] = type;
    data['FamilyName'] = familyName;
    return data;
  }
}
