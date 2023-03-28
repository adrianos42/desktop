import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../icons.dart';
import '../../input/button.dart';
import '../../localizations.dart';
import '../../theme/theme.dart';
import 'date_utlis.dart';
import 'days_month.dart';

const double _kBoxSize = 40.0;
const double _kDefaultCalendarSpacing = 8.0;
const Duration _monthScrollDuration = Duration(milliseconds: 120);
const Curve _monthScrollCurve = Curves.easeInSine;

///
typedef SelectableDayPredicate = bool Function(DateTime day);

///
class MonthPicker extends StatefulWidget {
  ///
  MonthPicker({
    super.key,
    required this.initialMonth,
    required this.currentDate,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onChanged,
    required this.onModeChanged,
    required this.onDisplayedMonthChanged,
    this.selectableDayPredicate,
  })  : assert(!firstDate.isAfter(lastDate)),
        assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate));

  ///
  final DateTime initialMonth;

  ///
  final DateTime currentDate;

  ///
  final DateTime firstDate;

  ///
  final DateTime lastDate;

  ///
  final DateTime selectedDate;

  ///
  final VoidCallback? onModeChanged;

  ///
  final ValueChanged<DateTime> onChanged;

  ///
  final ValueChanged<DateTime> onDisplayedMonthChanged;

  ///
  final SelectableDayPredicate? selectableDayPredicate;

  @override
  MonthPickerState createState() => MonthPickerState();
}

///
class MonthPickerState extends State<MonthPicker> {
  final GlobalKey _pageViewKey = GlobalKey();
  late DateTime _currentMonth;
  late DesktopLocalizations _localizations;
  late TextDirection _textDirection;
  Map<ShortcutActivator, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  late FocusNode _dayGridFocus;
  DateTime? _focusedDay;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialMonth;

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

    _pageController = PageController(
        initialPage: DateUtils.monthDelta(widget.firstDate, _currentMonth));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = DesktopLocalizations.of(context);
    _textDirection = Directionality.of(context);
  }

  @override
  void didUpdateWidget(MonthPicker oldWidget) {
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
    _dayGridFocus.dispose();
    _pageController.dispose();
    super.dispose();
  }

  ///
  void handleNextMonth() {
    _pageController.nextPage(
      duration: _monthScrollDuration,
      curve: _monthScrollCurve,
    );
  }

  ///
  void handlePreviousMonth() {
    _pageController.previousPage(
      duration: _monthScrollDuration,
      curve: _monthScrollCurve,
    );
  }

  void _handleDateSelected(DateTime selectedDate) {
    _focusedDay = selectedDate;
    widget.onChanged(selectedDate);
  }

  void _handleMonthPageChanged(int monthPage) {
    setState(() {
      final DateTime monthDate =
          DateUtils.addMonthsToMonthDate(widget.firstDate, monthPage);
      if (!DateUtils.isSameMonth(_currentMonth, monthDate)) {
        _currentMonth = DateTime(monthDate.year, monthDate.month);
        widget.onDisplayedMonthChanged(_currentMonth);
        if (_focusedDay != null &&
            !DateUtils.isSameMonth(_focusedDay, _currentMonth)) {
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
    final int daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

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

  void _showMonth(DateTime month, {bool jump = false}) {
    final int monthPage = DateUtils.monthDelta(widget.firstDate, month);
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

  void _handleGridFocusChange(bool focused) {
    setState(() {
      if (focused && _focusedDay == null) {
        if (DateUtils.isSameMonth(widget.selectedDate, _currentMonth)) {
          _focusedDay = widget.selectedDate;
        } else if (DateUtils.isSameMonth(widget.currentDate, _currentMonth)) {
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
        if (!DateUtils.isSameMonth(_focusedDay, _currentMonth)) {
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

    DateTime nextDate = DateUtils.addDaysToDate(
        date, _dayDirectionOffset(direction, textDirection));

    while (!nextDate.isBefore(widget.firstDate) &&
        !nextDate.isAfter(widget.lastDate)) {
      if (_isSelectable(nextDate)) {
        return nextDate;
      }

      nextDate = DateUtils.addDaysToDate(
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
        DateUtils.addMonthsToMonthDate(widget.firstDate, index);

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
    final TextStyle headerStyle = textTheme.body1.copyWith(
      color: textTheme.textPrimaryHigh,
    );

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          8.0,
          _kDefaultCalendarSpacing,
          8.0,
          0.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: _kBoxSize,
              child: Align(
                alignment: Alignment.center,
                child: Button.text(
                  _localizations.formatMonthYear(_currentMonth),
                  onPressed: () => widget.onModeChanged?.call(),
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
                      itemCount: DateUtils.monthDelta(
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
    return !DateUtils.isSameDay(date, oldWidget.date);
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
    final int daysInMonth = DateUtils.getDaysInMonth(
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
        DateUtils.isSameMonth(widget.displayedMonth, focusedDate)) {
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

    final Color enabledDayColor = textTheme.textLow;
    final Color disabledDayColor = textTheme.textDisabled;
    final Color selectedDayColor = colorScheme.shade[100];
    final Color selectedDayBackground = colorScheme.primary[30];
    final Color todayColor = textTheme.textHigh;

    final int year = widget.displayedMonth.year;
    final int month = widget.displayedMonth.month;

    final int daysInMonth = DateUtils.getDaysInMonth(year, month);
    final int dayOffset = DateUtils.firstDayOffset(year, month, localizations);

    final List<Widget> dayItems = [];

    for (int day = 1; day <= daysInMonth; day += 1) {
      final DateTime dayToBuild = DateTime(year, month, day);
      final bool isDisabled = dayToBuild.isAfter(widget.lastDate) ||
          dayToBuild.isBefore(widget.firstDate) ||
          (widget.selectableDayPredicate != null &&
              !widget.selectableDayPredicate!(dayToBuild));
      final bool isSelectedDay =
          DateUtils.isSameDay(widget.selectedDate, dayToBuild);
      final bool isToday = DateUtils.isSameDay(widget.currentDate, dayToBuild);

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
        theme: ButtonThemeData(
          background: const Color(0x00000000),
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
      boxSize: const Size(_kBoxSize, _kBoxSize),
      columns: DateTime.daysPerWeek,
    );
  }
}
