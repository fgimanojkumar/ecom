class RequestIibEnquiry {
  String? claimNumber;
  String? registrationNumber;
  String? chassisNumber;

  RequestIibEnquiry({
    this.claimNumber,
    this.registrationNumber,
    this.chassisNumber,
  });

  RequestIibEnquiry.fromJson(Map<String, dynamic> json) {
    claimNumber = json['claimNumber'];
    registrationNumber = json['registrationNumber'];
    chassisNumber = json['chassisNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claimNumber'] = claimNumber;
    data['registrationNumber'] = registrationNumber;
    data['chassisNumber'] = chassisNumber;
    return data;
  }
}
