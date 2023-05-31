import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'dialog.g.dart';

const EdgeInsets _kbodyPadding = EdgeInsets.all(16.0);
const EdgeInsets _kTitlePadding = EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0);
const EdgeInsets _kMenuPadding = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0);
const double _kMinDialogWidth = 640.0;
const double _kMinDialogHeight = 120.0;

/// Theme data for [Dialog].
@immutable
class _DialogThemeData {
  const _DialogThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The [BoxConstraints] of the [Dialog].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// BoxConstraints(minWidth: 640.0, minHeight: 120.0)
  /// ```
  BoxConstraints get constraints => const BoxConstraints(
        minWidth: _kMinDialogWidth,
        minHeight: _kMinDialogHeight,
      );

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
  Color get background => colorScheme.background[0];

  /// The barrier color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20].withOpacity(0.8)
  /// ```
  Color get barrierColor => colorScheme.background[20].withOpacity(0.8);

  /// The [TextStyle] for the title.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.title
  /// ```
  TextStyle get titleTextStyle => textTheme.title;

  /// The [TextAlign] of the body text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// TextAlign.left
  /// ```
  TextAlign get bodyTextAlign => TextAlign.left;

  /// The [ImageFilter] used for the dialog`s barrier.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0)
  /// ```
  ImageFilter get imageFilter => ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0);
}
