import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/ui/input_control_item.dart';
import '../shared/style/app_style.dart';
import '../shared/widgets/common_date_picker_field.dart';

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

    _selectedDate = DateFormat('dd/MM/yyyy HH:mm')
            .tryParse(widget.inputControlItem.inputValue ?? '') ??
        DateTime.now();
    _dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy HH:mm').format(_selectedDate),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding().formInputPadding,
      child: CommonDatePickerField(
        selectedDate: _selectedDate,
        onDateSelected: (value) {
          if (value == null) return;
          setState(() {
            _selectedDate = value;
            _dateController.text = DateFormat('dd/MM/yyyy HH:mm').format(value);
          });
          widget.onChanged?.call(value);
        },
        controller: _dateController,
        labelText: widget.inputControlItem.labelText ?? '',
        hintText: 'Select Date & Time',
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        includeTime: true,
        enabled: !inputControlItem.isFreeze!,
        readOnly: inputControlItem.isFreeze!,
        displayBuilder: (date) => DateFormat('dd/MM/yyyy HH:mm').format(date),
      ),
    );
  }
}
