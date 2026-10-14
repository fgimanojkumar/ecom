import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/models/ui/input_control_item.dart';
import '../shared/style/app_style.dart';
import '../shared/widgets/common_dropdown_field.dart';

class CustomDropDownField extends StatefulWidget {
  final InputControlItem inputControlItem;
  final dynamic selectedValue;
  final List<String>? dropDownItems;
  final ValueChanged<String> onChanged;
  final int padding;

  const CustomDropDownField({
    super.key,
    required this.inputControlItem,
    this.selectedValue,
    this.dropDownItems,
    required this.onChanged,
    this.padding = 1,
  });

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    List<String> dropDownItems = widget.dropDownItems ?? [];
    if (dropDownItems.isEmpty) {
      String? description = widget.inputControlItem.inputOption;
      if (description != null) {
        dropDownItems = description
            .split(',')
            .map((x) => x.trim())
            .where((element) => element.isNotEmpty)
            .toList();
      }
    }

    return Padding(
      padding: (widget.padding == 1)
          ? (!kIsWeb)
              ? AppPadding().formInputPadding
              : AppPadding().webFormInputPadding
          : const EdgeInsets.all(0),
      child: CommonDropdownField<String>(
        value: widget.selectedValue?.toString(),
        options: dropDownItems
            .map((item) => CommonDropdownOption<String>(
                  value: item,
                  label: item,
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) widget.onChanged(value);
        },
        labelText:
            '${widget.inputControlItem.labelText ?? ''} ${widget.inputControlItem.validation!.contains('REQUIRED') ? '*' : ''}',
        hintText: widget.inputControlItem.hintText,
        readOnly: widget.inputControlItem.isFreeze ?? false,
        radius: 12,
        fillColor: AppColors.white1,
      ),
    );
  }
}
