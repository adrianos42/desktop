import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'drop_down.g.dart';

// TODO(as): ???
// const double _kSidePadding = 6.0;
// const double _kHeight = 32.0;
const double _kIconSize = 18.0;
const double _kFontSize = 14.0;
// const double _kMinWidth = 12.0;

/// Theme data for [Dropdown].
@immutable
class _DropDownThemeData {
  const _DropDownThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.contentTextTheme;
  ColorScheme get _colorScheme => _themeData.contentColorScheme;

  /// The icon theme of the button. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: 18.0)
  /// ```
  IconThemeData get iconThemeData => const IconThemeData(
        size: _kIconSize,
        fill: 1.0,
      );

  /// The style of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: 14.0, color: textTheme.textMedium)
  /// ```
  TextStyle get textStyle => _textTheme.body2.copyWith(
        fontSize: _kFontSize,
        color: _textTheme.textMedium,
      );

  /// The color of the border when disabled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  Color get disabledColor => _colorScheme.disabled;

  /// The color of the border.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get color => _textTheme.textLow;

  /// The color of the border when focused.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// waitingColor
  /// ```
  Color get focusColor => waitingColor;

  /// The color of the border when hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get hoverColor => _textTheme.textHigh;

  /// The color of the border when the menu is open.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  Color get waitingColor => _colorScheme.background[20];

  /// The background color of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get backgroundColor => _colorScheme.background[0];

  /// The background color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get hoverBackgroundColor => _colorScheme.background[0];

  /// The background color when the menu is open.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get waitingBackgroundColor => _colorScheme.background[0];

  /// The background color when the button is disabled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get disabledBackgroundColor => _colorScheme.background[0];

  /// The color of the icon in the drop down.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// hoverColor
  /// ```
  BorderSide get border => const BorderSide(width: 1.0);
}
