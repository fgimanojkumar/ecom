import 'input_control_item.dart';

class ClaimDetailsUIModel {
  String? key;
  String? heading;
  List<InputControlItem>? data;

  ClaimDetailsUIModel({this.key, this.heading, this.data});

  ClaimDetailsUIModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    heading = json['heading'];
    if (json['data'] != null) {
      data = <InputControlItem>[];
      json['data'].forEach((v) {
        data!.add(InputControlItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['heading'] = heading;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
