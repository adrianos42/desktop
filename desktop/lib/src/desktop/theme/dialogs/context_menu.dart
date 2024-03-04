import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'context_menu.g.dart';

const double _kDefaultItemHeight = 32.0;
const double _kMenuWidthStep = 120.0;
const double _kMenuHorizontalPadding = 16.0;
const double _kMinMenuWidth = 2.0 * _kMenuWidthStep;
const double _kMaxMenuWidth = 6.0 * _kMenuWidthStep;

/// Theme data for [ContextMenu].
@immutable
class _ContextMenuThemeData {
  const _ContextMenuThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The icon theme.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: kDefaultIconSize, color: textTheme.textHigh)
  /// ```
  IconThemeData get iconThemeData => IconThemeData(
        size: defaultIconSize,
        color: textTheme.textHigh,
        fill: 1.0,
      );

  /// The menu step width.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0 * 120.0
  /// ```
  double get menuWidthStep => _kMenuWidthStep;

  /// The item height.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 32.0
  /// ```
  double get itemHeight => _kDefaultItemHeight;

  /// The minimum width of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0 * 120.0
  /// ```
  double get minMenuWidth => _kMinMenuWidth;

  /// The maximum width of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 6.0 * 120.0
  /// ```
  double get maxMenuWidth => _kMaxMenuWidth;

  /// The horizontal padding for the menu item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 16.0
  /// ```
  double get menuHorizontalPadding => _kMenuHorizontalPadding;

  /// The [TextStyle] of the item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body1.copyWith(fontSize: defaultFontSize)
  /// ```
  TextStyle get textStyle =>
      textTheme.body1.copyWith(fontSize: defaultFontSize);

  /// The color of an item when selected.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[30]
  /// ```
  Color get selectedColor => colorScheme.primary[30];

  /// The color of an item when selected and highlighted.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// highlightColor
  /// ```
  Color get selectedHighlightColor => highlightColor;

  /// The color of an item when selected and hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// hoverColor
  /// ```
  Color get selectedHoverColor => hoverColor;

  /// The text foreground when selected and hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  Color get selectedForeground => textTheme.textHigh;

  /// The color of an item when hovering over it.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[30]
  /// ```
  Color get hoverColor => colorScheme.shade[30];

  /// The color of an item when highlighted color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  Color get highlightColor => colorScheme.background[20];

  ///  The background color of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[8]
  /// ```
  Color get background => colorScheme.background[8];

  /// The color of the menu border.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get color => textTheme.textLow;
}
