import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/models/ui/input_control_item.dart';
import '../shared/style/app_style.dart';

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
      child: SizedBox(
        // height: 7.65.h,
        child: InputDecorator(
          decoration: AppInputDecoration.inputDecorationFormWithBorder(
            isFreeze: widget.inputControlItem.isFreeze!,
            labelText:
                '${widget.inputControlItem.labelText ?? ''} ${widget.inputControlItem.validation!.contains('REQUIRED') ? '*' : ''}',
          ),
          child: DropdownButton<dynamic>(
            value: widget.selectedValue,
            hint: Text(widget.inputControlItem.hintText ?? ''),
            underline: Container(),
            style: AppTextStyle.dropdownTextStyle(
              isFreeze: widget.inputControlItem.isFreeze,
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            iconEnabledColor: AppColors.black,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            isExpanded: true,
            isDense: true,
            onChanged: (value) {
              widget.onChanged(value);
            },
            items: dropDownItems
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: const TextStyle(fontSize: 14)),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
