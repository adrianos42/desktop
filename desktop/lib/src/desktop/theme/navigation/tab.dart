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
  const _TabThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  /// The padding for the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.zero
  /// ```
  EdgeInsets get padding => EdgeInsets.zero;

  /// The height of the tab bar when the axis is horizontal.
  /// When the value is `0.0`, the height of the tab bar will be
  /// the intrinsic height of the children.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 36.0
  /// ```
  double get height => _kTabHeight;

  /// The width of the tab bar when the axis is vertical.
  /// When the value is `0.0`, the width of the tab bar will be
  /// the intrinsic width of the children.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 0.0
  /// ```
  double get width => 0.0;

  /// The background of the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get tabBarBackgroundColor => _colorScheme.background[0];

  /// The style for the text. The color is ignored.
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

  /// The theme for the icon. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: kDefaultIconSize)
  /// ```
  IconThemeData get iconThemeData => const IconThemeData(
        size: defaultIconSize,
        fill: 1.0,
      );

  /// The space between items inside the tab bar, if they are simple text or an icon.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 8.0
  /// ```
  double get itemSpacing => _kPadding;

  /// The padding for the items in the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.symmetric(horizontal: itemSpacing)
  /// ```
  EdgeInsets get itemPadding => EdgeInsets.symmetric(horizontal: itemSpacing);

  /// The color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  Color get itemColor => _textTheme.textLow;

  /// The hover color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get itemHoverColor => _colorScheme.shade[100];

  /// The highlight color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  Color get itemHighlightColor => _colorScheme.primary[60];

  /// If the tab bar item should use a filled button.
  /// See [itemBackgroundColor] to change the background color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// false
  /// ```
  bool get itemFilled => false;

  /// The background color when the button is filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[30]
  /// ```
  Color get itemBackgroundColor => _colorScheme.primary[30];

  /// The background color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[30]
  /// ```
  Color get itemHoverBackgroundColor => _colorScheme.shade[30];

  /// The background color when the button is pressed.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  Color get itemHighlightBackgroundColor => _colorScheme.background[20];

  /// The duration of the menu transition.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 400)
  /// ```
  Duration get menuTransitionDuration => const Duration(milliseconds: 400);

  /// The animation curve of the menu transition.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Curves.fastEaseInToSlowEaseOut
  /// ```
  Curve get menuTrasitionCurve => Curves.fastEaseInToSlowEaseOut;

  /// The animation reverse curve of the menu transition.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Curves.fastEaseInToSlowEaseOut.flipped
  /// ```
  Curve get menuTrasitionReverseCurve => Curves.fastEaseInToSlowEaseOut.flipped;
}
