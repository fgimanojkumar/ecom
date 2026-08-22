class RequestDoSheet {
  List<DoSheetRequsetDTOList>? doSheetRequsetDTOList;

  RequestDoSheet({this.doSheetRequsetDTOList});

  RequestDoSheet.fromJson(Map<String, dynamic> json) {
    if (json['doSheetRequsetDTOList'] != null) {
      doSheetRequsetDTOList = <DoSheetRequsetDTOList>[];
      json['doSheetRequsetDTOList'].forEach((v) {
        doSheetRequsetDTOList!.add(DoSheetRequsetDTOList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doSheetRequsetDTOList != null) {
      data['doSheetRequsetDTOList'] =
          doSheetRequsetDTOList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoSheetRequsetDTOList {
  String? svcNo;

  DoSheetRequsetDTOList({this.svcNo});

  DoSheetRequsetDTOList.fromJson(Map<String, dynamic> json) {
    svcNo = json['svcNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['svcNo'] = svcNo;
    return data;
  }
}
