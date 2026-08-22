import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/models/ui/input_control_item.dart';
import '../shared/style/app_style.dart';

class CustomTextInputField extends StatelessWidget {
  final InputControlItem inputControlItem;
  final TextEditingController? controller;
  final bool smartForm;

  const CustomTextInputField({
    super.key,
    required this.inputControlItem,
    this.smartForm = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    List<String>? validation = [];
    if (inputControlItem.validation!.isNotEmpty) {
      validation = inputControlItem.validation!.split(',');
    }
    if (smartForm && inputControlItem.isFreeze!) {
      return Container();
    }
    return Padding(
      padding: (!kIsWeb)
          ? AppPadding().formInputPadding
          : AppPadding().webFormInputPadding,
      child: TextFormField(
        readOnly: inputControlItem.isFreeze ?? false,
        controller: controller,
        maxLines: inputControlItem.validation!.contains('MULTILINE') ? null : 1,
        style: AppTextStyle.textFieldTextStyle(
          isFreeze: inputControlItem.isFreeze,
        ),
        textCapitalization: getCapitalization(inputControlItem.validation!),
        maxLength: validation.contains('MOBILE')
            ? 10
            : validation.contains('EMAIL')
                ? 50
                : 1000,
        keyboardType: getKeyboardType(inputControlItem.validation!),
        decoration: AppInputDecoration.inputDecorationFormWithBorder(
          labelText:
              '${inputControlItem.labelText ?? ''} ${validation.contains('REQUIRED') ? '*' : ''}',
          hintText:
              '${inputControlItem.labelText ?? ''} ${validation.contains('REQUIRED') ? '*' : ''}',
          isFreeze: inputControlItem.isFreeze ?? false,
        ),
        validator: (value) {
          return _validateInput(value, inputControlItem.labelText);
        },
      ),
    );
  }

  /// NOTES: POSSIBLE VALIDATION STRING: EMAIL, MOBILE, REQUIRED, NUMBER
  String? _validateInput(String? value, String? labelText) {
    List<String>? validation = [];
    if (inputControlItem.validation!.isNotEmpty) {
      validation = inputControlItem.validation!.split(',');
    } else {
      return null;
    }
    if (validation.contains('REQUIRED') && (value == null || value.isEmpty)) {
      return '$labelText field is required';
    }
    if (validation.contains('EMAIL') &&
        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value ?? '')) {
      return 'Enter a valid email address!';
    }
    if (validation.contains('MOBILE') &&
        !RegExp(r'^\d+$').hasMatch(value ?? '')) {
      return 'Enter a valid mobile number!';
    }

    if (inputControlItem.validation!.contains('MIN')) {
      String min = validation.where((element) => element.contains('MIN')).first;
      String minVal = min.split('MIN:')[1];
      if (value!.length < int.parse(minVal)) {
        return 'Minimum length should be $minVal';
      }
    }

    if (inputControlItem.validation!.contains('MAX')) {
      String max = validation.where((element) => element.contains('MAX')).first;
      String maxVal = max.split('MAX:')[1];
      if (value!.length > int.parse(maxVal)) {
        return 'Maximum length should be $maxVal';
      }
    }

    if (validation.contains('IFSC')) {
      RegExp regExp = RegExp(
        r'^[A-Z]{4}0[A-Z0-9]{6}$',
        caseSensitive: true,
      );
      if (regExp.hasMatch(value!)) {
        return null;
      } else {
        return 'Enter a valid IFSC code!';
      }
    }

    if (validation.contains('VEHICLE-NO')) {
      RegExp regExp = RegExp(
        r'^[A-Z]{2}[\\ -]{0,1}[0-9]{2}[\\ -]{0,1}[A-Z]{1,2}[\\ -]{0,1}[0-9]{4}$',
        caseSensitive: false,
        multiLine: false,
      );

      if (regExp.hasMatch(value!)) {
        return null;
      } else {
        return 'Enter a valid registration no!';
      }
    }

    if (validation.contains('ISSUING-RTO')) {
      RegExp regExp = RegExp(
        r'^[A-Z]{2}[\\ -]{0,1}[0-9]{2}$',
        caseSensitive: false,
        multiLine: false,
      );

      if (regExp.hasMatch(value!)) {
        return null;
      } else {
        return 'Enter a valid issuing RTO number!';
      }
    }

    if (validation.contains('ALPHA-NUMERIC')) {
      RegExp regExp = RegExp(
        r'^([A-Za-z]|[0-9])+$',
        caseSensitive: false,
        multiLine: false,
      );

      if (regExp.hasMatch(value!)) {
        return null;
      } else {
        return 'Enter a valid $labelText value!';
      }
    }

    return null;
  }

  TextInputType getKeyboardType(String validation) {
    if (validation.contains('EMAIL')) {
      return TextInputType.emailAddress;
    } else if (validation.contains('MOBILE')) {
      return TextInputType.phone;
    } else if (validation.contains('NUMBER')) {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }

  TextCapitalization getCapitalization(String validation) {
    if (validation.contains('UPPERCASE')) {
      return TextCapitalization.characters;
    } else {
      return TextCapitalization.none;
    }
  }
}
