class RequestSaveClaimReview {
  String? author;
  String? explanatoryNote;
  String? priority;
  String? recipient;
  String? recipientVal;
  String? refId;
  String? refType;
  String? responsibility;
  String? status;
  String? targetDt;
  String? targetTime;
  String? taskDesc;
  String? taskType;
  String? taskTypeVal;
  String? workItemType;

  RequestSaveClaimReview({
    this.author,
    this.explanatoryNote,
    this.priority,
    this.recipient,
    this.recipientVal,
    this.refId,
    this.refType,
    this.responsibility,
    this.status,
    this.targetDt,
    this.targetTime,
    this.taskDesc,
    this.taskType,
    this.taskTypeVal,
    this.workItemType,
  });

  RequestSaveClaimReview.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    explanatoryNote = json['explanatoryNote'];
    priority = json['priority'];
    recipient = json['recipient'];
    recipientVal = json['recipientVal'];
    refId = json['refId'];
    refType = json['refType'];
    responsibility = json['responsibility'];
    status = json['status'];
    targetDt = json['targetDt'];
    targetTime = json['targetTime'];
    taskDesc = json['taskDesc'];
    taskType = json['taskType'];
    taskTypeVal = json['taskTypeVal'];
    workItemType = json['workItemType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['explanatoryNote'] = explanatoryNote;
    data['priority'] = priority;
    data['recipient'] = recipient;
    data['recipientVal'] = recipientVal;
    data['refId'] = refId;
    data['refType'] = refType;
    data['responsibility'] = responsibility;
    data['status'] = status;
    data['targetDt'] = targetDt;
    data['targetTime'] = targetTime;
    data['taskDesc'] = taskDesc;
    data['taskType'] = taskType;
    data['taskTypeVal'] = taskTypeVal;
    data['workItemType'] = workItemType;
    return data;
  }
}
