class Response64VBDetail {
  String? validation;
  String? service;
  String? uniqueTransID;
  Data? data;
  String? statusCode;
  String? errorMessage;

  Response64VBDetail({
    this.validation,
    this.service,
    this.uniqueTransID,
    this.data,
    this.statusCode,
    this.errorMessage,
  });

  Response64VBDetail.fromJson(Map<String, dynamic> json) {
    validation = json['Validation'];
    service = json['Service'];
    uniqueTransID = json['UniqueTransID'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    statusCode = json['StatusCode'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Validation'] = validation;
    data['Service'] = service;
    data['UniqueTransID'] = uniqueTransID;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['StatusCode'] = statusCode;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class Data {
  String? status;
  String? outputStatus;

  Data({this.status, this.outputStatus});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    outputStatus = json['OutputStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['OutputStatus'] = outputStatus;
    return data;
  }
}
