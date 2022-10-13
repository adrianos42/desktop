import 'dart:math' as math;

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'calendar_date.dart';
import 'date_utlis.dart';
import 'month_picker.dart';
import '../dialog.dart';
import '../../theme/theme.dart';

/// Date picker dialog.
///
/// See also:
///
///  * [showDatePicker], which is a way to display the date picker.
class DatePickerDialog extends StatefulWidget {
  /// Creates a date picker dialog.
  DatePickerDialog({
    super.key,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    this.selectableDayPredicate,
    this.helpText,
    this.initialCalendarMode = DatePickerMode.day,
  })  : initialDate = DateUtils.dateOnly(initialDate),
        firstDate = DateUtils.dateOnly(firstDate),
        lastDate = DateUtils.dateOnly(lastDate),
        currentDate = DateUtils.dateOnly(currentDate ?? DateTime.now()) {
    assert(!this.lastDate.isBefore(this.firstDate));
    assert(!this.initialDate.isBefore(this.firstDate));
    assert(!this.initialDate.isAfter(this.lastDate));
    assert(selectableDayPredicate == null ||
        selectableDayPredicate!(this.initialDate));
  }

  /// The initially selected [DateTime].
  final DateTime initialDate;

  /// The earliest allowable [DateTime].
  final DateTime firstDate;

  /// The latest allowable [DateTime].
  final DateTime lastDate;

  /// The [DateTime] representing today.
  final DateTime currentDate;

  /// Function to provide full control over which [DateTime] can be selected.
  final SelectableDayPredicate? selectableDayPredicate;

  /// The text that is displayed at the top of the header.
  final String? helpText;

  /// The initial display of the calendar picker.
  final DatePickerMode initialCalendarMode;

  ///
  static Future<DateTime?> showDatePicker(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    Locale? locale,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
  }) async {
    initialDate = DateUtils.dateOnly(initialDate);
    firstDate = DateUtils.dateOnly(firstDate);
    lastDate = DateUtils.dateOnly(lastDate);

    Widget dialog = DatePickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: currentDate,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      initialCalendarMode: initialDatePickerMode,
    );

    if (textDirection != null) {
      dialog = Directionality(
        textDirection: textDirection,
        child: dialog,
      );
    }

    if (locale != null) {
      dialog = Localizations.override(
        context: context,
        locale: locale,
        child: dialog,
      );
    }

    return Dialog.showCustomDialog<DateTime>(
      context,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (BuildContext context) => dialog,
    );
  }

  @override
  State<DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  final GlobalKey _calendarPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO(as): final Orientation orientation = MediaQuery.of(context).orientation;

    return DialogTheme(
      data: DialogTheme.of(context).copyWith(
        bodyPadding: const EdgeInsets.symmetric(
          vertical: 0,
        ),
      ),
      child: Dialog(
        allowScroll: false,
        body: Align(
          alignment: Alignment.centerLeft,
          child: CalendarDate(
            firstDate: widget.firstDate,
            initialDate: widget.initialDate,
            lastDate: widget.lastDate,
            onDateChanged: (_) {},
            currentDate: widget.currentDate,
            initialCalendarMode: widget.initialCalendarMode,
            key: _calendarPickerKey,
            selectableDayPredicate: widget.selectableDayPredicate,
            onDateSelected: (selectedDate) =>
                Navigator.pop(context, selectedDate),
          ),
        ),
      ),
    );
  }
}
