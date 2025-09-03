// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linear_progress_indicator.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [LinearProgressIndicator].
@immutable
class LinearProgressIndicatorThemeData {
  /// Creates a [LinearProgressIndicatorThemeData].
  const LinearProgressIndicatorThemeData({
    this.height,
    this.color,
    this.backgroundColor,
    this.indeterminateDuration,
    this.padding,
  });

  /// The height of the linear progress indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0
  /// ```
  final double? height;

  /// The color of the linear progress indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[50]
  /// ```
  final Color? color;

  /// The background color of the linear progress indicator.
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
  /// Duration(milliseconds: 4000)
  /// ```
  final Duration? indeterminateDuration;

  /// The vertical padding.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.symmetric(vertical: 2.0)
  /// ```
  final EdgeInsets? padding;

  /// Makes a copy of [LinearProgressIndicatorThemeData] overwriting selected fields.
  LinearProgressIndicatorThemeData copyWith({
    double? height,
    Color? color,
    Color? backgroundColor,
    Duration? indeterminateDuration,
    EdgeInsets? padding,
  }) {
    return LinearProgressIndicatorThemeData(
      height: height ?? this.height,
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      indeterminateDuration:
          indeterminateDuration ?? this.indeterminateDuration,
      padding: padding ?? this.padding,
    );
  }

  /// Merges the theme data [LinearProgressIndicatorThemeData].
  LinearProgressIndicatorThemeData merge(
    LinearProgressIndicatorThemeData? other,
  ) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      color: other.color,
      backgroundColor: other.backgroundColor,
      indeterminateDuration: other.indeterminateDuration,
      padding: other.padding,
    );
  }

  bool get _isConcrete {
    return height != null &&
        color != null &&
        backgroundColor != null &&
        indeterminateDuration != null &&
        padding != null;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      height,
      color,
      backgroundColor,
      indeterminateDuration,
      padding,
    ]);
  }

  @override
  String toString() {
    return r'''
height: The height of the linear progress indicator.

 Defaults to:

 ```dart
 2.0
 ```;;color: The color of the linear progress indicator.

 Defaults to:

 ```dart
 colorScheme.primary[50]
 ```;;backgroundColor: The background color of the linear progress indicator.

 Defaults to:

 ```dart
 colorScheme.disabled
 ```;;indeterminateDuration: The indeterminate animation duration.

 Defaults to:

 ```dart
 Duration(milliseconds: 4000)
 ```;;padding: The vertical padding.

 Defaults to:

 ```dart
 EdgeInsets.symmetric(vertical: 2.0)
 ```;;
''';
  }

  @override
  bool operator ==(covariant LinearProgressIndicatorThemeData other) {
    return identical(this, other) ||
        other.height == height &&
            other.color == color &&
            other.backgroundColor == backgroundColor &&
            other.indeterminateDuration == indeterminateDuration &&
            other.padding == padding;
  }
}

/// Inherited theme for [LinearProgressIndicatorThemeData].
@immutable
class LinearProgressIndicatorTheme extends InheritedTheme {
  /// Creates a [LinearProgressIndicatorTheme].
  const LinearProgressIndicatorTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The data representing this [LinearProgressIndicatorTheme].
  final LinearProgressIndicatorThemeData data;

  /// Merges the nearest [LinearProgressIndicatorTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required LinearProgressIndicatorThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => LinearProgressIndicatorTheme(
        data: LinearProgressIndicatorTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [LinearProgressIndicatorTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    double? height,
    Color? color,
    Color? backgroundColor,
    Duration? indeterminateDuration,
    EdgeInsets? padding,
  }) {
    return Builder(
      key: key,
      builder: (context) => LinearProgressIndicatorTheme(
        data: LinearProgressIndicatorTheme.of(context).copyWith(
          height: height,
          color: color,
          backgroundColor: backgroundColor,
          indeterminateDuration: indeterminateDuration,
          padding: padding,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [LinearProgressIndicatorTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final LinearProgressIndicatorTheme? linearProgressIndicatorTheme = context
        .findAncestorWidgetOfExactType<LinearProgressIndicatorTheme>();
    return identical(this, linearProgressIndicatorTheme)
        ? child
        : LinearProgressIndicatorTheme(data: data, child: child);
  }

  /// Returns the nearest [LinearProgressIndicatorTheme].
  static LinearProgressIndicatorThemeData of(BuildContext context) {
    final LinearProgressIndicatorTheme? linearProgressIndicatorTheme = context
        .dependOnInheritedWidgetOfExactType<LinearProgressIndicatorTheme>();
    LinearProgressIndicatorThemeData? linearProgressIndicatorThemeData =
        linearProgressIndicatorTheme?.data;

    if (linearProgressIndicatorThemeData == null ||
        !linearProgressIndicatorThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      linearProgressIndicatorThemeData ??=
          themeData.linearProgressIndicatorTheme;

      final linearProgressIndicatorValue = _LinearProgressIndicatorThemeData(
        themeData,
      );

      final double height =
          linearProgressIndicatorThemeData.height ??
          linearProgressIndicatorValue.height;
      final Color color =
          linearProgressIndicatorThemeData.color ??
          linearProgressIndicatorValue.color;
      final Color backgroundColor =
          linearProgressIndicatorThemeData.backgroundColor ??
          linearProgressIndicatorValue.backgroundColor;
      final Duration indeterminateDuration =
          linearProgressIndicatorThemeData.indeterminateDuration ??
          linearProgressIndicatorValue.indeterminateDuration;
      final EdgeInsets padding =
          linearProgressIndicatorThemeData.padding ??
          linearProgressIndicatorValue.padding;

      return linearProgressIndicatorThemeData.copyWith(
        height: height,
        color: color,
        backgroundColor: backgroundColor,
        indeterminateDuration: indeterminateDuration,
        padding: padding,
      );
    }

    assert(linearProgressIndicatorThemeData._isConcrete);

    return linearProgressIndicatorThemeData;
  }

  @override
  bool updateShouldNotify(LinearProgressIndicatorTheme oldWidget) =>
      data != oldWidget.data;
}
