// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Message].
@immutable
class MessageThemeData {
  /// Creates a [MessageThemeData].
  const MessageThemeData({
    this.textStyle,
    this.titleTextStyle,
    this.titlePadding,
    this.padding,
    this.highlightColor,
    this.backgroundColor,
    this.itemSpacing,
    this.infoColor,
    this.errorColor,
    this.warningColor,
    this.successColor,
    this.animationCurve,
    this.duration,
    this.animationDuration,
  });

  /// The text style for the message.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.caption
  /// ```
  final TextStyle? textStyle;

  /// The text style for the title.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.caption.copyWith(fontWeight: FontWeight.w500)
  /// ```
  final TextStyle? titleTextStyle;

  /// The title padding.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.only(bottom: 4)
  /// ```
  final EdgeInsets? titlePadding;

  /// The box padding.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.all(12.0)
  /// ```
  final EdgeInsets? padding;

  /// The highlight color for the top border.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  final Color? highlightColor;

  /// The background color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? backgroundColor;

  /// The space between two items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 12.0
  /// ```
  final double? itemSpacing;

  /// The info color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Color.fromARGB(0xff, 0x99, 0x99, 0x99)
  /// ```
  final Color? infoColor;

  /// The error color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Color.fromARGB(0xff, 0xdd, 0x3c, 0x3c)
  /// ```
  final Color? errorColor;

  /// The warning color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Color.fromARGB(0xff, 0xdd, 0xdd, 0x3c)
  /// ```
  final Color? warningColor;

  /// The success color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Color.fromARGB(0xff, 0x3c, 0xdd, 0x3c)
  /// ```
  final Color? successColor;

  /// The animation curve.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Curves.easeInCubic
  /// ```
  final Curve? animationCurve;

  /// The duration of the message.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(seconds: 6)
  /// ```
  final Duration? duration;

  /// The duration of the message animation.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 100)
  /// ```
  final Duration? animationDuration;

  /// Makes a copy of [MessageThemeData] overwriting selected fields.
  MessageThemeData copyWith({
    TextStyle? textStyle,
    TextStyle? titleTextStyle,
    EdgeInsets? titlePadding,
    EdgeInsets? padding,
    Color? highlightColor,
    Color? backgroundColor,
    double? itemSpacing,
    Color? infoColor,
    Color? errorColor,
    Color? warningColor,
    Color? successColor,
    Curve? animationCurve,
    Duration? duration,
    Duration? animationDuration,
  }) {
    return MessageThemeData(
      textStyle: textStyle ?? this.textStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titlePadding: titlePadding ?? this.titlePadding,
      padding: padding ?? this.padding,
      highlightColor: highlightColor ?? this.highlightColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      infoColor: infoColor ?? this.infoColor,
      errorColor: errorColor ?? this.errorColor,
      warningColor: warningColor ?? this.warningColor,
      successColor: successColor ?? this.successColor,
      animationCurve: animationCurve ?? this.animationCurve,
      duration: duration ?? this.duration,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  /// Merges the theme data [MessageThemeData].
  MessageThemeData merge(MessageThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textStyle: other.textStyle,
      titleTextStyle: other.titleTextStyle,
      titlePadding: other.titlePadding,
      padding: other.padding,
      highlightColor: other.highlightColor,
      backgroundColor: other.backgroundColor,
      itemSpacing: other.itemSpacing,
      infoColor: other.infoColor,
      errorColor: other.errorColor,
      warningColor: other.warningColor,
      successColor: other.successColor,
      animationCurve: other.animationCurve,
      duration: other.duration,
      animationDuration: other.animationDuration,
    );
  }

  bool get _isConcrete {
    return textStyle != null &&
        titleTextStyle != null &&
        titlePadding != null &&
        padding != null &&
        highlightColor != null &&
        backgroundColor != null &&
        itemSpacing != null &&
        infoColor != null &&
        errorColor != null &&
        warningColor != null &&
        successColor != null &&
        animationCurve != null &&
        duration != null &&
        animationDuration != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      textStyle,
      titleTextStyle,
      titlePadding,
      padding,
      highlightColor,
      backgroundColor,
      itemSpacing,
      infoColor,
      errorColor,
      warningColor,
      successColor,
      animationCurve,
      duration,
      animationDuration,
    );
  }

  @override
  String toString() {
    return r'''
textStyle: The text style for the message.

 Defaults to:

 ```dart
 textTheme.caption
 ```;;titleTextStyle: The text style for the title.

 Defaults to:

 ```dart
 textTheme.caption.copyWith(fontWeight: FontWeight.w500)
 ```;;titlePadding: The title padding.

 Defaults to:

 ```dart
 EdgeInsets.only(bottom: 4)
 ```;;padding: The box padding.

 Defaults to:

 ```dart
 EdgeInsets.all(12.0)
 ```;;highlightColor: The highlight color for the top border.

 Defaults to:

 ```dart
 colorScheme.shade[100]
 ```;;backgroundColor: The background color.

 Defaults to:

 ```dart
 colorScheme.background[0]
 ```;;itemSpacing: The space between two items.

 Defaults to:

 ```dart
 12.0
 ```;;infoColor: The info color.

 Defaults to:

 ```dart
 Color.fromARGB(0xff, 0x99, 0x99, 0x99)
 ```;;errorColor: The error color.

 Defaults to:

 ```dart
 Color.fromARGB(0xff, 0xdd, 0x3c, 0x3c)
 ```;;warningColor: The warning color.

 Defaults to:

 ```dart
 Color.fromARGB(0xff, 0xdd, 0xdd, 0x3c)
 ```;;successColor: The success color.

 Defaults to:

 ```dart
 Color.fromARGB(0xff, 0x3c, 0xdd, 0x3c)
 ```;;animationCurve: The animation curve.

 Defaults to:

 ```dart
 Curves.easeInCubic
 ```;;duration: The duration of the message.

 Defaults to:

 ```dart
 Duration(seconds: 6)
 ```;;animationDuration: The duration of the message animation.

 Defaults to:

 ```dart
 Duration(milliseconds: 100)
 ```;;
''';
  }

  @override
  bool operator ==(covariant MessageThemeData other) {
    return identical(this, other) ||
        other.textStyle == textStyle &&
            other.titleTextStyle == titleTextStyle &&
            other.titlePadding == titlePadding &&
            other.padding == padding &&
            other.highlightColor == highlightColor &&
            other.backgroundColor == backgroundColor &&
            other.itemSpacing == itemSpacing &&
            other.infoColor == infoColor &&
            other.errorColor == errorColor &&
            other.warningColor == warningColor &&
            other.successColor == successColor &&
            other.animationCurve == animationCurve &&
            other.duration == duration &&
            other.animationDuration == animationDuration;
  }
}

/// Inherited theme for [MessageThemeData].
@immutable
class MessageTheme extends InheritedTheme {
  /// Creates a [MessageTheme].
  const MessageTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [MessageTheme].
  final MessageThemeData data;

  /// Merges the nearest [MessageTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required MessageThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => MessageTheme(
        data: MessageTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [MessageTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    TextStyle? textStyle,
    TextStyle? titleTextStyle,
    EdgeInsets? titlePadding,
    EdgeInsets? padding,
    Color? highlightColor,
    Color? backgroundColor,
    double? itemSpacing,
    Color? infoColor,
    Color? errorColor,
    Color? warningColor,
    Color? successColor,
    Curve? animationCurve,
    Duration? duration,
    Duration? animationDuration,
  }) {
    return Builder(
      key: key,
      builder: (context) => MessageTheme(
        data: MessageTheme.of(context).copyWith(
          textStyle: textStyle,
          titleTextStyle: titleTextStyle,
          titlePadding: titlePadding,
          padding: padding,
          highlightColor: highlightColor,
          backgroundColor: backgroundColor,
          itemSpacing: itemSpacing,
          infoColor: infoColor,
          errorColor: errorColor,
          warningColor: warningColor,
          successColor: successColor,
          animationCurve: animationCurve,
          duration: duration,
          animationDuration: animationDuration,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [MessageTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final MessageTheme? messageTheme =
        context.findAncestorWidgetOfExactType<MessageTheme>();
    return identical(this, messageTheme)
        ? child
        : MessageTheme(data: data, child: child);
  }

  /// Returns the nearest [MessageTheme].
  static MessageThemeData of(BuildContext context) {
    final MessageTheme? messageTheme =
        context.dependOnInheritedWidgetOfExactType<MessageTheme>();
    MessageThemeData? messageThemeData = messageTheme?.data;

    if (messageThemeData == null || !messageThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      messageThemeData ??= themeData.messageTheme;

      final messageValue =
          _MessageThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final TextStyle textStyle =
          messageThemeData.textStyle ?? messageValue.textStyle;
      final TextStyle titleTextStyle =
          messageThemeData.titleTextStyle ?? messageValue.titleTextStyle;
      final EdgeInsets titlePadding =
          messageThemeData.titlePadding ?? messageValue.titlePadding;
      final EdgeInsets padding =
          messageThemeData.padding ?? messageValue.padding;
      final Color highlightColor =
          messageThemeData.highlightColor ?? messageValue.highlightColor;
      final Color backgroundColor =
          messageThemeData.backgroundColor ?? messageValue.backgroundColor;
      final double itemSpacing =
          messageThemeData.itemSpacing ?? messageValue.itemSpacing;
      final Color infoColor =
          messageThemeData.infoColor ?? messageValue.infoColor;
      final Color errorColor =
          messageThemeData.errorColor ?? messageValue.errorColor;
      final Color warningColor =
          messageThemeData.warningColor ?? messageValue.warningColor;
      final Color successColor =
          messageThemeData.successColor ?? messageValue.successColor;
      final Curve animationCurve =
          messageThemeData.animationCurve ?? messageValue.animationCurve;
      final Duration duration =
          messageThemeData.duration ?? messageValue.duration;
      final Duration animationDuration =
          messageThemeData.animationDuration ?? messageValue.animationDuration;

      return messageThemeData.copyWith(
        textStyle: textStyle,
        titleTextStyle: titleTextStyle,
        titlePadding: titlePadding,
        padding: padding,
        highlightColor: highlightColor,
        backgroundColor: backgroundColor,
        itemSpacing: itemSpacing,
        infoColor: infoColor,
        errorColor: errorColor,
        warningColor: warningColor,
        successColor: successColor,
        animationCurve: animationCurve,
        duration: duration,
        animationDuration: animationDuration,
      );
    }

    assert(messageThemeData._isConcrete);

    return messageThemeData;
  }

  @override
  bool updateShouldNotify(MessageTheme oldWidget) => data != oldWidget.data;
}
