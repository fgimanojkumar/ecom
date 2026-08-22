class RequestSearchDocument {
  String? claimNumber;
  String? policyNumber;

  RequestSearchDocument({this.claimNumber, this.policyNumber});

  RequestSearchDocument.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    policyNumber = json['policyNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['policyNumber'] = policyNumber;
    return data;
  }
}
