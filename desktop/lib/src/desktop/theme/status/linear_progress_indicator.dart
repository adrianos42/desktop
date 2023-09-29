import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'linear_progress_indicator.g.dart';

/// Theme data for [LinearProgressIndicator].
@immutable
class _LinearProgressIndicatorThemeData {
  const _LinearProgressIndicatorThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The height of the linear progress indicator.
  ///
  /// Defaults to:
  /// 
  /// ```dart
  /// 4.0
  /// ```
  double get height => 4.0;

  /// The color of the linear progress indicator.
  ///
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.primary[50]
  /// ```
  Color get color => colorScheme.primary[50];

  /// The background color of the linear progress indicator.
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
  /// Duration(milliseconds: 4000)
  /// ```
  Duration get indeterminateDuration => const Duration(milliseconds: 4000);
}
