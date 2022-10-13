import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../constants.dart';
import '../theme_text.dart';

part 'tab.g.dart';

const double _kTabHeight = 36.0;
const double _kPadding = 8.0;

/// Theme data for [Tab].
@immutable
class _TabThemeData {
  const _TabThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The style for the text. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: kDefaultFontSize, overflow: TextOverflow.ellipsis)
  /// ```
  TextStyle get textStyle => textTheme.body2.copyWith(
        fontSize: kDefaultFontSize,
        overflow: TextOverflow.ellipsis,
      );

  /// The theme for the icon. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: kDefaultIconSize)
  /// ```
  IconThemeData get iconThemeData =>
      const IconThemeData(size: kDefaultIconSize);

  /// The space between items inside the tab bar, if they are simple text or an icon.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 8.0
  /// ```
  double get itemSpacing => _kPadding;

  /// The height of the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 36.0
  /// ```
  double get height => _kTabHeight;

  /// The color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get color => textTheme.textLow;

  /// The hover color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get hoverColor => colorScheme.shade[100];

  /// The background of the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get backgroundColor => colorScheme.background[0];

  /// The highlight color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  Color get highlightColor => colorScheme.primary[60];
}
