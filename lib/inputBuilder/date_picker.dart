import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/ui/input_control_item.dart';
import '../shared/style/app_style.dart';
import '../shared/widgets/common_date_picker_field.dart';

class DatePickerControl extends StatefulWidget {
  final InputControlItem inputControlItem;
  final TextEditingController? controller;
  final Function(DateTime?)? onChanged;
  final bool smartForm;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DatePickerControl({
    super.key,
    required this.inputControlItem,
    this.controller,
    this.smartForm = false,
    this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<DatePickerControl> createState() => _DatePickerControlState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime?>('lastDate', lastDate));
  }
}

class _DatePickerControlState extends State<DatePickerControl> {
  InputControlItem inputControlItem = InputControlItem();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    inputControlItem = widget.inputControlItem;
    _selectedDate = _parseDate(
      widget.controller?.text ?? widget.inputControlItem.inputValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime initialDate = DateTime.now();
    DateTime lastDate = DateTime(2100);
    DateTime firstDate = DateTime(1900);

    /// build validations
    if (inputControlItem.key == 'drivLicIssuDt') {
      lastDate = DateTime.now();
      firstDate = DateTime(initialDate.year - 20);
    }

    if (inputControlItem.key == 'dob' ||
        inputControlItem.key == 'coDriverDOB') {
      lastDate = DateTime.now();
    }

    if (widget.smartForm && inputControlItem.isFreeze!) {
      return Container();
    }
    return Padding(
      padding: (!kIsWeb)
          ? AppPadding().formInputPadding
          : AppPadding().webFormInputPadding,
      child: CommonDatePickerField(
        selectedDate: _selectedDate,
        onDateSelected: (value) {
          setState(() => _selectedDate = value);
          widget.controller?.text =
              value == null ? '' : DateFormat('dd/MM/yyyy').format(value);
          widget.onChanged?.call(value);
        },
        controller: widget.controller,
        enabled: !inputControlItem.isFreeze!,
        readOnly: inputControlItem.isFreeze!,
        labelText:
            '${widget.inputControlItem.labelText ?? ''} ${widget.inputControlItem.validation!.contains('REQUIRED') ? '*' : ''}',
        hintText: 'Select Date',
        firstDate: firstDate,
        initialDate: initialDate,
        lastDate: lastDate,
        validator: _validateInput,
        displayBuilder: (date) => DateFormat('dd/MM/yyyy').format(date),
      ),
    );
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    try {
      return DateFormat('dd/MM/yyyy').parseStrict(value.trim());
    } on FormatException {
      return DateTime.tryParse(value.trim());
    }
  }

  String? _validateInput(DateTime? value) {
    final validation = inputControlItem.validation ?? '';
    if (validation.split(',').contains('REQUIRED') && value == null) {
      return 'This field is required';
    }
    return null;
  }
}
