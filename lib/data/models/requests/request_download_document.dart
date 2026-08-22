class RequestDownloadDocument {
  String? documentIndex;

  RequestDownloadDocument({this.documentIndex});

  RequestDownloadDocument.fromJson(Map<String, dynamic> json) {
    documentIndex = json['documentIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documentIndex'] = documentIndex;
    return data;
  }
}
