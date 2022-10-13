import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'drop_down.g.dart';

// TODO(as): ???
// const double _kSidePadding = 6.0;
// const double _kHeight = 32.0;
const double _kIconSize = 19.0;
const double _kFontSize = 14.0;
// const double _kMinWidth = 12.0;

/// Theme data for [Dropdown].
@immutable
class _DropDownThemeData {
  const _DropDownThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The icon theme of the button.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  IconThemeData get iconThemeData =>
      IconThemeData(size: _kIconSize, color: hoverColor);

  /// The style of the button.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  TextStyle get textStyle => textTheme.body2.copyWith(
        fontSize: _kFontSize,
        color: textTheme.textMedium,
      );

  /// The color of the border when disabled.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  Color get disabledColor => colorScheme.disabled;

  /// The color of the border.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  Color get color => textTheme.textLow;

  /// The color of the border when focused.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  Color get focusColor => waitingColor;

  /// The color of the border when hovered.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  Color get hoverColor => textTheme.textHigh;

  /// The color of the border when the menu is open.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  Color get waitingColor => colorScheme.background[20];

  /// The background color of the button.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  Color get backgroundColor => colorScheme.background[0];

  /// The background color when the button is being hovered.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  Color get hoverBackgroundColor => colorScheme.background[0];

  /// The background color when the menu is open.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  Color get waitingBackgroundColor => colorScheme.background[0];

  /// The background color when the button is disabled.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// 
  /// ```
  Color get disabledBackgroundColor => colorScheme.background[0];
}
