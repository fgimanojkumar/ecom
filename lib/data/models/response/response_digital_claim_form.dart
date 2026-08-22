class ResponseDigitalClaimForm {
  String? claimNumber;
  String? url;

  ResponseDigitalClaimForm({this.claimNumber, this.url});

  ResponseDigitalClaimForm.fromJson(Map<String, dynamic> json) {
    claimNumber = json['ClaimNumber'];
    url = json['Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ClaimNumber'] = claimNumber;
    data['Url'] = url;
    return data;
  }
}
