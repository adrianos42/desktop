import 'package:flutter/foundation.dart';
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

  static DesktopLocalizations of(BuildContext context) {
    //assert(debugCheckHasDesktopLocalizations(context));
    return Localizations.of<DesktopLocalizations>(context, DesktopLocalizations)!;
  }
}

class _DesktopLocalizationsDelegate extends LocalizationsDelegate<DesktopLocalizations> {
  const _DesktopLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<DesktopLocalizations> load(Locale locale) => DefaultDesktopLocalizations.load(locale);

  @override
  bool shouldReload(_DesktopLocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultDesktopLocalizations.delegate(en_US)';
}

/// US English strings for the Desktop widgets.
class DefaultDesktopLocalizations implements DesktopLocalizations {
  const DefaultDesktopLocalizations();

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) {
    assert(tabIndex >= 1);
    assert(tabCount >= 1);
    return 'Tab $tabIndex of $tabCount';
  }

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  static Future<DesktopLocalizations> load(Locale locale) {
    return SynchronousFuture<DesktopLocalizations>(const DefaultDesktopLocalizations());
  }

  static const LocalizationsDelegate<DesktopLocalizations> delegate = _DesktopLocalizationsDelegate();
}
