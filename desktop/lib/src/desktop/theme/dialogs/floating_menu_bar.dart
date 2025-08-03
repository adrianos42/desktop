import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'floating_menu_bar.g.dart';

/// Theme data for [menu bar].
@immutable
class _FloatingMenuBarThemeData {
  const _FloatingMenuBarThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.contentColorScheme;

  bool get _isDark => _themeData.brightness == Brightness.dark;

  /// The height of the menu bar's [child].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 32.0
  /// ```
  double get height => 32.0;

  /// The max width for the menu bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 320.0
  /// ```
  double get minWidth => 320.0;

  /// The background color for the menu bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// hoverColor.withValues(alpha: 0.8)
  /// ```
  Color get backgroundColor => _isDark ? _colorScheme.shade[90] : _colorScheme.shade[100];

  /// The menu bar opacity when inactive.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 0.8
  /// ```
  double get inactiveOpacity => 1.0;

  /// The foreground color for the menu bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get foreground => _colorScheme.background[0];

  /// The [TextStyle] for the menu bar text.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.caption
  /// ```
  TextStyle get textStyle => _textTheme.caption;

  /// The amount of space by which to inset the menu bar's [child].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
  /// ```
  EdgeInsetsGeometry get padding =>
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);

  /// The empty space that surrounds the menu bar
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.zero
  /// ```
  EdgeInsetsGeometry get margin => EdgeInsets.zero;

  // /// The fade in animation duration.
  // ///
  // /// Defaults to:
  // ///
  // /// ```dart
  // /// Duration(milliseconds: 80)
  // /// ```
  // Duration get fadeInDuration => const Duration(milliseconds: 80);

  // /// The fade out animation duration.
  // ///
  // /// Defaults to:
  // ///
  // /// ```dart
  // /// Duration(milliseconds: 40)
  // /// ```
  // Duration get fadeOutDuration => const Duration(milliseconds: 40);

  /// The length of time that the menu bar will be shown after a long press
  /// is released.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 2400)
  /// ```
  Duration get showDuration => const Duration(milliseconds: 2400);

  /// The length of time that a pointer must hover over a menu bar's widget
  /// before the menu bar will be shown.
  ///
  /// Once the pointer leaves the widget, the menu bar will immediately
  /// disappear.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 1200)
  /// ```
  Duration get waitDuration => const Duration(milliseconds: 1200);
}
