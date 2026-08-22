class ResponseNcbRecoveryFlag {
  String? vNCBRecoveryDescription;
  String? vNCBRecoveryCode;

  ResponseNcbRecoveryFlag(
      {this.vNCBRecoveryDescription, this.vNCBRecoveryCode});

  ResponseNcbRecoveryFlag.fromJson(Map<String, dynamic> json) {
    vNCBRecoveryDescription = json['vNCBRecoveryDescription'];
    vNCBRecoveryCode = json['vNCBRecoveryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vNCBRecoveryDescription'] = vNCBRecoveryDescription;
    data['vNCBRecoveryCode'] = vNCBRecoveryCode;
    return data;
  }
}
