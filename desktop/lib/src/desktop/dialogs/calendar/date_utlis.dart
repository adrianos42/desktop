import 'package:flutter/widgets.dart';

import '../../localizations.dart';

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

class DateUtils {
  DateUtils._();

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