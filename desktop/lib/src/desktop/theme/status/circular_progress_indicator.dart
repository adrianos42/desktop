import 'package:flutter/widgets.dart';

import '../color_scheme.dart';

part 'circular_progress_indicator.g.dart';

/// Theme data for [CircularProgressIndicator].
@immutable
class _CircularProgressIndicatorThemeData {
  const _CircularProgressIndicatorThemeData(ThemeData themeData)
    : _themeData = themeData;

  final ThemeData _themeData;

  ColorScheme get _colorScheme => _themeData.colorScheme;

  /// The size of the circular progress indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 40.0
  /// ```
  double get size => 24.0;

  /// The stroke width of the circular progress indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0
  /// ```
  double get strokeWidth => 2.0;

  /// The color of the circular progress indicator. Defaults to []
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[50]
  /// ```
  Color get color => _colorScheme.primary[50];

  /// The background color of the circular progress indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  Color get backgroundColor => _colorScheme.disabled;

  /// The indeterminate animation duration.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 6400)
  /// ```
  Duration get indeterminateDuration => const Duration(milliseconds: 3000);
}
