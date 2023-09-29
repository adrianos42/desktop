import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'nav.g.dart';

const double _kNavWidth = 36.0;
const double _kNavHeight = 40.0;
const double _kPadding = 8.0;
const double _kSideWidth = 2.0;
const double _kNavItemsSpacing = 8.0;

/// Theme data for [Nav].
@immutable
class _NavThemeData {
  const _NavThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The [IconThemeData] for the nav items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: width - 8.0 * 2.0)
  /// ```
  IconThemeData get iconThemeData => IconThemeData(
        size: width - _kPadding * 2.0,
        fill: 1.0,
      );

  /// The space between items inside the navbar.
  ///
  /// In this order:
  /// - The back button does not have it.
  /// - If it has a leading menu, as a top or left padding.
  /// - The navigation items have at both side.
  /// - If it has a trailing menu, as a bottom or right padding.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 8.0
  /// ```
  double get itemsSpacing => _kNavItemsSpacing;

  /// The width of the nab bar when the axis is [Axis.horizontal].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 36.0
  /// ```
  double get width => _kNavWidth;

  /// The height of the nav when the axis is [Axis.vertical].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 40.0
  /// ```
  double get height => _kNavHeight;

  /// The width of the indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0
  /// ```
  double get indicatorWidth => _kSideWidth;

  /// The animation [Duration] for the nav items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 200)
  /// ```
  Duration get animationDuration => const Duration(milliseconds: 200);
}
