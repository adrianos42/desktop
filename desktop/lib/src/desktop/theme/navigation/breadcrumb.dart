import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'breadcrumb.g.dart';

const double _kTabHeight = 36.0;
const double _kPadding = 8.0;

/// Theme data for [Breadcrumb].
@immutable
class _BreadcrumbThemeData {
  const _BreadcrumbThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  /// The padding for the breadcrumb.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.symmetric(horizontal: 8.0)
  /// ```
  EdgeInsets get padding => const EdgeInsets.symmetric(horizontal: _kPadding);

  /// The height of the breadcrumb.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 36.0
  /// ```
  double get height => _kTabHeight;

  /// The space between items inside the breadcrumb.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0
  /// ```
  double get itemSpacing => 2.0;

  /// The color of the breadcrumb text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get color => _textTheme.textLow;

  /// The theme for the breadcrumb icon.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: 20.0)
  /// ```
  IconThemeData get iconTheme => const IconThemeData(size: 20.0, fill: 1.0);

  /// The style for the text.
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

  /// The background color of the breadcrumb.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get backgroundColor => _colorScheme.background[0];

  /// The color of the breadcrumb items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textPrimaryHigh
  /// ```
  Color get highlightColor => _textTheme.textPrimaryHigh;
}
