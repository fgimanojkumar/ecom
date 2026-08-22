class RequestGetMastersAsync {
  String? strLastRetrieveDate;

  RequestGetMastersAsync({this.strLastRetrieveDate});

  RequestGetMastersAsync.fromJson(Map<String, dynamic> json) {
    strLastRetrieveDate = json['strLastRetrieveDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strLastRetrieveDate'] = strLastRetrieveDate;
    return data;
  }
}
