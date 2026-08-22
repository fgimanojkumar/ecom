import 'claim_data_imoss_dto_single.dart';

class RequestClaimUploadData {
  List<ClaimDataImossDTOSingle>? claimDataImossDTOList;
  String? userCode;

  RequestClaimUploadData({this.claimDataImossDTOList, this.userCode});

  RequestClaimUploadData.fromJson(Map<String, dynamic> json) {
    if (json['claimDataImossDTOList'] != null) {
      claimDataImossDTOList = <ClaimDataImossDTOSingle>[];
      json['claimDataImossDTOList'].forEach((v) {
        claimDataImossDTOList!.add(ClaimDataImossDTOSingle.fromJson(v));
      });
    }
    userCode = json['userCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (claimDataImossDTOList != null) {
      data['claimDataImossDTOList'] =
          claimDataImossDTOList!.map((v) => v.toJson()).toList();
    }
    data['userCode'] = userCode;
    return data;
  }
}
