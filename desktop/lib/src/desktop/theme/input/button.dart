import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'button.g.dart';

const double _kSidePadding = 4.0;
const double _kFilledSidePadding = 12.0;
const double _kHeight = 32.0;
const double _kMinWidth = 12.0;

/// Theme data for [Button].
@immutable
class _ButtonThemeData {
  const _ButtonThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.contentTextTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;
  ColorScheme get _contentColorScheme => _themeData.contentColorScheme;

  bool get _isDark => _themeData.brightness == Brightness.dark;

  /// The axis of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Axis.horizontal
  /// ```
  Axis get axis => Axis.horizontal;

  /// The icon theme data.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: kDefaultIconSize, color: color)
  /// ```
  IconThemeData get iconThemeData => IconThemeData(
        size: defaultIconSize,
        color: color,
        fill: 1.0,
      );

  /// Spacing used in body and button paddings.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 4.0
  /// ```
  double get itemSpacing => _kSidePadding;

  /// Spacing used in body padding when the button is filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 12.0
  /// ```
  double get filledSpacing => _kFilledSidePadding;

  /// The height of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 32.0
  /// ```
  double get height => _kHeight;

  /// The minimum width of the button.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 12.0
  /// ```
  double get minWidth => _kMinWidth;

  /// The text style.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: defaultFontSize, overflow: TextOverflow.ellipsis)
  /// ```
  TextStyle get textStyle => _textTheme.body2.copyWith(
        fontSize: defaultFontSize,
        overflow: TextOverflow.ellipsis,
      );

  /// The color when the button is disabled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  Color get disabledColor => _contentColorScheme.disabled;

  /// The color when button is not filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  Color get color => _colorScheme.primary[highlightColorIndex];

  /// The color when the button has focus.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// hoverColor
  /// ```
  Color get focusColor => hoverColor;

  /// The color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get hoverColor => _textTheme.textHigh;

  /// The color when the button is pressed.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get highlightColor => _textTheme.textLow;

  /// The background color when the button is filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[30]
  /// ```
  Color get background =>
      _isDark ? _colorScheme.primary[30] : _textTheme.textHigh;

  /// The background color when the button is disabled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  Color get disabledBackground =>
      _isDark ? _colorScheme.disabled : _contentColorScheme.disabled;

  /// The background color when the button is being focused.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get focusBackground => _colorScheme.shade[100];

  /// The background color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[30]
  /// ```
  Color get hoverBackground =>
      _isDark ? _colorScheme.background[20] : _textTheme.textLow;

  /// The background color when the button is pressed.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  Color get highlightBackground =>
      _isDark ? _colorScheme.shade[30] : _textTheme.textMedium;

  /// The foreground color when the button is filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get foreground => _colorScheme.shade[100];

  /// The foreground color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get hoverForeground => _colorScheme.shade[100];

  /// The foreground color when the button is pressed.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get highlightForeground =>
      _isDark ? _textTheme.textHigh : _contentColorScheme.background[20];

  /// The duration of the animation.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 100)
  /// ```
  Duration get animationDuration => const Duration(milliseconds: 100);
}
