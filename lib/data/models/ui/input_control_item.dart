class InputControlItem {
  String? id;
  String? key;
  String? description;
  String? type;
  String? labelText;
  String? hintText;
  bool? isShow;
  bool? isFreeze;
  String? validation;
  String? inputValue;
  String? inputOption;

  InputControlItem({
    this.id,
    this.key,
    this.description,
    this.type,
    this.labelText,
    this.hintText,
    this.isShow,
    this.isFreeze,
    this.validation,
    this.inputValue,
    this.inputOption,
  });

  InputControlItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    description = json['description'];
    type = json['type'];
    labelText = json['labelText'];
    hintText = json['hintText'];
    isShow = json['isShow'];
    isFreeze = json['isFreeze'];
    validation = json['validation'];
    inputValue = json['inputValue'];
    inputOption = json['inputOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['description'] = description;
    data['type'] = type;
    data['labelText'] = labelText;
    data['hintText'] = hintText;
    data['isShow'] = isShow;
    data['isFreeze'] = isFreeze;
    data['validation'] = validation;
    data['inputValue'] = inputValue;
    data['inputOption'] = inputOption;
    return data;
  }
}
