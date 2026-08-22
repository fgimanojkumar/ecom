class ResponseLogin {
  String? userId;
  String? username;
  String? mobile;
  String? surveyorCode;
  String? liscenceSurveyorGcn;
  String? surveyorRole;
  String? token;

  ResponseLogin({
    this.userId,
    this.username,
    this.mobile,
    this.surveyorCode,
    this.liscenceSurveyorGcn,
    this.surveyorRole,
    this.token,
  });

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    mobile = json['mobile'];
    surveyorCode = json['surveyorCode'];
    liscenceSurveyorGcn = json['liscenceSurveyorGcn'];
    surveyorRole = json['surveyorRole'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['mobile'] = mobile;
    data['surveyorCode'] = surveyorCode;
    data['liscenceSurveyorGcn'] = liscenceSurveyorGcn;
    data['surveyorRole'] = surveyorRole;
    data['token'] = token;
    return data;
  }
}
