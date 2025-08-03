import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'drawer.g.dart';

const EdgeInsets _kbodyPadding = EdgeInsets.all(32.0);
const EdgeInsets _kTitlePadding = EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 0.0);
const EdgeInsets _kMenuPadding = EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 16.0);
const double _kMinDrawerWidth = 400.0;
const BoxConstraints _constraints = BoxConstraints.tightFor(
  width: _kMinDrawerWidth,
);

/// Theme data for [Drawer].
@immutable
class _DrawerThemeData {
  const _DrawerThemeData(ThemeData themeData) : _themeData = themeData;

  final ThemeData _themeData;

  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  /// The [BoxConstraints] of the [Drawer].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// BoxConstraints.tightFor(width: 400.0)
  /// ```
  BoxConstraints get constraints => _constraints;

  /// The [EdgeInsets] padding of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0)
  /// ```
  EdgeInsets get menuPadding => _kMenuPadding;

  /// The spacing the menu items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 16.0
  /// ```
  double get menuSpacing => 16.0;

  /// The title [EdgeInsets] padding of the title.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0)
  /// ```
  EdgeInsets get titlePadding => _kTitlePadding;

  /// The body [EdgeInsets] padding of the body.
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.all(16.0)
  /// ```
  EdgeInsets get bodyPadding => _kbodyPadding;

  /// The background color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get background => _colorScheme.background[0];

  /// The barrier color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20].withValues(alpha: (0.8)
  /// ```
  Color get barrierColor => _colorScheme.background[20].withValues(alpha: 0.8);

  /// The [TextStyle] for the title.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.title
  /// ```
  TextStyle get titleTextStyle => _textTheme.title;

  /// The [TextAlign] of the body text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// TextAlign.left
  /// ```
  TextAlign get bodyTextAlign => TextAlign.left;

  /// The [ImageFilter] used for the drawer`s barrier.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0)
  /// ```
  ImageFilter get imageFilter => ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0);
}
