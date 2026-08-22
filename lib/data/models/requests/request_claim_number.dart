class RequestClaimNumber {
  String? claimNumber;

  RequestClaimNumber({this.claimNumber});

  RequestClaimNumber.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    return data;
  }
}
