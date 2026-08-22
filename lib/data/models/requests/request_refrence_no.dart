class RequestRefrenceNo {
  String? refrenceNo;

  RequestRefrenceNo({this.refrenceNo});

  RequestRefrenceNo.fromJson(Map<String, dynamic> json) {
    refrenceNo = json['RefrenceNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RefrenceNo'] = refrenceNo;
    return data;
  }
}
