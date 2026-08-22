import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class CommonDropdownOption<T> {
  const CommonDropdownOption({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final IconData? icon;
}

class CommonDropdownField<T> extends StatelessWidget {
  const CommonDropdownField({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.radius = 16,
  });

  final T? value;
  final List<CommonDropdownOption<T>> options;
  final ValueChanged<T?> onChanged;
  final String? labelText;
  final String? hintText;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.black2,
      ),
      dropdownColor: AppColors.white,
      style: const TextStyle(
        color: AppColors.black1,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.black2,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        hintStyle: const TextStyle(
          color: AppColors.muteIconColor,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        filled: true,
        fillColor: AppColors.white1,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: AppColors.divider,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: AppColors.primary2,
            width: 1.6,
          ),
        ),
      ),
      items: options.map((option) {
        return DropdownMenuItem<T>(
          value: option.value,
          child: Row(
            children: [
              if (option.icon != null) ...[
                Icon(
                  option.icon,
                  size: 18,
                  color: AppColors.primary2,
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(
                  option.label,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
