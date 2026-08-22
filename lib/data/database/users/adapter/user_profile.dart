import 'package:hive/hive.dart';

import '../../box_names_type_id.dart';

part 'user_profile.g.dart';

@HiveType(typeId: BoxNamesTypeId.userProfileTypeId)
class UserProfile {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  String? password;

  @HiveField(2)
  String? partnerType;

  @HiveField(3)
  String? appPin;

  @HiveField(4)
  String? username;

  @HiveField(5)
  String? mobile;

  @HiveField(6)
  String? preferredLanguage;

  @HiveField(7)
  String? surveyorCode;

  @HiveField(8)
  String? liscenceSurveyorGcn;

  @HiveField(9)
  String? surveyorRole;

  @HiveField(10)
  String? token;

  @HiveField(11)
  String? fcmId;

  @HiveField(12)
  String? lastServerLogin;

  @HiveField(13)
  String? lastLocalLogin;

  @HiveField(14)
  String? updatedAt;

  @HiveField(15)
  String? createdAt;

  UserProfile({
    this.userId,
    this.password,
    this.partnerType,
    this.appPin,
    this.username,
    this.mobile,
    this.preferredLanguage,
    this.surveyorCode,
    this.liscenceSurveyorGcn,
    this.surveyorRole,
    this.token,
    this.fcmId,
    this.lastServerLogin,
    this.lastLocalLogin,
    this.updatedAt,
    this.createdAt,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    password = json['password'];
    partnerType = json['partnerType'];
    appPin = json['appPin'];
    username = json['username'];
    mobile = json['mobile'];
    preferredLanguage = json['preferredLanguage'];
    surveyorCode = json['surveyorCode'];
    liscenceSurveyorGcn = json['liscenceSurveyorGcn'];
    surveyorRole = json['surveyorRole'];
    token = json['token'];
    fcmId = json['fcmId'];
    lastServerLogin = json['lastServerLogin'];
    lastLocalLogin = json['lastLocalLogin'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['password'] = password;
    data['partnerType'] = partnerType;
    data['appPin'] = appPin;
    data['username'] = username;
    data['mobile'] = mobile;
    data['preferredLanguage'] = preferredLanguage;
    data['surveyorCode'] = surveyorCode;
    data['liscenceSurveyorGcn'] = liscenceSurveyorGcn;
    data['surveyorRole'] = surveyorRole;
    data['token'] = token;
    data['fcmId'] = fcmId;
    data['lastServerLogin'] = lastServerLogin;
    data['lastLocalLogin'] = lastLocalLogin;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
