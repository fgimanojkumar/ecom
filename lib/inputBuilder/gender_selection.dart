import 'package:flutter/material.dart';

import '../data/models/ui/input_control_item.dart';
import '../shared/style/app_style.dart';

class GenderSelectionRadio extends StatelessWidget {
  final InputControlItem inputControlItem;

  const GenderSelectionRadio({
    super.key,
    required this.inputControlItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppPadding().formInputPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH8,
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  inputControlItem.hintText ?? '',
                  style: AppTextStyle.mutedTextLabel(),
                )),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        value: 1,
                        activeColor: AppColors.statusBtnGreen,
                        groupValue: 0,
                        onChanged: (int? value) {},
                      ),
                      const Text('Male', style: TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                        value: 2,
                        activeColor: AppColors.statusBtnGreen,
                        groupValue: 1,
                        onChanged: (int? value) {},
                      ),
                      const Text('Female', style: TextStyle(fontSize: 9)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
