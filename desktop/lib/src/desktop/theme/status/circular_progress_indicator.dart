import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'circular_progress_indicator.g.dart';

/// Theme data for [CircularProgressIndicator].
@immutable
class _CircularProgressIndicatorThemeData {
  const _CircularProgressIndicatorThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The size of the circular progress indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 40.0
  /// ```
  double get size => 40.0;

  /// The color of the circular progress indicator. Defaults to []
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[50]
  /// ```
  Color get color => colorScheme.primary[50];

  /// The background color of the circular progress indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  Color get backgroundColor => colorScheme.disabled;

  /// The indeterminate animation duration.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 6400)
  /// ```
  Duration get indeterminateDuration => const Duration(milliseconds: 7000);
}
