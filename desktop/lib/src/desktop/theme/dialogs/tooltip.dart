import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'tooltip.g.dart';

/// Theme data for [Tooltip].
@immutable
class _TooltipThemeData {
  const _TooltipThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The height of the tooltip's [child].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 32.0
  /// ```
  double get height => 32.0;

  /// The max width for the tooltip.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 320.0
  /// ```
  double get maxWidth => 320.0;

  /// The vertical gap between the widget and the displayed tooltip.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 24.0
  /// ```
  double get verticalOffset => 24.0;

  /// The background color for the tooltip.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get backgroundColor => colorScheme.background[0];

  /// The [TextStyle] for the tooltip text.
  /// 
  /// Defaults to:
  /// 
  /// ```dart
  /// textTheme.caption
  /// ```
  TextStyle get textStyle => textTheme.caption;

  /// The amount of space by which to inset the tooltip's [child].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
  /// ```
  EdgeInsetsGeometry get padding =>
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);

  /// The empty space that surrounds the tooltip
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

  /// The length of time that the tooltip will be shown after a long press
  /// is released.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 2400)
  /// ```
  Duration get showDuration => const Duration(milliseconds: 2400);

  /// The length of time that a pointer must hover over a tooltip's widget
  /// before the tooltip will be shown.
  ///
  /// Once the pointer leaves the widget, the tooltip will immediately
  /// disappear.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 1200)
  /// ```
  Duration get waitDuration => const Duration(milliseconds: 1200);
}
