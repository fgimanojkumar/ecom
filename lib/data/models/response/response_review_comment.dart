class ResponseReviewComment {
  int? errorCode;
  String? errorDescription;
  String? remark;

  ResponseReviewComment({
    this.errorCode,
    this.errorDescription,
    this.remark,
  });

  ResponseReviewComment.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['remark'] = remark;
    return data;
  }
}
