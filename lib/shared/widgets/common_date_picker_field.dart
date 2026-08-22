import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../style/app_colors.dart';

enum CommonDatePickerSelectionType {
  single,
  multiple,
  range,
}

class CommonDatePickerField extends StatefulWidget {
  const CommonDatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.labelText,
    this.hintText = 'Select date',
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.enabled = true,
    this.readOnly = false,
    this.allowClear = true,
    this.radius = 16,
    this.displayBuilder,
    this.validator,
    this.selectionType = CommonDatePickerSelectionType.single,
    this.selectedDates = const <DateTime>[],
    this.selectedRange,
    this.onDatesSelected,
    this.onRangeSelected,
    this.includeTime = false,
    this.maxSelectionCount,
    this.sheetTitle = 'Select dates',
    this.addDateLabel = 'Add date',
    this.applyLabel = 'Apply',
    this.clearLabel = 'Clear',
    this.rangeStartLabel = 'Start',
    this.rangeEndLabel = 'End',
    this.firstDayOfWeek = 1,
    this.showToday = true,
    this.allowManualInput = false,
    this.manualInputErrorText =
        'Invalid format. Use dd/MM/yyyy or dd/MM/yyyy HH:mm',
    this.dateFormatPattern = 'dd/MM/yyyy',
    this.manualInputPatterns = const <String>[
      'dd/MM/yyyy',
      'dd-MM-yyyy',
    ],
    this.calendarBackgroundColor = AppColors.white,
    this.calendarPrimaryColor = AppColors.primary2,
    this.calendarSurfaceTintColor = AppColors.white,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;
  final String? labelText;
  final String hintText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final bool enabled;
  final bool readOnly;
  final bool allowClear;
  final double radius;
  final String Function(DateTime date)? displayBuilder;
  final String? Function(DateTime? date)? validator;
  final CommonDatePickerSelectionType selectionType; // single, multiple, range
  final List<DateTime> selectedDates;
  final DateTimeRange? selectedRange;
  final ValueChanged<List<DateTime>>? onDatesSelected;
  final ValueChanged<DateTimeRange?>? onRangeSelected;
  final bool includeTime;
  final int? maxSelectionCount;
  final String sheetTitle;
  final String addDateLabel;
  final String applyLabel;
  final String clearLabel;
  final String rangeStartLabel;
  final String rangeEndLabel;
  final int firstDayOfWeek;
  final bool showToday;
  final bool allowManualInput;
  final String manualInputErrorText;
  final String dateFormatPattern;
  final List<String> manualInputPatterns;
  final Color calendarBackgroundColor;
  final Color calendarPrimaryColor;
  final Color calendarSurfaceTintColor;

  @override
  State<CommonDatePickerField> createState() => _CommonDatePickerFieldState();
}

class _CommonDatePickerFieldState extends State<CommonDatePickerField> {
  late final TextEditingController _textController;

  late final TextInputFormatter _singleDateManualFormatter;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _buildDisplayText());
    _singleDateManualFormatter = _PatternDateTextInputFormatter(
      pattern: widget.dateFormatPattern,
      includeTime: widget.includeTime,
    );
  }

  @override
  void didUpdateWidget(covariant CommonDatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dateFormatPattern != widget.dateFormatPattern ||
        oldWidget.includeTime != widget.includeTime) {
      _singleDateManualFormatter = _PatternDateTextInputFormatter(
        pattern: widget.dateFormatPattern,
        includeTime: widget.includeTime,
      );
    }

    final String nextText = _buildDisplayText();
    if (_textController.text != nextText) {
      _textController.text = nextText;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String displayText = _buildDisplayText();
    if (_textController.text != displayText) {
      _textController.text = displayText;
    }

    return TextFormField(
      controller: _textController,
      enabled: widget.enabled,
      readOnly: !_isManualInputEnabledForCurrentSelection || widget.readOnly,
      keyboardType: _isManualInputEnabledForCurrentSelection
          ? TextInputType.datetime
          : TextInputType.text,
      inputFormatters: _shouldUsePatternFormatter
          ? <TextInputFormatter>[_singleDateManualFormatter]
          : null,
      onTap: widget.enabled &&
              !widget.readOnly &&
              !_isManualInputEnabledForCurrentSelection
          ? () => _openPicker(context)
          : null,
      onFieldSubmitted:
          _isManualInputEnabledForCurrentSelection ? _handleManualInput : null,
      onEditingComplete: _isManualInputEnabledForCurrentSelection
          ? () => _handleManualInput(_textController.text)
          : null,
      validator: (_) => widget.validator?.call(widget.selectedDate),
      style: const TextStyle(
        color: AppColors.black1,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
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
        fillColor: widget.enabled ? AppColors.white1 : AppColors.white2,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        suffixIcon: SizedBox(
          width: 42,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.readOnly)
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.black2,
                  ),
                )
              else
                IconButton(
                  onPressed: widget.enabled ? () => _openPicker(context) : null,
                  tooltip: 'Open calendar',
                  icon: Icon(
                    Icons.calendar_today_rounded,
                    size: 18,
                    color: widget.enabled
                        ? AppColors.black2
                        : AppColors.muteIconColor,
                  ),
                ),
            ],
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: AppColors.divider,
            width: 1.2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: AppColors.divider,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: AppColors.primary2,
            width: 1.6,
          ),
        ),
      ),
    );
  }

  bool get _shouldUsePatternFormatter {
    return _isManualInputEnabledForCurrentSelection &&
        widget.selectionType == CommonDatePickerSelectionType.single;
  }

  bool get _isManualInputEnabledForCurrentSelection {
    return widget.allowManualInput &&
        widget.selectionType == CommonDatePickerSelectionType.single;
  }

  String _buildDisplayText() {
    switch (widget.selectionType) {
      case CommonDatePickerSelectionType.single:
        return _formatDate(widget.selectedDate);
      case CommonDatePickerSelectionType.multiple:
        if (widget.selectedDates.isEmpty) {
          return '';
        }
        return widget.selectedDates.map(_formatDate).join(', ');
      case CommonDatePickerSelectionType.range:
        if (widget.selectedRange == null) {
          return '';
        }
        return '${_formatDate(widget.selectedRange!.start)} - ${_formatDate(widget.selectedRange!.end)}';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }
    if (widget.displayBuilder != null) {
      return widget.displayBuilder!(date);
    }
    return _formatWithPattern(date, widget.dateFormatPattern);
  }

  String _formatWithPattern(DateTime date, String pattern) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();
    final String hour = date.hour.toString().padLeft(2, '0');
    final String minute = date.minute.toString().padLeft(2, '0');

    String output = pattern
        .replaceAll('dd', day)
        .replaceAll('MM', month)
        .replaceAll('yyyy', year)
        .replaceAll('HH', hour)
        .replaceAll('mm', minute);

    if (widget.includeTime && !pattern.contains('HH:mm')) {
      output = '$output $hour:$minute';
    }
    return output;
  }

  DateTime _normalizeDate(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }

  DateTime _applyPickedTime(DateTime baseDate, TimeOfDay time) {
    return DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      time.hour,
      time.minute,
    );
  }

  void _handleManualInput(String rawValue) {
    if (!_isManualInputEnabledForCurrentSelection ||
        widget.readOnly ||
        !widget.enabled) {
      return;
    }

    final String value = rawValue.trim();
    if (value.isEmpty) {
      widget.onDateSelected(null);
      _textController.clear();
      return;
    }

    final DateTime? parsedSingle = _parseManualDate(value);
    if (parsedSingle == null || !_isWithinDateBounds(parsedSingle)) {
      _showManualError();
      _textController.text = _buildDisplayText();
      return;
    }

    _textController.text = _formatDate(parsedSingle);
    widget.onDateSelected(parsedSingle);
  }

  DateTime? _parseManualDate(String input) {
    final Set<String> patterns = <String>{
      widget.dateFormatPattern,
      ...widget.manualInputPatterns,
    };

    if (widget.includeTime) {
      final List<String> extended = patterns
          .map((pattern) =>
              pattern.contains('HH:mm') ? pattern : '$pattern HH:mm')
          .toList();
      patterns.addAll(extended);
    }

    for (final String pattern in patterns) {
      final DateTime? parsed = _tryParseWithPattern(input, pattern);
      if (parsed != null) {
        return parsed;
      }
    }

    return null;
  }

  DateTime? _tryParseWithPattern(String input, String pattern) {
    final List<String> patternParts = pattern
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList();
    final List<String> inputParts =
        input.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();

    if (patternParts.isEmpty || inputParts.isEmpty) {
      return null;
    }

    final String datePattern = patternParts.first;
    final String dateInput = inputParts.first;
    final String separator = _detectSeparator(datePattern);
    if (separator.isEmpty) {
      return null;
    }

    final List<String> patternDateTokens = datePattern.split(separator);
    final List<String> inputDateTokens = dateInput.split(separator);
    if (patternDateTokens.length != 3 || inputDateTokens.length != 3) {
      return null;
    }

    final Map<String, int> dateValues = <String, int>{};
    for (int i = 0; i < patternDateTokens.length; i++) {
      final int? parsedToken = int.tryParse(inputDateTokens[i]);
      if (parsedToken == null) {
        return null;
      }
      dateValues[patternDateTokens[i]] = parsedToken;
    }

    final int day = dateValues['dd'] ?? -1;
    final int month = dateValues['MM'] ?? -1;
    final int year = dateValues['yyyy'] ?? -1;

    int hour = 0;
    int minute = 0;

    final bool shouldParseTime = pattern.contains('HH:mm') ||
        widget.includeTime ||
        inputParts.length > 1;
    if (shouldParseTime) {
      if (inputParts.length < 2) {
        if (widget.includeTime) {
          return null;
        }
      } else {
        final List<String> timeTokens = inputParts[1].split(':');
        if (timeTokens.length != 2) {
          return null;
        }
        hour = int.tryParse(timeTokens[0]) ?? -1;
        minute = int.tryParse(timeTokens[1]) ?? -1;
      }
    }

    if (day <= 0 || month <= 0 || year <= 0) {
      return null;
    }
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      return null;
    }

    final DateTime parsed = DateTime(year, month, day, hour, minute);
    if (parsed.year != year || parsed.month != month || parsed.day != day) {
      return null;
    }

    return parsed;
  }

  String _detectSeparator(String pattern) {
    if (pattern.contains('/')) {
      return '/';
    }
    if (pattern.contains('-')) {
      return '-';
    }
    if (pattern.contains('.')) {
      return '.';
    }
    return '';
  }

  bool _isWithinDateBounds(DateTime value) {
    final DateTime now = DateTime.now();
    final DateTime minDate = widget.firstDate ?? DateTime(now.year - 100);
    final DateTime maxDate = widget.lastDate ?? DateTime(now.year + 20);
    return !value.isBefore(minDate) && !value.isAfter(maxDate);
  }

  void _showManualError({String? customMessage}) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      return;
    }
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(customMessage ?? widget.manualInputErrorText),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  ThemeData _buildCalendarTheme(BuildContext context) {
    final ThemeData baseTheme = Theme.of(context);
    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: widget.calendarPrimaryColor,
        onPrimary: AppColors.white,
        surface: widget.calendarBackgroundColor,
        onSurface: AppColors.black1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: widget.calendarBackgroundColor,
        surfaceTintColor: widget.calendarSurfaceTintColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: widget.calendarBackgroundColor,
        surfaceTintColor: widget.calendarSurfaceTintColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        dayStyle: const TextStyle(
          color: AppColors.black1,
          fontWeight: FontWeight.w600,
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: widget.calendarBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        hourMinuteTextColor: AppColors.black1,
      ),
    );
  }

  Future<void> _openPicker(BuildContext context) async {
    switch (widget.selectionType) {
      case CommonDatePickerSelectionType.single:
        await _pickSingleDate(context);
        break;
      case CommonDatePickerSelectionType.multiple:
        await _pickMultipleDates(context);
        break;
      case CommonDatePickerSelectionType.range:
        await _pickDateRange(context);
        break;
    }
  }

  Future<void> _pickSingleDate(BuildContext context) async {
    final _CalendarDialogResult? result = await _showCalendarDialog(context);
    if (result == null) {
      return;
    }

    if (result.cleared) {
      _textController.clear();
      widget.onDateSelected(null);
      return;
    }

    final DateTime? pickedDate = result.singleDate;
    if (pickedDate == null) {
      return;
    }

    DateTime resultDate = _normalizeDate(pickedDate);
    if (widget.includeTime) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(widget.selectedDate ?? DateTime.now()),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: _buildCalendarTheme(context),
            child: child ?? const SizedBox.shrink(),
          );
        },
      );
      if (pickedTime == null) {
        return;
      }
      resultDate = _applyPickedTime(resultDate, pickedTime);
    }

    _textController.text = _formatDate(resultDate);
    widget.onDateSelected(resultDate);
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final _CalendarDialogResult? result = await _showCalendarDialog(context);
    if (result == null) {
      return;
    }

    if (result.cleared) {
      _textController.clear();
      widget.onRangeSelected?.call(null);
      return;
    }

    final DateTimeRange? pickedRange = result.range;
    if (pickedRange == null) {
      return;
    }

    DateTime rangeStart = _normalizeDate(pickedRange.start);
    DateTime rangeEnd = _normalizeDate(pickedRange.end);

    if (widget.includeTime) {
      final TimeOfDay? startTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(rangeStart),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: _buildCalendarTheme(context),
            child: child ?? const SizedBox.shrink(),
          );
        },
      );
      if (startTime == null) {
        return;
      }
      final TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(rangeEnd),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: _buildCalendarTheme(context),
            child: child ?? const SizedBox.shrink(),
          );
        },
      );
      if (endTime == null) {
        return;
      }
      rangeStart = _applyPickedTime(rangeStart, startTime);
      rangeEnd = _applyPickedTime(rangeEnd, endTime);
      if (rangeEnd.isBefore(rangeStart)) {
        rangeEnd = rangeStart;
      }
    }

    _textController.text =
        '${_formatDate(rangeStart)} - ${_formatDate(rangeEnd)}';
    widget.onRangeSelected
        ?.call(DateTimeRange(start: rangeStart, end: rangeEnd));
  }

  Future<void> _pickMultipleDates(BuildContext context) async {
    final _CalendarDialogResult? result = await _showCalendarDialog(context);
    if (result == null) {
      return;
    }

    if (result.cleared) {
      _textController.clear();
      widget.onDatesSelected?.call(const <DateTime>[]);
      return;
    }

    _textController.text = result.multipleDates.map(_formatDate).join(', ');
    widget.onDatesSelected?.call(result.multipleDates);
  }

  Future<_CalendarDialogResult?> _showCalendarDialog(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime minDate =
        _stripDate(widget.firstDate ?? DateTime(now.year - 100));
    final DateTime maxDate =
        _stripDate(widget.lastDate ?? DateTime(now.year + 20));

    DateTime initialDate = widget.initialDate ?? now;
    switch (widget.selectionType) {
      case CommonDatePickerSelectionType.single:
        initialDate = widget.selectedDate ?? initialDate;
        break;
      case CommonDatePickerSelectionType.multiple:
        if (widget.selectedDates.isNotEmpty) {
          initialDate = widget.selectedDates.last;
        }
        break;
      case CommonDatePickerSelectionType.range:
        initialDate = widget.selectedRange?.start ?? initialDate;
        break;
    }
    initialDate = _stripDate(initialDate);
    if (initialDate.isBefore(minDate)) {
      initialDate = minDate;
    }
    if (initialDate.isAfter(maxDate)) {
      initialDate = maxDate;
    }

    return showDialog<_CalendarDialogResult>(
      context: context,
      builder: (BuildContext dialogContext) {
        return Theme(
          data: _buildCalendarTheme(dialogContext),
          child: _CommonCalendarDialog(
            selectionType: widget.selectionType,
            initialDate: initialDate,
            minDate: minDate,
            maxDate: maxDate,
            selectedDate: widget.selectedDate,
            selectedDates: widget.selectedDates,
            selectedRange: widget.selectedRange,
            maxSelectionCount: widget.maxSelectionCount,
            title: widget.sheetTitle,
            applyLabel: widget.applyLabel,
            clearLabel: widget.clearLabel,
            showToday: widget.showToday,
            firstDayOfWeek: widget.firstDayOfWeek,
          ),
        );
      },
    );
  }

  DateTime _stripDate(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}

enum _CalendarViewMode {
  days,
  months,
  years,
}

class _CalendarDialogResult {
  const _CalendarDialogResult({
    this.singleDate,
    this.multipleDates = const <DateTime>[],
    this.range,
    this.cleared = false,
  });

  final DateTime? singleDate;
  final List<DateTime> multipleDates;
  final DateTimeRange? range;
  final bool cleared;
}

class _CommonCalendarDialog extends StatefulWidget {
  const _CommonCalendarDialog({
    required this.selectionType,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
    required this.selectedDate,
    required this.selectedDates,
    required this.selectedRange,
    required this.maxSelectionCount,
    required this.title,
    required this.applyLabel,
    required this.clearLabel,
    required this.showToday,
    required this.firstDayOfWeek,
  });

  final CommonDatePickerSelectionType selectionType;
  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTime? selectedDate;
  final List<DateTime> selectedDates;
  final DateTimeRange? selectedRange;
  final int? maxSelectionCount;
  final String title;
  final String applyLabel;
  final String clearLabel;
  final bool showToday;
  final int firstDayOfWeek;

  @override
  State<_CommonCalendarDialog> createState() => _CommonCalendarDialogState();
}

class _CommonCalendarDialogState extends State<_CommonCalendarDialog> {
  static const List<String> _monthNames = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> _monthShort = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> _weekDayNames = <String>[
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  late DateTime _viewDate;
  _CalendarViewMode _viewMode = _CalendarViewMode.days;
  DateTime? _single;
  late Set<DateTime> _multiple;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime? _hoverDate;

  @override
  void initState() {
    super.initState();
    _viewDate = _stripDate(widget.initialDate);
    _single =
        widget.selectedDate == null ? null : _stripDate(widget.selectedDate!);
    _multiple = widget.selectedDates.map(_stripDate).toSet();
    _rangeStart = widget.selectedRange == null
        ? null
        : _stripDate(widget.selectedRange!.start);
    _rangeEnd = widget.selectedRange == null
        ? null
        : _stripDate(widget.selectedRange!.end);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SizedBox(
        width: 380,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(theme),
              const SizedBox(height: 8),
              if (_viewMode == _CalendarViewMode.days) ...[
                _buildWeekDaysRow(theme),
                const SizedBox(height: 6),
                _buildDaysGrid(theme),
              ] else if (_viewMode == _CalendarViewMode.months)
                _buildMonthsGrid(theme)
              else
                _buildYearsGrid(theme),
              const SizedBox(height: 10),
              _buildFooter(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              const SizedBox(width: 40),
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.black1,
                      fontWeight: FontWeight.w800,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded, color: AppColors.black1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.body,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => _navigate(-1),
                icon: const Icon(Icons.chevron_left_rounded,
                    color: AppColors.black1),
                splashRadius: 18,
              ),
              Expanded(
                child: Center(child: _buildHeaderLabel(theme)),
              ),
              IconButton(
                onPressed: () => _navigate(1),
                icon: const Icon(Icons.chevron_right_rounded,
                    color: AppColors.black1),
                splashRadius: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderLabel(ThemeData theme) {
    switch (_viewMode) {
      case _CalendarViewMode.days:
        return Wrap(
          spacing: 4,
          children: [
            TextButton(
              onPressed: () =>
                  setState(() => _viewMode = _CalendarViewMode.months),
              child: Text(
                _monthNames[_viewDate.month - 1],
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () =>
                  setState(() => _viewMode = _CalendarViewMode.years),
              child: Text(
                '${_viewDate.year}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        );
      case _CalendarViewMode.months:
        return TextButton(
          onPressed: () => setState(() => _viewMode = _CalendarViewMode.years),
          child: Text(
            '${_viewDate.year}',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        );
      case _CalendarViewMode.years:
        final List<int> years = _visibleYears;
        return Text(
          '${years.first} - ${years.last}',
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        );
    }
  }

  Widget _buildWeekDaysRow(ThemeData theme) {
    final List<String> names = _orderedWeekDays;
    return Row(
      children: names
          .map(
            (name) => Expanded(
              child: Center(
                child: Text(
                  name,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.black2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDaysGrid(ThemeData theme) {
    final List<DateTime> days = _visibleDays;
    return GridView.builder(
      itemCount: days.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final DateTime day = days[index];
        final bool disabled = _isDisabled(day);
        final bool selected = _isSelected(day);
        final bool inRange = _isInRange(day);
        final bool isStart = _rangeStart != null && _sameDay(_rangeStart!, day);
        final bool isEnd = _rangeEnd != null && _sameDay(_rangeEnd!, day);
        final bool isOtherMonth = day.month != _viewDate.month;

        return MouseRegion(
          onEnter: (_) => setState(() => _hoverDate = day),
          onExit: (_) => setState(() => _hoverDate = null),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: disabled ? null : () => _onSelectDay(day),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: selected || isStart || isEnd
                    ? AppColors.primary2
                    : inRange
                        ? AppColors.primary2.withValues(alpha: 0.14)
                        : null,
                borderRadius: BorderRadius.circular(10),
                border: _isToday(day)
                    ? Border.all(
                        color: AppColors.primary2.withValues(alpha: 0.45))
                    : null,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: disabled
                        ? AppColors.muteIconColor
                        : selected || isStart || isEnd
                            ? AppColors.white
                            : isOtherMonth
                                ? AppColors.black2
                                : AppColors.black1,
                    fontWeight: selected || isStart || isEnd
                        ? FontWeight.w700
                        : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMonthsGrid(ThemeData theme) {
    return GridView.builder(
      itemCount: _monthShort.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.1,
      ),
      itemBuilder: (BuildContext context, int index) {
        final bool active = _viewDate.month == index + 1;
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            setState(() {
              _viewDate = DateTime(_viewDate.year, index + 1, 1);
              _viewMode = _CalendarViewMode.days;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: active ? AppColors.primary2.withValues(alpha: 0.18) : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                _monthShort[index],
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.black1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildYearsGrid(ThemeData theme) {
    final List<int> years = _visibleYears;
    return GridView.builder(
      itemCount: years.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final int year = years[index];
        final bool active = _viewDate.year == year;
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            setState(() {
              _viewDate = DateTime(year, _viewDate.month, 1);
              _viewMode = _CalendarViewMode.months;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: active ? AppColors.primary2.withValues(alpha: 0.18) : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$year',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.black1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter(ThemeData theme) {
    final bool canClear =
        _single != null || _multiple.isNotEmpty || _rangeStart != null;
    return Row(
      children: [
        if (widget.showToday)
          OutlinedButton(
            onPressed: _goToday,
            child: const Text('Today'),
          ),
        const Spacer(),
        if (canClear)
          TextButton(
            onPressed: _clearSelection,
            child: Text(widget.clearLabel),
          ),
        if (widget.selectionType == CommonDatePickerSelectionType.multiple)
          const SizedBox(width: 8),
        if (widget.selectionType == CommonDatePickerSelectionType.multiple)
          ElevatedButton(
            onPressed: () {
              final List<DateTime> selected = _multiple.toList()
                ..sort((a, b) => a.compareTo(b));
              Navigator.of(context).pop(
                _CalendarDialogResult(multipleDates: selected),
              );
            },
            child: Text(widget.applyLabel),
          ),
      ],
    );
  }

  void _navigate(int direction) {
    setState(() {
      switch (_viewMode) {
        case _CalendarViewMode.days:
          _viewDate = DateTime(_viewDate.year, _viewDate.month + direction, 1);
          break;
        case _CalendarViewMode.months:
          _viewDate = DateTime(_viewDate.year + direction, _viewDate.month, 1);
          break;
        case _CalendarViewMode.years:
          _viewDate =
              DateTime(_viewDate.year + (direction * 12), _viewDate.month, 1);
          break;
      }
    });
  }

  void _onSelectDay(DateTime day) {
    switch (widget.selectionType) {
      case CommonDatePickerSelectionType.single:
        Navigator.of(context).pop(_CalendarDialogResult(singleDate: day));
        break;
      case CommonDatePickerSelectionType.multiple:
        setState(() {
          if (_multiple.contains(day)) {
            _multiple.remove(day);
            return;
          }
          if (widget.maxSelectionCount != null &&
              _multiple.length >= widget.maxSelectionCount!) {
            final messenger = ScaffoldMessenger.maybeOf(context);
            messenger?.hideCurrentSnackBar();
            messenger?.showSnackBar(
              SnackBar(
                content:
                    Text('Max ${widget.maxSelectionCount} dates are allowed.'),
                duration: const Duration(seconds: 2),
              ),
            );
            return;
          }
          _multiple.add(day);
        });
        break;
      case CommonDatePickerSelectionType.range:
        if (_rangeStart == null || _rangeEnd != null) {
          setState(() {
            _rangeStart = day;
            _rangeEnd = null;
          });
          return;
        }

        final DateTime start = day.isBefore(_rangeStart!) ? day : _rangeStart!;
        final DateTime end = day.isBefore(_rangeStart!) ? _rangeStart! : day;
        setState(() {
          _rangeStart = start;
          _rangeEnd = end;
        });
        Navigator.of(context).pop(
          _CalendarDialogResult(range: DateTimeRange(start: start, end: end)),
        );
        break;
    }
  }

  void _goToday() {
    final DateTime today = _stripDate(DateTime.now());
    if (_isDisabled(today)) {
      return;
    }
    if (widget.selectionType == CommonDatePickerSelectionType.single) {
      Navigator.of(context).pop(_CalendarDialogResult(singleDate: today));
      return;
    }

    setState(() {
      _viewDate = DateTime(today.year, today.month, 1);
      _viewMode = _CalendarViewMode.days;
    });
  }

  void _clearSelection() {
    setState(() {
      _single = null;
      _multiple.clear();
      _rangeStart = null;
      _rangeEnd = null;
    });

    Navigator.of(context).pop(const _CalendarDialogResult(cleared: true));
  }

  List<String> get _orderedWeekDays {
    if (_normalizedFirstDayOfWeek == 1) {
      return <String>[..._weekDayNames.sublist(1), _weekDayNames.first];
    }
    return _weekDayNames;
  }

  List<DateTime> get _visibleDays {
    final DateTime firstDay = DateTime(_viewDate.year, _viewDate.month, 1);
    final DateTime lastDay = DateTime(_viewDate.year, _viewDate.month + 1, 0);

    int startWeekDay = firstDay.weekday % 7;
    if (_normalizedFirstDayOfWeek == 1) {
      startWeekDay = (startWeekDay + 6) % 7;
    }

    final List<DateTime> days = <DateTime>[];
    for (int i = startWeekDay - 1; i >= 0; i--) {
      days.add(DateTime(_viewDate.year, _viewDate.month, -i));
    }
    for (int day = 1; day <= lastDay.day; day++) {
      days.add(DateTime(_viewDate.year, _viewDate.month, day));
    }
    final int remaining = 42 - days.length;
    for (int i = 1; i <= remaining; i++) {
      days.add(DateTime(_viewDate.year, _viewDate.month + 1, i));
    }
    return days;
  }

  List<int> get _visibleYears {
    final int baseYear = (_viewDate.year ~/ 12) * 12;
    return List<int>.generate(12, (int index) => baseYear + index);
  }

  bool _isSelected(DateTime day) {
    switch (widget.selectionType) {
      case CommonDatePickerSelectionType.single:
        return _single != null && _sameDay(_single!, day);
      case CommonDatePickerSelectionType.multiple:
        return _multiple.contains(day);
      case CommonDatePickerSelectionType.range:
        return (_rangeStart != null && _sameDay(_rangeStart!, day)) ||
            (_rangeEnd != null && _sameDay(_rangeEnd!, day));
    }
  }

  bool _isInRange(DateTime day) {
    if (widget.selectionType != CommonDatePickerSelectionType.range ||
        _rangeStart == null) {
      return false;
    }

    DateTime? end = _rangeEnd;
    DateTime start = _rangeStart!;
    if (end == null && _hoverDate != null) {
      if (_hoverDate!.isBefore(start)) {
        end = start;
        start = _hoverDate!;
      } else {
        end = _hoverDate;
      }
    }

    if (end == null) {
      return false;
    }

    return day.isAfter(start) && day.isBefore(end);
  }

  bool _isToday(DateTime day) {
    return _sameDay(day, _stripDate(DateTime.now()));
  }

  bool _isDisabled(DateTime day) {
    final DateTime minDate = _stripDate(widget.minDate);
    final DateTime maxDate = _stripDate(widget.maxDate);
    return day.isBefore(minDate) || day.isAfter(maxDate);
  }

  DateTime _stripDate(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  bool _sameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int get _normalizedFirstDayOfWeek {
    return widget.firstDayOfWeek == 0 ? 0 : 1;
  }
}

class _PatternDateTextInputFormatter extends TextInputFormatter {
  _PatternDateTextInputFormatter({
    required this.pattern,
    required this.includeTime,
  }) : _effectivePattern = _buildEffectivePattern(pattern, includeTime);

  final String pattern;
  final bool includeTime;
  final String _effectivePattern;

  static String _buildEffectivePattern(String pattern, bool includeTime) {
    if (!includeTime || pattern.contains('HH:mm')) {
      return pattern;
    }
    return '$pattern HH:mm';
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final bool suppressTrailingLiteral = _didDeleteLiteralCharacter(
      oldValue,
      newValue,
    );
    final String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.isEmpty) {
      return const TextEditingValue(text: '');
    }

    final List<_PatternChunk> chunks = _buildChunks(_effectivePattern);
    final String formatted = _applyChunks(
      digitsOnly: digitsOnly,
      chunks: chunks,
      suppressTrailingLiteral: suppressTrailingLiteral,
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  List<_PatternChunk> _buildChunks(String pattern) {
    final List<_PatternChunk> chunks = <_PatternChunk>[];
    final RegExp tokenChar = RegExp(r'[dMyHm]');

    int i = 0;
    while (i < pattern.length) {
      final bool isToken = tokenChar.hasMatch(pattern[i]);
      final StringBuffer buffer = StringBuffer();
      while (i < pattern.length && tokenChar.hasMatch(pattern[i]) == isToken) {
        buffer.write(pattern[i]);
        i++;
      }

      final String chunkValue = buffer.toString();
      if (isToken) {
        chunks.add(_PatternChunk.token(chunkValue.length));
      } else {
        chunks.add(_PatternChunk.literal(chunkValue));
      }
    }

    return chunks;
  }

  String _applyChunks({
    required String digitsOnly,
    required List<_PatternChunk> chunks,
    required bool suppressTrailingLiteral,
  }) {
    final StringBuffer output = StringBuffer();
    int digitIndex = 0;

    for (int i = 0; i < chunks.length; i++) {
      final _PatternChunk chunk = chunks[i];
      if (chunk.isToken) {
        final int remaining = digitsOnly.length - digitIndex;
        if (remaining <= 0) {
          break;
        }

        final int takeCount =
            remaining < chunk.length ? remaining : chunk.length;
        output.write(digitsOnly.substring(digitIndex, digitIndex + takeCount));
        digitIndex += takeCount;

        if (takeCount == chunk.length && i + 1 < chunks.length) {
          final _PatternChunk nextChunk = chunks[i + 1];
          final bool atEndOfInputDigits = digitIndex == digitsOnly.length;
          if (!nextChunk.isToken &&
              nextChunk.literalValue != null &&
              !(suppressTrailingLiteral && atEndOfInputDigits)) {
            output.write(nextChunk.literalValue);
            i++;
          }
        }
      }
    }

    return output.toString();
  }

  bool _didDeleteLiteralCharacter(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final bool isDeleting = newValue.text.length < oldValue.text.length;
    if (!isDeleting || !oldValue.selection.isCollapsed) {
      return false;
    }

    final int deleteCount = oldValue.text.length - newValue.text.length;
    if (deleteCount <= 0) {
      return false;
    }

    final int deleteStart = oldValue.selection.baseOffset - deleteCount;
    if (deleteStart < 0 || deleteStart + deleteCount > oldValue.text.length) {
      return false;
    }

    final String deletedText = oldValue.text.substring(
      deleteStart,
      deleteStart + deleteCount,
    );
    return RegExp(r'\D').hasMatch(deletedText);
  }
}

class _PatternChunk {
  _PatternChunk.token(this.length)
      : isToken = true,
        literalValue = null;

  _PatternChunk.literal(String value)
      : isToken = false,
        literalValue = value,
        length = 0;

  final bool isToken;
  final int length;
  final String? literalValue;
}
