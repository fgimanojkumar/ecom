import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/ui/input_control_item.dart';
import '../shared/style/app_style.dart';

class DateTimePickerControl extends StatefulWidget {
  final InputControlItem inputControlItem;
  final Function(DateTime?)? onChanged;

  const DateTimePickerControl({
    super.key,
    required this.inputControlItem,
    this.onChanged,
  });

  @override
  State<DateTimePickerControl> createState() => _DateTimePickerControlState();
}

class _DateTimePickerControlState extends State<DateTimePickerControl> {
  InputControlItem inputControlItem = InputControlItem();
  TextEditingController _dateController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    inputControlItem = widget.inputControlItem;

    _selectedDate = DateFormat('dd/MM/yyyy HH:mm').parse(
      widget.inputControlItem.inputValue ?? '',
    );
    _dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy HH:mm').format(_selectedDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding().formInputPadding,
      child: DateTimeField(
        enabled: (!inputControlItem.isFreeze!),
        controller: _dateController,
        decoration: AppInputDecoration.inputDecorationFormWithBorder(
          labelText: widget.inputControlItem.labelText ?? '',
          hintText: 'Select Date & Time',
          isFreeze: inputControlItem.isFreeze!,
        ),
        resetIcon: null,
        format: DateFormat('dd/MM/yyyy HH:mm'),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (date != null && context.mounted) {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(
                currentValue ?? DateTime.now(),
              ),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    );
  }
}
