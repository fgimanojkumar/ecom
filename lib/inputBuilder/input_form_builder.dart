import 'package:flutter/material.dart';

import '../data/models/ui/input_control_item.dart';
import '../shared/style/app_style.dart';
import '../shared/widgets/app_button.dart';
import 'date_picker.dart';
import 'date_time_picker.dart';
import 'drop_down_field.dart';
import 'gender_selection.dart';
import 'input_field.dart';
import 'radio_button.dart';

class InputControlBuilder extends StatelessWidget {
  final InputControlItem inputControlItem;
  final TextEditingController? textEditingController;

  const InputControlBuilder({
    super.key,
    required this.inputControlItem,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    if (inputControlItem.type == 'INPUT') {
      return CustomTextInputField(
        inputControlItem: inputControlItem,
        controller: textEditingController,
      );
    }
    if (inputControlItem.type == 'DATE') {
      return DatePickerControl(
        inputControlItem: inputControlItem,
        controller: textEditingController,
      );
    }
    if (inputControlItem.type == 'DATETIME') {
      return DateTimePickerControl(
        inputControlItem: inputControlItem,
      );
    }
    if (inputControlItem.type == 'DROPDOWN') {
      return CustomDropDownField(
        inputControlItem: inputControlItem,
        onChanged: (String value) {},
      );
    }
    if (inputControlItem.type == 'BTN') {
      return Padding(
        padding: AppPadding().formInputPadding,
        child: AppButton.outlineButton(
          title: inputControlItem.inputValue ?? '',
          onPressed: () {},
        ),
      );
    }

    if (inputControlItem.type == 'RADIO') {
      return CustomRadioButton(
        inputControlItem: inputControlItem,
      );
    }
    if (inputControlItem.type == 'GENDER') {
      return GenderSelectionRadio(
        inputControlItem: inputControlItem,
      );
    }
    return Container();
  }
}
