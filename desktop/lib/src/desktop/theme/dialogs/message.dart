import 'package:flutter/widgets.dart';

import '../color_scheme.dart';
import '../theme_text.dart';

part 'message.g.dart';

const Duration _kDefaultMessageDuration = Duration(seconds: 4);

/// Theme data for [Message].
@immutable
class _MessageThemeData {
  const _MessageThemeData({
    required this.textTheme,
    required this.colorScheme,
  });

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  /// The text style for the message.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.caption
  /// ```
  TextStyle get textStyle => textTheme.caption;

  /// The text style for the title.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.caption.copyWith(fontWeight: FontWeight.w500)
  /// ```
  TextStyle get titleTextStyle => textTheme.caption.copyWith(
        fontWeight: FontWeight.w500,
      );

  /// The title padding.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.only(bottom: 4)
  /// ```
  EdgeInsets get titlePadding => const EdgeInsets.only(bottom: 4);

  /// The box padding.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.all(12.0)
  /// ```
  EdgeInsets get padding => const EdgeInsets.all(12.0);

  /// The highlight color for the top border.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  Color get highlightColor => colorScheme.shade[100];

  /// The background color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  Color get backgroundColor => colorScheme.background[0];

  /// The space between two items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 12.0
  /// ```
  double get itemSpacing => 12.0;

  /// The info color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Color.fromARGB(0xff, 0x99, 0x99, 0x99)
  /// ```
  Color get infoColor => const Color.fromARGB(0xff, 0x99, 0x99, 0x99);

  /// The error color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Color.fromARGB(0xff, 0xdd, 0x3c, 0x3c)
  /// ```
  Color get errorColor => const Color.fromARGB(0xff, 0xdd, 0x3c, 0x3c);

  /// The warning color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Color.fromARGB(0xff, 0xdd, 0xdd, 0x3c)
  /// ```
  Color get warningColor => const Color.fromARGB(0xff, 0xdd, 0xdd, 0x3c);

  /// The success color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Color.fromARGB(0xff, 0x3c, 0xdd, 0x3c)
  /// ```
  Color get successColor => const Color.fromARGB(0xff, 0x3c, 0xdd, 0x3c);

  /// The animation curve.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Curves.easeInCubic
  /// ```
  Curve get animationCurve => Curves.easeInCubic;

  /// The duration of the message.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(seconds: 6)
  /// ```
  Duration get duration => _kDefaultMessageDuration;

  /// The duration of the message animation.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 100)
  /// ```
  Duration get animationDuration => const Duration(milliseconds: 100);

  
}
