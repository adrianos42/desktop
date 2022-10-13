import 'dart:math' as math;

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../icons.dart';
import '../../input/button.dart';
import '../../localizations.dart';
import '../../theme/theme.dart';
import 'date_utlis.dart';
import 'month_picker.dart';
import 'year_picker.dart';

const double _kBoxSize = 40.0;
const double _kDefaultCalendarSpacing = 8.0;
const double _KDefaultHeight = 320.0 + _kDefaultCalendarSpacing * 2;

const int _yearPickerColumnCount = 3;
const int _yearPickerRowCount = 6;
const int _minYears = _yearPickerColumnCount * _yearPickerRowCount;

DateTime _dateOnly(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}

enum DatePickerMode {
  /// Choosing a month and day.
  day,

  /// Choosing a year.
  year,
}

///
class CalendarDate extends StatefulWidget {
  ///
  CalendarDate({
    super.key,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required this.onDateChanged,
    DateTime? currentDate,
    this.selectableDayPredicate,
    this.onDisplayedMonthChanged,
    this.initialCalendarMode = DatePickerMode.day,
    this.onDateSelected,
  })  : initialDate = _dateOnly(initialDate),
        firstDate = _dateOnly(firstDate),
        lastDate = _dateOnly(lastDate),
        currentDate = _dateOnly(currentDate ?? DateTime.now());

  /// The initially selected [DateTime].
  final DateTime initialDate;

  /// The earliest allowable [DateTime].
  final DateTime firstDate;

  /// The latest allowable [DateTime].
  final DateTime lastDate;

  /// The [DateTime] representing today.
  final DateTime currentDate;

  ///
  final ValueChanged<DateTime>? onDisplayedMonthChanged;

  /// Called when the user selects a date in the picker.
  final ValueChanged<DateTime> onDateChanged;

  /// Called when the user selects a date in the picker.
  final ValueChanged<DateTime>? onDateSelected;

  /// Optional supplied predicate function to customize selectable days.
  final SelectableDayPredicate? selectableDayPredicate;

  /// The initial display of the calendar picker.
  final DatePickerMode initialCalendarMode;

  @override
  _CalendarDateState createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {
  bool _announcedInitialDate = false;
  late DateTime _currentDisplayedMonthDate;
  late DateTime _selectedDate;
  final GlobalKey<MonthPickerState> _monthPickerKey =
      GlobalKey<MonthPickerState>();
  final GlobalKey<YearPickerState> _yearPickerKey =
      GlobalKey<YearPickerState>();
  late TextDirection _textDirection;
  late DesktopLocalizations _localizations;
  late DatePickerMode _mode;
  int? _currentPageYear;

  @override
  void initState() {
    super.initState();
    _currentDisplayedMonthDate =
        DateTime(widget.initialDate.year, widget.initialDate.month);
    _selectedDate = widget.initialDate;
    _mode = widget.initialCalendarMode;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(CalendarDate oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialCalendarMode != oldWidget.initialCalendarMode) {
      _mode = widget.initialCalendarMode;
    }

    if (!DateUtils.isSameDay(widget.initialDate, oldWidget.initialDate)) {
      _currentDisplayedMonthDate =
          DateTime(widget.initialDate.year, widget.initialDate.month);
      _selectedDate = widget.initialDate;
    }

    if (oldWidget.firstDate != widget.firstDate ||
        oldWidget.lastDate != widget.lastDate) {
      _currentPageYear = _pageYear(_selectedDate);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = DesktopLocalizations.of(context);
    _textDirection = Directionality.of(context);
    if (!_announcedInitialDate) {
      _announcedInitialDate = true;
      SemanticsService.announce(
        _localizations.formatFullDate(_selectedDate),
        _textDirection,
      );
    }
  }

  void _handleModeChanged(DatePickerMode mode) {
    _vibrate();
    setState(() {
      _mode = mode;
      if (_mode == DatePickerMode.day) {
        _currentPageYear = null;
        SemanticsService.announce(
          _localizations.formatMonthYear(_selectedDate),
          _textDirection,
        );
      } else {
        _currentPageYear = _pageYear(_selectedDate);
        SemanticsService.announce(
          _localizations.formatYear(_selectedDate),
          _textDirection,
        );
      }
    });
  }

  void _vibrate() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        HapticFeedback.lightImpact();
        break;
      default:
        break;
    }
  }

  void _handleDayChanged(DateTime value) {
    _vibrate();
    setState(() {
      _selectedDate = value;
      widget.onDateChanged(_selectedDate);
    });
  }

  void _handleMonthChanged(DateTime date) {
    setState(() {
      if (_currentDisplayedMonthDate.year != date.year ||
          _currentDisplayedMonthDate.month != date.month) {
        _currentDisplayedMonthDate = DateTime(date.year, date.month);
        widget.onDisplayedMonthChanged?.call(_currentDisplayedMonthDate);
      }
    });
  }

  void _handleYearChanged(DateTime value) {
    _vibrate();

    if (value.isBefore(widget.firstDate)) {
      value = widget.firstDate;
    } else if (value.isAfter(widget.lastDate)) {
      value = widget.lastDate;
    }

    setState(() {
      _mode = DatePickerMode.day;
      _handleMonthChanged(value);
    });
  }

  bool get _isDisplayingFirstButOneMonth {
    return !_currentDisplayedMonthDate.isAfter(
      DateTime(widget.firstDate.year, widget.firstDate.month + 1),
    );
  }

  bool get _isDisplayingLastButOneMonth {
    return !_currentDisplayedMonthDate.isBefore(
      DateTime(widget.lastDate.year, widget.lastDate.month - 1),
    );
  }

  bool get _isDisplayingFirstMonth {
    return !_currentDisplayedMonthDate.isAfter(
      DateTime(widget.firstDate.year, widget.firstDate.month),
    );
  }

  bool get _isDisplayingLastMonth {
    return !_currentDisplayedMonthDate.isBefore(
      DateTime(widget.lastDate.year, widget.lastDate.month),
    );
  }

  int _pageYear(DateTime date) {
    final int initialYearIndex = date.year - widget.firstDate.year;
    return initialYearIndex ~/ _minYears;
  }

  int get _yearCount => widget.lastDate.year - widget.firstDate.year + 1;

  bool get _isDisplayingFirstYear {
    return _currentPageYear! == 0;
  }

  bool get _isDisplayingLastYear {
    final int pageCount = (math.max(_yearCount, _minYears) / _minYears).ceil();
    return _currentPageYear == pageCount - 1;
  }

  void _onDisplayedYearPageChanged(int index) {
    setState(() {
      _currentPageYear = index;
    });
  }

  VoidCallback? _handleNext() {
    switch (_mode) {
      case DatePickerMode.day:
        return !_isDisplayingLastMonth
            ? () => _monthPickerKey.currentState!.handleNextMonth()
            : null;
      case DatePickerMode.year:
        return !_isDisplayingLastYear
            ? () => _yearPickerKey.currentState!.handleNextYear()
            : null;
    }
  }

  VoidCallback? _handlePrevious() {
    switch (_mode) {
      case DatePickerMode.day:
        return !_isDisplayingFirstMonth
            ? () => _monthPickerKey.currentState!.handlePreviousMonth()
            : null;
      case DatePickerMode.year:
        return !_isDisplayingFirstYear
            ? () => _yearPickerKey.currentState!.handlePreviousYear()
            : null;
    }
  }

  Widget _buildPicker() {
    switch (_mode) {
      case DatePickerMode.day:
        return MonthPicker(
          key: _monthPickerKey,
          initialMonth: _currentDisplayedMonthDate,
          currentDate: widget.currentDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          selectedDate: _selectedDate,
          onChanged: _handleDayChanged,
          onDisplayedMonthChanged: _handleMonthChanged,
          onModeChanged: () => _handleModeChanged(DatePickerMode.year),
          selectableDayPredicate: widget.selectableDayPredicate,
        );
      case DatePickerMode.year:
        return YearPicker(
          key: _yearPickerKey,
          currentDate: widget.currentDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          initialDate: _currentDisplayedMonthDate,
          selectedDate: _selectedDate,
          onChanged: _handleYearChanged,
          onDisplayedYearPageChanged: _onDisplayedYearPageChanged,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    final ButtonThemeData buttonThemeData = ButtonTheme.of(context).copyWith(
      color: colorScheme.shade[100],
      axis: Axis.vertical,
      hoverColor: colorScheme.background[0],
      highlightColor: colorScheme.primary[70],
      disabledColor: colorScheme.shade[50],
    );

    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints.tightFor(height: _KDefaultHeight),
      child: Row(
        children: [
          Expanded(child: _buildPicker()),
          Container(
            width: _kBoxSize,
            padding: EdgeInsets.symmetric(
              vertical: buttonThemeData.itemSpacing! * 2.0,
            ),
            color: colorScheme.primary[30],
            child: ButtonTheme.merge(
              data: buttonThemeData,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button.icon(
                    Icons.arrow_upward,
                    onPressed: _handlePrevious(),
                    willChangeState: _isDisplayingFirstButOneMonth,
                  ),
                  Button.icon(
                    Icons.arrow_downward,
                    willChangeState: _isDisplayingLastButOneMonth,
                    onPressed: _handleNext(),
                  ),
                  const Spacer(),
                  if (widget.onDateSelected != null)
                    Button.icon(
                      Icons.done,
                      onPressed: () => widget.onDateSelected!(_selectedDate),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
