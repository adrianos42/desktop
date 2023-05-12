import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Defines the localized resource values used by the Desktop widgets.
///
/// See also:
///
///  * [DefaultDesktopLocalizations], the default, English-only, implementation
///    of this interface.
abstract class DesktopLocalizations {
  /// The accessibility label used on a tab in a [Tab].
  String tabSemanticsLabel({required int tabIndex, required int tabCount});

  String get modalBarrierDismissLabel;

  String formatYear(DateTime date);

  String formatFullDate(DateTime date);

  String formatMonthYear(DateTime date);

  List<String> get narrowWeekdays;

  String formatDecimal(int number);

  TextInputFormatter get dateFormInputFormatter;

  int get firstDayOfWeekIndex;

  String formatCompactDate(DateTime date);

  static DesktopLocalizations of(BuildContext context) {
    return Localizations.of<DesktopLocalizations>(
        context, DesktopLocalizations)!;
  }
}

class _DesktopLocalizationsDelegate
    extends LocalizationsDelegate<DesktopLocalizations> {
  const _DesktopLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<DesktopLocalizations> load(Locale locale) =>
      DefaultDesktopLocalizations.load(locale);

  @override
  bool shouldReload(_DesktopLocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultDesktopLocalizations.delegate(en_US)';
}

/// US English strings for the Desktop widgets.
class DefaultDesktopLocalizations implements DesktopLocalizations {
  const DefaultDesktopLocalizations();

  // static const List<String> _shortWeekdays = <String>[
  //   'Mon',
  //   'Tue',
  //   'Wed',
  //   'Thu',
  //   'Fri',
  //   'Sat',
  //   'Sun',
  // ];

  static const List<String> _weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> _narrowWeekdays = <String>[
    'S',
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
  ];

  // static const List<String> _shortMonths = <String>[
  //   'Jan',
  //   'Feb',
  //   'Mar',
  //   'Apr',
  //   'May',
  //   'Jun',
  //   'Jul',
  //   'Aug',
  //   'Sep',
  //   'Oct',
  //   'Nov',
  //   'Dec',
  // ];

  static const List<String> _months = <String>[
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

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) {
    assert(tabIndex >= 1);
    assert(tabCount >= 1);
    return 'Tab $tabIndex of $tabCount';
  }

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String formatFullDate(DateTime date) {
    final String month = _months[date.month - DateTime.january];
    return '${_weekdays[date.weekday - DateTime.monday]}, $month ${date.day}, ${date.year}';
  }

  @override
  String formatYear(DateTime date) => date.year.toString();

  @override
  String formatCompactDate(DateTime date) {
    // dd/mm/yyyy format
    final String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    final String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    final String year = date.year.toString().padLeft(4, '0');
    return '$day/$month/$year';
  }

  @override
  String formatMonthYear(DateTime date) {
    final String year = formatYear(date);
    final String month = _months[date.month - DateTime.january];
    return '$month $year';
  }

  @override
  int get firstDayOfWeekIndex => 1;

  @override
  List<String> get narrowWeekdays => _narrowWeekdays;

  @override
  String formatDecimal(int number) {
    if (number > -1000 && number < 1000) {
      return number.toString();
    }

    final String digits = number.abs().toString();
    final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
    final int maxDigitIndex = digits.length - 1;
    for (int i = 0; i <= maxDigitIndex; i += 1) {
      result.write(digits[i]);
      if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) {
        result.write(',');
      }
    }
    return result.toString();
  }

  @override
  TextInputFormatter get dateFormInputFormatter =>
      _DefaultDateFormInputFormatter();

  static Future<DesktopLocalizations> load(Locale locale) {
    return SynchronousFuture<DesktopLocalizations>(
        const DefaultDesktopLocalizations());
  }

  static const LocalizationsDelegate<DesktopLocalizations> delegate =
      _DesktopLocalizationsDelegate();
}

class _DefaultDateFormInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(oldValue, TextEditingValue newValue) {
    if (RegExp(r'^((\d{0,2})|(\d{2}\/\d{0,2})|(\d{2}\/\d{2}\/\d{0,4}))$')
            .hasMatch(newValue.text) ||
        newValue.text.isEmpty) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
