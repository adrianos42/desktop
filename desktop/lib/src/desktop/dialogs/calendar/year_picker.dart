import 'dart:math' as math;

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../icons.dart';
import '../../input/button.dart';
import '../../localizations.dart';
import '../../theme/theme.dart';
import 'days_month.dart';
import 'date_utlis.dart';

const double _kBoxSize = 40.0;
const int _yearPickerColumnCount = 3;
const int _yearPickerRowCount = 6;
const int _minYears = _yearPickerColumnCount * _yearPickerRowCount;

const Duration _monthScrollDuration = Duration(milliseconds: 120);
const Curve _monthScrollCurve = Curves.easeInSine;

class YearPicker extends StatefulWidget {
  /// Creates a year picker.
  ///
  /// The [firstDate], [lastDate], [selectedDate], and [onChanged]
  /// arguments must be non-null. The [lastDate] must be after the [firstDate].
  YearPicker({
    super.key,
    DateTime? currentDate,
    required this.firstDate,
    required this.lastDate,
    DateTime? initialDate,
    required this.selectedDate,
    required this.onChanged,
    required this.onDisplayedYearPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(!firstDate.isAfter(lastDate)),
        currentDate = DateUtils.dateOnly(currentDate ?? DateTime.now()),
        initialDate = DateUtils.dateOnly(initialDate ?? selectedDate);

  /// The current date.
  ///
  /// This date is subtly highlighted in the picker.
  final DateTime currentDate;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// The initial date to center the year display around.
  final DateTime initialDate;

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a year.
  final ValueChanged<DateTime> onChanged;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  final void Function(int) onDisplayedYearPageChanged;

  @override
  State<YearPicker> createState() => YearPickerState();
}

///
class YearPickerState extends State<YearPicker> {
  late PageController _pageController;

  final GlobalKey _pageViewKey = GlobalKey();
  // The approximate number of years necessary to fill the available space.

  @override
  void initState() {
    super.initState();

    _pageController =
        PageController(initialPage: _pageYear(widget.selectedDate));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(YearPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.firstDate != oldWidget.firstDate ||
        oldWidget.lastDate != widget.lastDate) {
      WidgetsBinding.instance.addPostFrameCallback(
        (Duration timeStamp) {
          _pageController.jumpToPage(_pageYear(widget.selectedDate));
        },
      );
    }
  }

  int _pageYear(DateTime date) {
    final int initialYearIndex = date.year - widget.firstDate.year;
    return initialYearIndex ~/ _minYears;
  }

  ///
  void handleNextYear() {
    _pageController.nextPage(
      duration: _monthScrollDuration,
      curve: _monthScrollCurve,
    );
  }

  ///
  void handlePreviousYear() {
    _pageController.previousPage(
      duration: _monthScrollDuration,
      curve: _monthScrollCurve,
    );
  }

  void _handleYearPageChanged(int yearPage) {
    setState(() {
      widget.onDisplayedYearPageChanged(yearPage);
    });
  }

  Widget _buildYearItem(BuildContext context, int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final int offset =
        _itemCount < _minYears ? (_minYears - _itemCount) ~/ 2 : 0;
    final int year = widget.firstDate.year + index - offset;
    final bool isSelected = year == widget.selectedDate.year;
    final bool isCurrentYear = year == widget.currentDate.year;
    final bool isDisabled =
        year < widget.firstDate.year || year > widget.lastDate.year;

    Color? textColor;
    const Color background =Color(0x00000000);

    if (isSelected) {
      textColor = colorScheme.shade[100];
    } else if (isDisabled) {
      textColor = textTheme.textDisabled;
    } else if (isCurrentYear) {
      textColor = colorScheme.shade[100];
    } else {
      textColor = textTheme.textLow;
    }

    return Button.filled(
      year.toString(),
      key: ValueKey<int>(year),
      theme: ButtonThemeData(
        background: background,
        foreground: textColor,
      ),
      onPressed: !isDisabled
          ? () => widget.onChanged(DateTime(year, widget.initialDate.month))
          : null,
    );
  }

  int get _itemCount => widget.lastDate.year - widget.firstDate.year + 1;

  ///
  int get currentPage => (_pageController.page ?? 0.0).toInt();

  @override
  Widget build(BuildContext context) {
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

    final int pageCount = (math.max(_itemCount, _minYears) / _minYears).ceil();

    return PageView.builder(
      itemBuilder: (context, pageIndex) {
        return Center(
          child: DaysMonth(
            daysOffset: 0,
            boxSize: const Size(_kBoxSize * 2, _kBoxSize),
            columns: _yearPickerColumnCount,
            children: List.generate(
              _minYears,
              (index) => _buildYearItem(context, pageIndex * _minYears + index),
            ),
          ),
        );
      },
      itemCount: pageCount,
      physics: scrollPhysics,
      scrollDirection: Axis.vertical,
      key: _pageViewKey,
      controller: _pageController,
      onPageChanged: _handleYearPageChanged,
    );
  }
}
