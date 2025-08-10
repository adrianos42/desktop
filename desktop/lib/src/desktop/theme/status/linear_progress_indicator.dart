import 'package:flutter/widgets.dart';

import '../color_scheme.dart';

part 'linear_progress_indicator.g.dart';

/// Theme data for [LinearProgressIndicator].
@immutable
class _LinearProgressIndicatorThemeData {
  const _LinearProgressIndicatorThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  ColorScheme get _colorScheme => _themeData.colorScheme;

  /// The height of the linear progress indicator.
  ///
  /// Defaults to:
  /// 
  /// ```dart
  /// 2.0
  /// ```
  double get height => 2.0;

  /// The color of the linear progress indicator.
  ///
  /// Defaults to:
  /// 
  /// ```dart
  /// colorScheme.primary[50]
  /// ```
  Color get color => _colorScheme.primary[50];

  /// The background color of the linear progress indicator.
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
  /// Duration(milliseconds: 4000)
  /// ```
  Duration get indeterminateDuration => const Duration(milliseconds: 4000);

  /// The vertical padding.
  ///
  /// Defaults to:
  /// 
  /// ```dart
  /// EdgeInsets.symmetric(vertical: 2.0)
  /// ```
  EdgeInsets get padding => const EdgeInsets.symmetric(vertical: 6.0);
}
