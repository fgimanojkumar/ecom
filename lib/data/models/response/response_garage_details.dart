class ResponseGarageDetails {
  String? garageName;
  String? city;
  String? contactPerson;
  String? email;
  String? workTelNo;
  String? garaceCode;
  String? gstnNo;
  String? addr1;
  String? addr2;
  String? addr3;

  ResponseGarageDetails({
    this.garageName,
    this.city,
    this.contactPerson,
    this.email,
    this.workTelNo,
    this.garaceCode,
    this.gstnNo,
    this.addr1,
    this.addr2,
    this.addr3,
  });

  ResponseGarageDetails.fromJson(Map<String, dynamic> json) {
    garageName = json['garageName'];
    city = json['city'];
    contactPerson = json['contactPerson'];
    email = json['email'];
    workTelNo = json['workTelNo'];
    garaceCode = json['garaceCode'];
    gstnNo = json['gstnNo'];
    addr1 = json['addr1'];
    addr2 = json['addr2'];
    addr3 = json['addr3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['garageName'] = garageName;
    data['city'] = city;
    data['contactPerson'] = contactPerson;
    data['email'] = email;
    data['workTelNo'] = workTelNo;
    data['garaceCode'] = garaceCode;
    data['gstnNo'] = gstnNo;
    data['addr1'] = addr1;
    data['addr2'] = addr2;
    data['addr3'] = addr3;
    return data;
  }
}
