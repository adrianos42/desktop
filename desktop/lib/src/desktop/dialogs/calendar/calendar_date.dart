import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../icons.dart';
import '../../input/button.dart';
import '../../localizations.dart';
import '../../theme/theme.dart';
import 'days_month.dart';

const double _kBoxSize = 40.0;
//const double _KDefaultHeight = 344.0;
const double _KDefaultHeight = 320.0;
const Duration _monthScrollDuration = Duration(milliseconds: 120);
const Curve _monthScrollCurve = Curves.easeInSine;

const int _maxDayPickerRowCount = 6;
const int _yearPickerColumnCount = 3;
const double _yearPickerPadding = 16.0;
const double _yearPickerRowHeight = 52.0;
const double _yearPickerRowSpacing = 8.0;

const double _monthNavButtonsWidth = 108.0;

DateTime _dateOnly(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}

@immutable
class _DateTimeRange {
  _DateTimeRange({
    required this.start,
    required this.end,
  }) : assert(!start.isAfter(end));

  final DateTime start;

  final DateTime end;

  Duration get duration => end.difference(start);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _DateTimeRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => Object.hash(start, end);

  @override
  String toString() => '$start - $end';
}

class _DateUtils {
  _DateUtils._();

  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static _DateTimeRange datesOnly(_DateTimeRange range) {
    return _DateTimeRange(
        start: dateOnly(range.start), end: dateOnly(range.end));
  }

  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
  }

  static bool isSameMonth(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year && dateA?.month == dateB?.month;
  }

  static int monthDelta(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 +
        endDate.month -
        startDate.month;
  }

  static DateTime addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) {
    return DateTime(monthDate.year, monthDate.month + monthsToAdd);
  }

  static DateTime addDaysToDate(DateTime date, int days) {
    return DateTime(date.year, date.month, date.day + days);
  }

  static int firstDayOffset(
      int year, int month, DesktopLocalizations localizations) {
    // 0-based day of week for the month and year, with 0 representing Monday.
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;

    // 0-based start of week depending on the locale, with 0 representing Sunday.
    int firstDayOfWeekIndex = localizations.firstDayOfWeekIndex;

    // firstDayOfWeekIndex recomputed to be Monday-based, in order to compare with
    // weekdayFromMonday.
    firstDayOfWeekIndex = (firstDayOfWeekIndex - 1) % 7;

    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the first of the month.
    return (weekdayFromMonday - firstDayOfWeekIndex) % 7;
  }

  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }
}

///
typedef SelectableDayPredicate = bool Function(DateTime day);

class CalendarDate extends StatefulWidget {
  ///
  CalendarDate({
    super.key,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required this.onDateChanged,
    DateTime? currentDate,
    this.restorationId,
    this.selectableDayPredicate,
    this.onDisplayedMonthChanged,
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

  /// Optional supplied predicate function to customize selectable days.
  final SelectableDayPredicate? selectableDayPredicate;

  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  final String? restorationId;

  @override
  _CalendarDateState createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {
  bool _announcedInitialDate = false;
  late DateTime _currentDisplayedMonthDate;
  late DateTime _selectedDate;
  final GlobalKey _monthPickerKey = GlobalKey();
  final GlobalKey _yearPickerKey = GlobalKey();
  late TextDirection _textDirection;
  late DesktopLocalizations _localizations;

  @override
  void initState() {
    super.initState();
    _currentDisplayedMonthDate =
        DateTime(widget.initialDate.year, widget.initialDate.month);
    _selectedDate = widget.initialDate;
  }

  @override
  void didUpdateWidget(CalendarDate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_DateUtils.isSameDay(widget.initialDate, oldWidget.initialDate)) {
      _currentDisplayedMonthDate =
          DateTime(widget.initialDate.year, widget.initialDate.month);
      _selectedDate = widget.initialDate;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints.tightFor(height: _KDefaultHeight),
      color: Theme.of(context).colorScheme.background[0],
      child: _MonthPicker(
        key: _monthPickerKey,
        initialMonth: _currentDisplayedMonthDate,
        currentDate: widget.currentDate,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        selectedDate: _selectedDate,
        onChanged: _handleDayChanged,
        onDisplayedMonthChanged: _handleMonthChanged,
        selectableDayPredicate: widget.selectableDayPredicate,
      ),
    );
  }
}

class _MonthPicker extends StatefulWidget {
  _MonthPicker({
    super.key,
    required this.initialMonth,
    required this.currentDate,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onChanged,
    required this.onDisplayedMonthChanged,
    this.selectableDayPredicate,
  })  : assert(!firstDate.isAfter(lastDate)),
        assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate));

  final DateTime initialMonth;

  final DateTime currentDate;

  final DateTime firstDate;

  final DateTime lastDate;

  final DateTime selectedDate;

  final ValueChanged<DateTime> onChanged;

  final ValueChanged<DateTime> onDisplayedMonthChanged;

  final SelectableDayPredicate? selectableDayPredicate;

  @override
  _MonthPickerState createState() => _MonthPickerState();
}

class _MonthPickerState extends State<_MonthPicker> {
  final GlobalKey _pageViewKey = GlobalKey();
  late DateTime _currentMonth;
  late PageController _pageController;
  late DesktopLocalizations _localizations;
  late TextDirection _textDirection;
  Map<ShortcutActivator, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  late FocusNode _dayGridFocus;
  DateTime? _focusedDay;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialMonth;
    _pageController = PageController(
        initialPage: _DateUtils.monthDelta(widget.firstDate, _currentMonth));
    _shortcutMap = const <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.arrowLeft):
          DirectionalFocusIntent(TraversalDirection.left),
      SingleActivator(LogicalKeyboardKey.arrowRight):
          DirectionalFocusIntent(TraversalDirection.right),
      SingleActivator(LogicalKeyboardKey.arrowDown):
          DirectionalFocusIntent(TraversalDirection.down),
      SingleActivator(LogicalKeyboardKey.arrowUp):
          DirectionalFocusIntent(TraversalDirection.up),
    };
    _actionMap = <Type, Action<Intent>>{
      NextFocusIntent:
          CallbackAction<NextFocusIntent>(onInvoke: _handleGridNextFocus),
      PreviousFocusIntent: CallbackAction<PreviousFocusIntent>(
          onInvoke: _handleGridPreviousFocus),
      DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(
          onInvoke: _handleDirectionFocus),
    };
    _dayGridFocus = FocusNode(debugLabel: 'Day Grid');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = DesktopLocalizations.of(context);
    _textDirection = Directionality.of(context);
  }

  @override
  void didUpdateWidget(_MonthPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialMonth != oldWidget.initialMonth &&
        widget.initialMonth != _currentMonth) {
      WidgetsBinding.instance.addPostFrameCallback(
        (Duration timeStamp) => _showMonth(widget.initialMonth, jump: true),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _dayGridFocus.dispose();
    super.dispose();
  }

  void _handleDateSelected(DateTime selectedDate) {
    _focusedDay = selectedDate;
    widget.onChanged(selectedDate);
  }

  void _handleMonthPageChanged(int monthPage) {
    setState(() {
      final DateTime monthDate =
          _DateUtils.addMonthsToMonthDate(widget.firstDate, monthPage);
      if (!_DateUtils.isSameMonth(_currentMonth, monthDate)) {
        _currentMonth = DateTime(monthDate.year, monthDate.month);
        widget.onDisplayedMonthChanged(_currentMonth);
        if (_focusedDay != null &&
            !_DateUtils.isSameMonth(_focusedDay, _currentMonth)) {
          _focusedDay = _focusableDayForMonth(_currentMonth, _focusedDay!.day);
        }
        SemanticsService.announce(
          _localizations.formatMonthYear(_currentMonth),
          _textDirection,
        );
      }
    });
  }

  DateTime? _focusableDayForMonth(DateTime month, int preferredDay) {
    final int daysInMonth = _DateUtils.getDaysInMonth(month.year, month.month);

    if (preferredDay <= daysInMonth) {
      final DateTime newFocus = DateTime(month.year, month.month, preferredDay);
      if (_isSelectable(newFocus)) {
        return newFocus;
      }
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final DateTime newFocus = DateTime(month.year, month.month, day);
      if (_isSelectable(newFocus)) {
        return newFocus;
      }
    }
    return null;
  }

  void _handleNextMonth() {
    _pageController.nextPage(
      duration: _monthScrollDuration,
      curve: _monthScrollCurve,
    );
  }

  void _handlePreviousMonth() {
    _pageController.previousPage(
      duration: _monthScrollDuration,
      curve: _monthScrollCurve,
    );
  }

  void _showMonth(DateTime month, {bool jump = false}) {
    final int monthPage = _DateUtils.monthDelta(widget.firstDate, month);
    if (jump) {
      _pageController.jumpToPage(monthPage);
    } else {
      _pageController.animateToPage(
        monthPage,
        duration: _monthScrollDuration,
        curve: _monthScrollCurve,
      );
    }
  }

  bool get _isDisplayingFirstMonth {
    return !_currentMonth.isAfter(
      DateTime(widget.firstDate.year, widget.firstDate.month),
    );
  }

  bool get _isDisplayingLastMonth {
    return !_currentMonth.isBefore(
      DateTime(widget.lastDate.year, widget.lastDate.month),
    );
  }

  bool get _isDisplayingFirstButOneMonth {
    return !_currentMonth.isAfter(
      DateTime(widget.firstDate.year, widget.firstDate.month + 1),
    );
  }

  bool get _isDisplayingLastButOneMonth {
    return !_currentMonth.isBefore(
      DateTime(widget.lastDate.year, widget.lastDate.month - 1),
    );
  }

  void _handleGridFocusChange(bool focused) {
    setState(() {
      if (focused && _focusedDay == null) {
        if (_DateUtils.isSameMonth(widget.selectedDate, _currentMonth)) {
          _focusedDay = widget.selectedDate;
        } else if (_DateUtils.isSameMonth(widget.currentDate, _currentMonth)) {
          _focusedDay =
              _focusableDayForMonth(_currentMonth, widget.currentDate.day);
        } else {
          _focusedDay = _focusableDayForMonth(_currentMonth, 1);
        }
      }
    });
  }

  void _handleGridNextFocus(NextFocusIntent intent) {
    _dayGridFocus.requestFocus();
    _dayGridFocus.nextFocus();
  }

  void _handleGridPreviousFocus(PreviousFocusIntent intent) {
    _dayGridFocus.requestFocus();
    _dayGridFocus.previousFocus();
  }

  void _handleDirectionFocus(DirectionalFocusIntent intent) {
    assert(_focusedDay != null);
    setState(() {
      final DateTime? nextDate =
          _nextDateInDirection(_focusedDay!, intent.direction);
      if (nextDate != null) {
        _focusedDay = nextDate;
        if (!_DateUtils.isSameMonth(_focusedDay, _currentMonth)) {
          _showMonth(_focusedDay!);
        }
      }
    });
  }

  static const Map<TraversalDirection, int> _directionOffset =
      <TraversalDirection, int>{
    TraversalDirection.left: -DateTime.daysPerWeek,
    TraversalDirection.down: 1,
    TraversalDirection.right: DateTime.daysPerWeek,
    TraversalDirection.up: -1,
  };

  int _dayDirectionOffset(
      TraversalDirection traversalDirection, TextDirection textDirection) {
    if (textDirection == TextDirection.rtl) {
      if (traversalDirection == TraversalDirection.left) {
        traversalDirection = TraversalDirection.right;
      } else if (traversalDirection == TraversalDirection.right) {
        traversalDirection = TraversalDirection.left;
      }
    }
    return _directionOffset[traversalDirection]!;
  }

  DateTime? _nextDateInDirection(DateTime date, TraversalDirection direction) {
    final TextDirection textDirection = Directionality.of(context);
    DateTime nextDate = _DateUtils.addDaysToDate(
        date, _dayDirectionOffset(direction, textDirection));
    while (!nextDate.isBefore(widget.firstDate) &&
        !nextDate.isAfter(widget.lastDate)) {
      if (_isSelectable(nextDate)) {
        return nextDate;
      }
      nextDate = _DateUtils.addDaysToDate(
          nextDate, _dayDirectionOffset(direction, textDirection));
    }
    return null;
  }

  bool _isSelectable(DateTime date) {
    return widget.selectableDayPredicate == null ||
        widget.selectableDayPredicate!.call(date);
  }

  Widget _buildItems(BuildContext context, int index) {
    final DateTime month =
        _DateUtils.addMonthsToMonthDate(widget.firstDate, index);
    return _DayPicker(
      key: ValueKey<DateTime>(month),
      selectedDate: widget.selectedDate,
      currentDate: widget.currentDate,
      onChanged: _handleDateSelected,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      displayedMonth: month,
      selectableDayPredicate: widget.selectableDayPredicate,
    );
  }

  List<Widget> _dayHeaders(
      TextStyle? headerStyle, DesktopLocalizations localizations) {
    final List<Widget> result = <Widget>[];

    int i = localizations.firstDayOfWeekIndex;

    while (true) {
      final String weekday = localizations.narrowWeekdays[i];

      result.add(
        ExcludeSemantics(
          child: SizedBox(
            width: _kBoxSize,
            height: _kBoxSize,
            child: Center(
              child: Text(
                weekday,
                style: headerStyle,
              ),
            ),
          ),
        ),
      );

      if (i == (localizations.firstDayOfWeekIndex - 1) % 7) {
        break;
      }

      i = (i + 1) % 7;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final DesktopLocalizations localizations = DesktopLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;
    final TextStyle headerStyle = textTheme.body1.copyWith(
      color: textTheme.textPrimaryHigh,
    );
    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);

    ScrollPhysics? scrollPhysics;

    switch (defaultTargetPlatform) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
        scrollPhysics = const NeverScrollableScrollPhysics();
        break;
      default:
        break;
    }

    return Semantics(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _kBoxSize,
                    child: Align(
                      alignment: Alignment.center,
                      child: Button.text(
                        _localizations.formatMonthYear(_currentMonth),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _kBoxSize,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _dayHeaders(headerStyle, localizations),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: DateTime.daysPerWeek * _kBoxSize,
                      child: FocusableActionDetector(
                        shortcuts: _shortcutMap,
                        actions: _actionMap,
                        focusNode: _dayGridFocus,
                        onFocusChange: _handleGridFocusChange,
                        child: _FocusedDate(
                          date: _dayGridFocus.hasFocus ? _focusedDay : null,
                          child: PageView.builder(
                            key: _pageViewKey,
                            controller: _pageController,
                            physics: scrollPhysics,
                            itemBuilder: _buildItems,
                            scrollDirection: Axis.vertical,
                            itemCount: _DateUtils.monthDelta(
                                  widget.firstDate,
                                  widget.lastDate,
                                ) +
                                1,
                            onPageChanged: _handleMonthPageChanged,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: _kBoxSize,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            color: Theme.of(context).colorScheme.primary[30],
            child: ButtonTheme.copyWith(
              color: buttonThemeData.foreground,
              hoverColor: colorScheme.background[0],
              highlightColor: colorScheme.primary[70],
              disabledColor: colorScheme.shade[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button.icon(
                    Icons.expand_less,
                    style: ButtonThemeData(color: colorScheme.shade[100]),
                    onPressed:
                        _isDisplayingFirstMonth ? null : _handlePreviousMonth,
                    willChangeState: _isDisplayingFirstButOneMonth,
                  ),
                  Button.icon(
                    Icons.keyboard_arrow_down,
                    style: ButtonThemeData(color: colorScheme.shade[100]),
                    willChangeState: _isDisplayingLastButOneMonth,
                    onPressed: _isDisplayingLastMonth ? null : _handleNextMonth,
                  ),
                  const Spacer(),
                  Button.icon(
                    Icons.done,
                    style: ButtonThemeData(color: colorScheme.shade[100]),
                    onPressed: () {},
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

class _FocusedDate extends InheritedWidget {
  const _FocusedDate({
    required super.child,
    this.date,
  });

  final DateTime? date;

  @override
  bool updateShouldNotify(_FocusedDate oldWidget) {
    return !_DateUtils.isSameDay(date, oldWidget.date);
  }

  static DateTime? of(BuildContext context) {
    final _FocusedDate? focusedDate =
        context.dependOnInheritedWidgetOfExactType<_FocusedDate>();
    return focusedDate?.date;
  }
}

class _DayPicker extends StatefulWidget {
  _DayPicker({
    super.key,
    required this.currentDate,
    required this.displayedMonth,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onChanged,
    this.selectableDayPredicate,
  })  : assert(!firstDate.isAfter(lastDate)),
        assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate));

  /// The currently selected date.
  final DateTime selectedDate;

  /// The current date.
  final DateTime currentDate;

  /// Called when a day is selected.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date allowed.
  final DateTime firstDate;

  /// The latest date allowed.
  final DateTime lastDate;

  /// The current month.
  final DateTime displayedMonth;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate? selectableDayPredicate;

  @override
  _DayPickerState createState() => _DayPickerState();
}

class _DayPickerState extends State<_DayPicker> {
  late List<FocusNode> _dayFocusNodes;

  @override
  void initState() {
    super.initState();
    final int daysInMonth = _DateUtils.getDaysInMonth(
        widget.displayedMonth.year, widget.displayedMonth.month);
    _dayFocusNodes = List<FocusNode>.generate(
      daysInMonth,
      (int index) =>
          FocusNode(skipTraversal: true, debugLabel: 'Day ${index + 1}'),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final DateTime? focusedDate = _FocusedDate.of(context);
    if (focusedDate != null &&
        _DateUtils.isSameMonth(widget.displayedMonth, focusedDate)) {
      _dayFocusNodes[focusedDate.day - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (final FocusNode node in _dayFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final DesktopLocalizations localizations = DesktopLocalizations.of(context);

    final TextTheme textTheme = Theme.of(context).textTheme;

    final TextStyle dayStyle = textTheme.body1;

    final Color enabledDayColor = textTheme.textLow;
    final Color disabledDayColor = textTheme.textDisabled;
    final Color selectedDayColor = colorScheme.shade[100];
    final Color selectedDayBackground = colorScheme.primary[30];
    final Color todayColor = textTheme.textHigh;
    final Color background = colorScheme.background[0];

    final int year = widget.displayedMonth.year;
    final int month = widget.displayedMonth.month;

    final int daysInMonth = _DateUtils.getDaysInMonth(year, month);
    final int dayOffset = _DateUtils.firstDayOffset(year, month, localizations);

    final List<Widget> dayItems = [];

    for (int day = 1; day <= daysInMonth; day += 1) {
      final DateTime dayToBuild = DateTime(year, month, day);
      final bool isDisabled = dayToBuild.isAfter(widget.lastDate) ||
          dayToBuild.isBefore(widget.firstDate) ||
          (widget.selectableDayPredicate != null &&
              !widget.selectableDayPredicate!(dayToBuild));
      final bool isSelectedDay =
          _DateUtils.isSameDay(widget.selectedDate, dayToBuild);
      final bool isToday = _DateUtils.isSameDay(widget.currentDate, dayToBuild);

      Color dayColor = enabledDayColor;

      if (isToday) {
        dayColor = todayColor;
      } else if (isDisabled) {
        dayColor = disabledDayColor;
      }

      Widget result = Button.filled(
        localizations.formatDecimal(day),
        active: isSelectedDay,
        padding: EdgeInsets.zero,
        focusNode: _dayFocusNodes[day - 1],
        style: ButtonThemeData(
          background: background,
          highlightBackground: selectedDayBackground,
          foreground: dayColor,
          highlightForeground: selectedDayColor,
        ),
        onPressed: !isDisabled ? () => widget.onChanged(dayToBuild) : null,
      );

      if (isDisabled) {
        result = ExcludeSemantics(
          child: result,
        );
      } else {
        final String dayFormatted = localizations.formatDecimal(day);
        final String fullDateFormatted =
            localizations.formatFullDate(dayToBuild);

        result = Semantics(
          label: '$dayFormatted, $fullDateFormatted',
          selected: isSelectedDay,
          excludeSemantics: true,
          child: result,
        );
      }

      dayItems.add(result);
    }

    return DaysMonth(
      children: dayItems,
      daysOffset: dayOffset,
      dayBoxSize: _kBoxSize,
    );
  }
}
