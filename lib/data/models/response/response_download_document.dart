class ResponseDownloadDocument {
  String? createdByAppName;
  String? docContent;
  String? documentName;
  String? documentSize;
  String? documentType;
  String? message;
  String? statusCode;

  ResponseDownloadDocument({
    this.createdByAppName,
    this.docContent,
    this.documentName,
    this.documentSize,
    this.documentType,
    this.message,
    this.statusCode,
  });

  ResponseDownloadDocument.fromJson(Map<String, dynamic> json) {
    createdByAppName = json['createdByAppName'];
    docContent = json['docContent'];
    documentName = json['documentName'];
    documentSize = json['documentSize'];
    documentType = json['documentType'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdByAppName'] = createdByAppName;
    data['docContent'] = docContent;
    data['documentName'] = documentName;
    data['documentSize'] = documentSize;
    data['documentType'] = documentType;
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}
