import 'dart:async';

import 'package:flutter/widgets.dart';

import '../input/button.dart';
import '../theme/theme.dart';

DateTime _dateOnly(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}

class DatePicker extends StatefulWidget {
  ///
  DatePicker({
    super.key,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    this.cancelText,
    this.confirmText,
    this.helpText,
    this.restorationId,
  })  : initialDate = _dateOnly(initialDate),
        firstDate = _dateOnly(firstDate),
        lastDate = _dateOnly(lastDate),
        currentDate = _dateOnly(currentDate ?? DateTime.now());

  /// The initially selected [DateTime] that the picker should display.
  final DateTime initialDate;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// The [DateTime] representing today. It will be highlighted in the day grid.
  final DateTime currentDate;

  /// The text that is displayed on the cancel button.
  final String? cancelText;

  /// The text that is displayed on the confirm button.
  final String? confirmText;

  /// The text that is displayed at the top of the header.
  ///
  /// This is used to indicate to the user what they are selecting a date for.
  final String? helpText;

  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  final String? restorationId;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
