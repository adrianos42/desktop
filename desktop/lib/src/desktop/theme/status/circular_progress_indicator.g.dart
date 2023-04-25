// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circular_progress_indicator.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [CircularProgressIndicator].
@immutable
class CircularProgressIndicatorThemeData {
  /// Creates a [CircularProgressIndicatorThemeData].
  const CircularProgressIndicatorThemeData({
    this.size,
    this.color,
    this.backgroundColor,
    this.indeterminateDuration,
  });

  /// The size of the circular progress indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 40.0
  /// ```
  final double? size;

  /// The color of the circular progress indicator. Defaults to []
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[kHighlightColorIndex]
  /// ```
  final Color? color;

  /// The background color of the circular progress indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  final Color? backgroundColor;

  /// The indeterminate animation duration.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 6400)
  /// ```
  final Duration? indeterminateDuration;

  /// Makes a copy of [CircularProgressIndicatorThemeData] overwriting selected fields.
  CircularProgressIndicatorThemeData copyWith({
    double? size,
    Color? color,
    Color? backgroundColor,
    Duration? indeterminateDuration,
  }) {
    return CircularProgressIndicatorThemeData(
      size: size ?? this.size,
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      indeterminateDuration:
          indeterminateDuration ?? this.indeterminateDuration,
    );
  }

  /// Merges the theme data [CircularProgressIndicatorThemeData].
  CircularProgressIndicatorThemeData merge(
      CircularProgressIndicatorThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      size: other.size,
      color: other.color,
      backgroundColor: other.backgroundColor,
      indeterminateDuration: other.indeterminateDuration,
    );
  }

  bool get _isConcrete {
    return size != null &&
        color != null &&
        backgroundColor != null &&
        indeterminateDuration != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      size,
      color,
      backgroundColor,
      indeterminateDuration,
    );
  }

  @override
  String toString() {
    return r'''
size: The size of the circular progress indicator.

 Defaults to:

 ```dart
 40.0
 ```;;color: The color of the circular progress indicator. Defaults to []

 Defaults to:

 ```dart
 colorScheme.primary[kHighlightColorIndex]
 ```;;backgroundColor: The background color of the circular progress indicator.

 Defaults to:

 ```dart
 colorScheme.disabled
 ```;;indeterminateDuration: The indeterminate animation duration.

 Defaults to:

 ```dart
 Duration(milliseconds: 6400)
 ```;;
''';
  }

  @override
  bool operator ==(covariant CircularProgressIndicatorThemeData other) {
    return identical(this, other) ||
        other.size == size &&
            other.color == color &&
            other.backgroundColor == backgroundColor &&
            other.indeterminateDuration == indeterminateDuration;
  }
}

/// Inherited theme for [CircularProgressIndicatorThemeData].
@immutable
class CircularProgressIndicatorTheme extends InheritedTheme {
  /// Creates a [CircularProgressIndicatorTheme].
  const CircularProgressIndicatorTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [CircularProgressIndicatorTheme].
  final CircularProgressIndicatorThemeData data;

  /// Merges the nearest [CircularProgressIndicatorTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required CircularProgressIndicatorThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => CircularProgressIndicatorTheme(
        data: CircularProgressIndicatorTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [CircularProgressIndicatorTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    double? size,
    Color? color,
    Color? backgroundColor,
    Duration? indeterminateDuration,
  }) {
    return Builder(
      key: key,
      builder: (context) => CircularProgressIndicatorTheme(
        data: CircularProgressIndicatorTheme.of(context).copyWith(
          size: size,
          color: color,
          backgroundColor: backgroundColor,
          indeterminateDuration: indeterminateDuration,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [CircularProgressIndicatorTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final CircularProgressIndicatorTheme? circularProgressIndicatorTheme =
        context.findAncestorWidgetOfExactType<CircularProgressIndicatorTheme>();
    return identical(this, circularProgressIndicatorTheme)
        ? child
        : CircularProgressIndicatorTheme(data: data, child: child);
  }

  /// Returns the nearest [CircularProgressIndicatorTheme].
  static CircularProgressIndicatorThemeData of(BuildContext context) {
    final CircularProgressIndicatorTheme? circularProgressIndicatorTheme =
        context.dependOnInheritedWidgetOfExactType<
            CircularProgressIndicatorTheme>();
    CircularProgressIndicatorThemeData? circularProgressIndicatorThemeData =
        circularProgressIndicatorTheme?.data;

    if (circularProgressIndicatorThemeData == null ||
        !circularProgressIndicatorThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      circularProgressIndicatorThemeData ??=
          themeData.circularProgressIndicatorTheme;

      final _circularProgressIndicatorThemeData =
          _CircularProgressIndicatorThemeData(
              textTheme: textTheme, colorScheme: colorScheme);

      final double size = circularProgressIndicatorThemeData.size ??
          _circularProgressIndicatorThemeData.size;
      final Color color = circularProgressIndicatorThemeData.color ??
          _circularProgressIndicatorThemeData.color;
      final Color backgroundColor =
          circularProgressIndicatorThemeData.backgroundColor ??
              _circularProgressIndicatorThemeData.backgroundColor;
      final Duration indeterminateDuration =
          circularProgressIndicatorThemeData.indeterminateDuration ??
              _circularProgressIndicatorThemeData.indeterminateDuration;

      return circularProgressIndicatorThemeData.copyWith(
        size: size,
        color: color,
        backgroundColor: backgroundColor,
        indeterminateDuration: indeterminateDuration,
      );
    }

    assert(circularProgressIndicatorThemeData._isConcrete);

    return circularProgressIndicatorThemeData;
  }

  @override
  bool updateShouldNotify(CircularProgressIndicatorTheme oldWidget) =>
      data != oldWidget.data;
}
