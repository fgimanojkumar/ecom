import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import 'common_dropdown_field.dart';

class CommonMultiSelectDropdownField<T> extends StatelessWidget {
  const CommonMultiSelectDropdownField({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onSelectionChanged,
    this.labelText,
    this.hintText,
    this.searchHintText = 'Search',
    this.radius = 16,
    this.enabled = true,
    this.readOnly = false,
    this.isItemReadOnly,
    this.sheetTitle = 'Select Options',
    this.clearSelectionLabel = 'Clear',
    this.closeLabel = 'Close',
    this.selectAllLabel = 'Select All',
    this.applyButtonLabelBuilder,
    this.emptyResultText = 'No options found',
    this.showSearch = true,
    this.showSelectAll = true,
  });

  final List<CommonDropdownOption<T>> options;
  final List<T> selectedValues;
  final ValueChanged<List<T>> onSelectionChanged;
  final String? labelText;
  final String? hintText;
  final String searchHintText;
  final double radius;
  final bool enabled;
  final bool readOnly;
  final bool Function(CommonDropdownOption<T> option)? isItemReadOnly;
  final String sheetTitle;
  final String clearSelectionLabel;
  final String closeLabel;
  final String selectAllLabel;
  final String Function(int selectedCount)? applyButtonLabelBuilder;
  final String emptyResultText;
  final bool showSearch;
  final bool showSelectAll;

  @override
  Widget build(BuildContext context) {
    final List<CommonDropdownOption<T>> selectedOptions = options
        .where((option) => selectedValues.contains(option.value))
        .toList();

    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: enabled ? () => _openMultiSelectBottomSheet(context) : null,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
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
          fillColor: enabled ? AppColors.white1 : AppColors.white2,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: AppColors.divider,
              width: 1.2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
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
          enabled: enabled,
          suffixIcon: Icon(
            readOnly
                ? Icons.lock_outline_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: enabled ? AppColors.black2 : AppColors.muteIconColor,
          ),
        ),
        child: selectedOptions.isEmpty
            ? Text(
                hintText ?? 'Select options',
                style: const TextStyle(
                  color: AppColors.muteIconColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedOptions
                    .map(
                      (option) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x1FC45A2A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (option.icon != null) ...[
                              Icon(
                                option.icon,
                                size: 14,
                                color: AppColors.primary2,
                              ),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              option.label,
                              style: const TextStyle(
                                color: AppColors.primary2,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }

  void _openMultiSelectBottomSheet(BuildContext context) {
    if (!enabled) {
      return;
    }

    final TextEditingController searchController = TextEditingController();
    final Set<T> tempSelectedValues = selectedValues.toSet();
    List<CommonDropdownOption<T>> filteredOptions =
        List<CommonDropdownOption<T>>.from(
      options,
    );

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (BuildContext modalContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.72,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              sheetTitle,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black1,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(modalContext).pop();
                                },
                                child: Text(
                                  closeLabel,
                                  style: const TextStyle(
                                    color: AppColors.black2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: readOnly
                                    ? null
                                    : () {
                                        setModalState(() {
                                          tempSelectedValues.clear();
                                        });
                                      },
                                child: Text(
                                  clearSelectionLabel,
                                  style: TextStyle(
                                    color: readOnly
                                        ? AppColors.muteIconColor
                                        : AppColors.primary2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (showSearch)
                        TextField(
                          controller: searchController,
                          onChanged: (String query) {
                            setModalState(() {
                              final String normalizedQuery =
                                  query.trim().toLowerCase();
                              filteredOptions = options
                                  .where(
                                    (option) => option.label
                                        .toLowerCase()
                                        .contains(normalizedQuery),
                                  )
                                  .toList();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: searchHintText,
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: AppColors.black2,
                            ),
                            suffixIcon: searchController.text.trim().isEmpty
                                ? null
                                : IconButton(
                                    onPressed: () {
                                      setModalState(() {
                                        searchController.clear();
                                        filteredOptions =
                                            List<CommonDropdownOption<T>>.from(
                                          options,
                                        );
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: AppColors.black2,
                                    ),
                                  ),
                            filled: true,
                            fillColor: AppColors.white1,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: AppColors.primary2,
                                width: 1.4,
                              ),
                            ),
                          ),
                        ),
                      if (showSearch) const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      if (showSelectAll && filteredOptions.isNotEmpty)
                        Builder(
                          builder: (BuildContext context) {
                            final List<CommonDropdownOption<T>>
                                selectableFilteredOptions =
                                filteredOptions.where((option) {
                              if (readOnly) {
                                return false;
                              }
                              return !(isItemReadOnly?.call(option) ?? false);
                            }).toList();

                            final int selectedInFilterCount =
                                selectableFilteredOptions
                                    .where(
                                      (option) => tempSelectedValues
                                          .contains(option.value),
                                    )
                                    .length;
                            final bool areAllFilteredSelected =
                                selectedInFilterCount ==
                                        selectableFilteredOptions.length &&
                                    selectableFilteredOptions.isNotEmpty;
                            final bool hasSomeFilteredSelected =
                                selectedInFilterCount > 0 &&
                                    !areAllFilteredSelected;

                            return CheckboxListTile(
                              value: areAllFilteredSelected
                                  ? true
                                  : hasSomeFilteredSelected
                                      ? null
                                      : false,
                              tristate: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              activeColor: AppColors.primary2,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                '$selectAllLabel (${selectableFilteredOptions.length})',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: readOnly
                                      ? AppColors.muteIconColor
                                      : AppColors.black1,
                                ),
                              ),
                              onChanged: readOnly
                                  ? null
                                  : (bool? checked) {
                                      setModalState(() {
                                        if (checked ?? false) {
                                          for (final CommonDropdownOption<
                                                  T> option
                                              in selectableFilteredOptions) {
                                            tempSelectedValues
                                                .add(option.value);
                                          }
                                        } else {
                                          for (final CommonDropdownOption<
                                                  T> option
                                              in selectableFilteredOptions) {
                                            tempSelectedValues
                                                .remove(option.value);
                                          }
                                        }
                                      });
                                    },
                            );
                          },
                        ),
                      if (showSelectAll && filteredOptions.isNotEmpty)
                        const Divider(height: 1, color: AppColors.divider),
                      Expanded(
                        child: filteredOptions.isEmpty
                            ? Center(
                                child: Text(
                                  emptyResultText,
                                  style: const TextStyle(
                                    color: AppColors.black2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemCount: filteredOptions.length,
                                separatorBuilder: (_, __) => const Divider(
                                  height: 1,
                                  color: AppColors.divider,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final CommonDropdownOption<T> option =
                                      filteredOptions[index];
                                  final bool isOptionReadOnly = readOnly ||
                                      (isItemReadOnly?.call(option) ?? false);
                                  final bool isSelected =
                                      tempSelectedValues.contains(option.value);
                                  return CheckboxListTile(
                                    value: isSelected,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    activeColor: AppColors.primary2,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    enabled: !isOptionReadOnly,
                                    title: Row(
                                      children: [
                                        if (option.icon != null) ...[
                                          Icon(
                                            option.icon,
                                            size: 18,
                                            color: AppColors.primary2,
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                        Expanded(
                                          child: Text(
                                            option.label,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: isOptionReadOnly
                                                  ? AppColors.muteIconColor
                                                  : AppColors.black1,
                                            ),
                                          ),
                                        ),
                                        if (isOptionReadOnly)
                                          const Icon(
                                            Icons.lock_outline_rounded,
                                            size: 16,
                                            color: AppColors.muteIconColor,
                                          ),
                                      ],
                                    ),
                                    onChanged: isOptionReadOnly
                                        ? null
                                        : (bool? checked) {
                                            setModalState(() {
                                              if (checked ?? false) {
                                                tempSelectedValues
                                                    .add(option.value);
                                              } else {
                                                tempSelectedValues
                                                    .remove(option.value);
                                              }
                                            });
                                          },
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: readOnly
                              ? () {
                                  Navigator.of(modalContext).pop();
                                }
                              : () {
                                  onSelectionChanged(
                                    options
                                        .where(
                                          (option) => tempSelectedValues
                                              .contains(option.value),
                                        )
                                        .map((option) => option.value)
                                        .toList(),
                                  );
                                  Navigator.of(modalContext).pop();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: readOnly
                                ? AppColors.black2
                                : AppColors.primary2,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            readOnly
                                ? closeLabel
                                : (applyButtonLabelBuilder
                                        ?.call(tempSelectedValues.length) ??
                                    'Apply (${tempSelectedValues.length})'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(searchController.dispose);
  }
}
