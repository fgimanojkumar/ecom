import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class CustomAppToggleSwitch extends StatelessWidget {
  final bool current;
  final Function(bool) onChanged;
  final bool isSmartForm;

  const CustomAppToggleSwitch({
    super.key,
    required this.current,
    required this.onChanged,
    this.isSmartForm = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      current: current,
      first: false,
      second: true,
      spacing: 15,
      textMargin: EdgeInsets.zero,
      style: ToggleStyle(
        backgroundColor: current ? AppColors.statusBtnGreen : AppColors.greyLight,
        borderColor: Colors.transparent,
      ),
      height: 24,
      indicatorSize: const Size.fromRadius(9),
      onChanged: onChanged,
      styleBuilder: (bool b) => const ToggleStyle(
        indicatorColor: AppColors.white,
      ),
      textBuilder: (bool value) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text(
            isSmartForm
                ? (value ? 'ON' : 'OFF')
                : value
                    ? 'YES'
                    : 'NO',
            style: const TextStyle(color: AppColors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }
}



