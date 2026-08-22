class RequestGarageDetails {
  String? city;
  String? garageName;

  RequestGarageDetails({this.city, this.garageName});

  RequestGarageDetails.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    garageName = json['garageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['garageName'] = garageName;
    return data;
  }
}
