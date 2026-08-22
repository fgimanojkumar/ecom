import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/ui/input_control_item.dart';
import '../shared/style/app_style.dart';

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

  @override
  void initState() {
    super.initState();
    inputControlItem = widget.inputControlItem;
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
      child: DateTimeField(
        enabled: (!inputControlItem.isFreeze!),
        controller: widget.controller,
        decoration: AppInputDecoration.inputDecorationFormWithBorder(
          labelText:
              '${widget.inputControlItem.labelText ?? ''} ${widget.inputControlItem.validation!.contains('REQUIRED') ? '*' : ''}',
          hintText: 'Select Date',
          isFreeze: inputControlItem.isFreeze!,
        ),
        style: AppTextStyle.textFieldTextStyle(
          isFreeze: inputControlItem.isFreeze,
        ),
        resetIcon: null,
        format: DateFormat('dd/MM/yyyy'),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: firstDate,
            initialDate: currentValue ?? initialDate,
            lastDate: lastDate,
          );
        },
        onChanged: widget.onChanged,
        validator: (value) {
          return _validateInput(value);
        },
      ),
    );
  }

  String? _validateInput(DateTime? value) {
    List<String>? validation = [];
    if (inputControlItem.validation!.isNotEmpty) {
      validation = inputControlItem.validation!.split(',');
    }
    if (validation.contains('REQUIRED') && (value == null)) {
      return 'This field is required';
    }
    return null;
  }
}
