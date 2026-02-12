part of '../forms.dart';

class ReactiveDateTimePicker extends StatefulWidget {
  const ReactiveDateTimePicker({
    required this.formControlName,
    this.label,
    super.key,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.firstDate,
    this.lastDate,
    this.format,
    this.inputType = InputType.date,
    this.selectableDayPredicate,
  });

  final String? label;
  final String formControlName;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat? format;
  final InputType inputType;
  final bool Function(DateTime)? selectableDayPredicate;

  @override
  State<ReactiveDateTimePicker> createState() => _ReactiveDateTimePickerState();
}

class _ReactiveDateTimePickerState extends State<ReactiveDateTimePicker> {
  DateFormat _getDefaultDateTimeFormat() {
    return switch (widget.inputType) {
      InputType.time => DateFormat.Hm(),
      InputType.date => DateFormat('dd/MM/yyyy'),
      InputType.both => DateFormat('dd/MM/yyyy HH:mm'),
    };
  }

  Future<DateTime?> _showCustomDatePicker(DateTime? currentValue) {
    return showDialog<DateTime>(
      context: context,
      builder: (context) => _CustomDatePickerDialog(
        initialDate: currentValue ?? DateTime.now(),
        firstDate: widget.firstDate ?? DateTime(2000),
        lastDate: widget.lastDate ?? DateTime(2100),
        selectableDayPredicate: widget.selectableDayPredicate,
      ),
    );
  }

  Future<DateTime?> _showDatePicker(DateTime? currentValue) {
    // Use custom picker for better UI
    return _showCustomDatePicker(currentValue);
  }

  Future<TimeOfDay?> _showTimePicker(DateTime? currentValue) {
    return showTimePicker(
      context: context,
      initialTime: currentValue != null
          ? TimeOfDay.fromDateTime(currentValue)
          : const TimeOfDay(hour: 12, minute: 0),
    );
  }

  DateTime combine(DateTime date, TimeOfDay? time) => DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? 0,
        time?.minute ?? 0,
      );

  DateTime? convert(TimeOfDay? time) =>
      time == null ? null : DateTime(1, 1, 1, time.hour, time.minute);

  Future<DateTime?> onShowPicker(DateTime? currentValue) async {
    DateTime? newValue;
    switch (widget.inputType) {
      case InputType.date:
        newValue = await _showDatePicker(currentValue);
      case InputType.time:
        if (!context.mounted) break;
        newValue = convert(await _showTimePicker(currentValue));
      case InputType.both:
        if (!context.mounted) break;
        final date = await _showDatePicker(currentValue);
        if (date != null) {
          if (!mounted) break;
          final time = await _showTimePicker(currentValue);
          if (time == null) {
            newValue = null;
          } else {
            newValue = combine(date, time);
          }
        }
    }
    return newValue;
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveDatePicker(
      formControlName: widget.formControlName,
      keyboardType: widget.keyboardType,
      builder: (context, delegate, child) {
        final isRequired = delegate.control.validators
            .any((validator) => validator is RequiredValidator);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            if (widget.label != null) ...[
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: widget.label),
                    if (isRequired)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ],
            InkWell(
              onTap: () async {
                final date = await onShowPicker(delegate.value);
                if (date != null) {
                  delegate.control.value = date;
                }
              },
              child: InputDecorator(
                decoration: widget.decoration.copyWith(
                  errorText: delegate.control.touched &&
                          delegate.control.errors.isNotEmpty
                      ? delegate.control.errors.entries.firstOrNull?.key
                      : null,
                  suffixIcon: delegate.value != null
                      ? IconButton(
                          onPressed: () {
                            delegate.control.value = null;
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : widget.decoration.suffixIcon,
                ),
                child: delegate.value != null
                    ? Text(
                        widget.format != null
                            ? widget.format!.format(delegate.value!)
                            : _getDefaultDateTimeFormat()
                                .format(delegate.value!),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        );
      },
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
    );
  }
}

class _CustomDatePickerDialog extends StatefulWidget {
  const _CustomDatePickerDialog({
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.selectableDayPredicate,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool Function(DateTime)? selectableDayPredicate;

  @override
  State<_CustomDatePickerDialog> createState() =>
      _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<_CustomDatePickerDialog> {
  late DateTime _displayedMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month + 1);
    });
  }

  List<DateTime?> _getDaysInMonth() {
    final firstDayOfMonth =
        DateTime(_displayedMonth.year, _displayedMonth.month);
    final lastDayOfMonth =
        DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;

    // Get the weekday of the first day (1 = Monday, 7 = Sunday)
    final firstWeekday = firstDayOfMonth.weekday;

    // Calculate leading empty cells
    final leadingEmptyCells = firstWeekday - 1;

    // Create the list with nulls for empty cells
    final days = <DateTime?>[];
    for (var i = 0; i < leadingEmptyCells; i++) {
      days.add(null);
    }

    // Add actual days
    for (var i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_displayedMonth.year, _displayedMonth.month, i));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _previousMonth,
                  icon: const Icon(Icons.chevron_left),
                ),
                Row(
                  children: [
                    // Month dropdown
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: DropdownButton<int>(
                          value: _displayedMonth.month,
                          underline: const SizedBox(),
                          style: theme.textTheme.titleSmall,
                          items: List.generate(12, (index) {
                            final month = index + 1;
                            return DropdownMenuItem(
                              value: month,
                              child: Text(
                                DateFormat.MMMM().format(DateTime(2000, month)),
                              ),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _displayedMonth =
                                    DateTime(_displayedMonth.year, value);
                              });
                            }
                          },
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Year dropdown
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<int>(
                          value: _displayedMonth.year,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: theme.textTheme.titleSmall,
                          items: List.generate(
                            widget.lastDate.year - widget.firstDate.year + 1,
                            (index) {
                              final year = widget.firstDate.year + index;
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year.toString()),
                              );
                            },
                          ),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _displayedMonth =
                                    DateTime(value, _displayedMonth.month);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: _nextMonth,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Weekday headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU']
                  .map(
                    (day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),

            // Calendar grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: _getDaysInMonth().length,
              itemBuilder: (context, index) {
                final day = _getDaysInMonth()[index];

                // Always show container, even for empty cells
                if (day == null) {
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }

                final isSelected = day.year == _selectedDate.year &&
                    day.month == _selectedDate.month &&
                    day.day == _selectedDate.day;

                final isToday = day.year == DateTime.now().year &&
                    day.month == DateTime.now().month &&
                    day.day == DateTime.now().day;

                final isSelectable =
                    widget.selectableDayPredicate?.call(day) ?? true;
                final isOutOfRange = day.isBefore(widget.firstDate) ||
                    day.isAfter(widget.lastDate);
                final isDisabled = !isSelectable || isOutOfRange;

                return InkWell(
                  onTap: isDisabled
                      ? null
                      : () {
                          setState(() {
                            _selectedDate = day;
                          });
                          Navigator.of(context).pop(_selectedDate);
                        },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? AppColors.white : Colors.black)
                          : (isDark ? AppColors.white : AppColors.white),
                      border: isToday && !isSelected ? Border.all() : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDisabled
                              ? theme.colorScheme.onSurface.withOpacity(0.3)
                              : isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurface,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
