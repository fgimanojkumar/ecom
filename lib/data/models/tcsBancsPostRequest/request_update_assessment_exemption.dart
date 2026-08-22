class RequestUpdateAssessmentExemption {
  String? svcNo;
  String? flag;
  String? datetime;

  RequestUpdateAssessmentExemption({this.svcNo, this.flag, this.datetime});

  RequestUpdateAssessmentExemption.fromJson(Map<String, dynamic> json) {
    svcNo = json['svcNo'];
    flag = json['flag'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['svcNo'] = svcNo;
    data['flag'] = flag;
    data['datetime'] = datetime;
    return data;
  }
}
