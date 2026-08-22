class RequestStrClaimNumber {
  String? strClaimNumber;

  RequestStrClaimNumber({this.strClaimNumber});

  RequestStrClaimNumber.fromJson(Map<String, dynamic> json) {
    strClaimNumber = json['strClaimNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strClaimNumber'] = strClaimNumber;
    return data;
  }
}
