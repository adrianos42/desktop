// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Radio].
@immutable
class RadioThemeData {
  /// Creates a [RadioThemeData].
  const RadioThemeData({
    this.disabledColor,
    this.activeColor,
    this.hoverColor,
    this.inactiveColor,
    this.foreground,
  });

  /// The disabled color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.disabled
  /// ```
  final Color? disabledColor;

  /// The active color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[50]
  /// ```
  final Color? activeColor;

  /// The active hover color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  final Color? hoverColor;

  /// The inactive color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? inactiveColor;

  /// The foreground color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  final Color? foreground;

  /// Makes a copy of [RadioThemeData] overwriting selected fields.
  RadioThemeData copyWith({
    Color? disabledColor,
    Color? activeColor,
    Color? hoverColor,
    Color? inactiveColor,
    Color? foreground,
  }) {
    return RadioThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      hoverColor: hoverColor ?? this.hoverColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      foreground: foreground ?? this.foreground,
    );
  }

  /// Merges the theme data [RadioThemeData].
  RadioThemeData merge(RadioThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      disabledColor: other.disabledColor,
      activeColor: other.activeColor,
      hoverColor: other.hoverColor,
      inactiveColor: other.inactiveColor,
      foreground: other.foreground,
    );
  }

  bool get _isConcrete {
    return disabledColor != null &&
        activeColor != null &&
        hoverColor != null &&
        inactiveColor != null &&
        foreground != null;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      disabledColor,
      activeColor,
      hoverColor,
      inactiveColor,
      foreground,
    ]);
  }

  @override
  String toString() {
    return r'''
disabledColor: The disabled color.

 Defaults to:

 ```dart
 colorScheme.disabled
 ```;;activeColor: The active color.

 Defaults to:

 ```dart
 colorScheme.primary[50]
 ```;;hoverColor: The active hover color.

 Defaults to:

 ```dart
 textTheme.textHigh
 ```;;inactiveColor: The inactive color.

 Defaults to:

 ```dart
 textTheme.textLow
 ```;;foreground: The foreground color.

 Defaults to:

 ```dart
 colorScheme.shade[100]
 ```;;
''';
  }

  @override
  bool operator ==(covariant RadioThemeData other) {
    return identical(this, other) ||
        other.disabledColor == disabledColor &&
            other.activeColor == activeColor &&
            other.hoverColor == hoverColor &&
            other.inactiveColor == inactiveColor &&
            other.foreground == foreground;
  }
}

/// Inherited theme for [RadioThemeData].
@immutable
class RadioTheme extends InheritedTheme {
  /// Creates a [RadioTheme].
  const RadioTheme({super.key, required super.child, required this.data});

  /// The data representing this [RadioTheme].
  final RadioThemeData data;

  /// Merges the nearest [RadioTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required RadioThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) =>
          RadioTheme(data: RadioTheme.of(context).merge(data), child: child),
    );
  }

  /// Makes a copy of the nearest [RadioTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    Color? disabledColor,
    Color? activeColor,
    Color? hoverColor,
    Color? inactiveColor,
    Color? foreground,
  }) {
    return Builder(
      key: key,
      builder: (context) => RadioTheme(
        data: RadioTheme.of(context).copyWith(
          disabledColor: disabledColor,
          activeColor: activeColor,
          hoverColor: hoverColor,
          inactiveColor: inactiveColor,
          foreground: foreground,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [RadioTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final RadioTheme? radioTheme = context
        .findAncestorWidgetOfExactType<RadioTheme>();
    return identical(this, radioTheme)
        ? child
        : RadioTheme(data: data, child: child);
  }

  /// Returns the nearest [RadioTheme].
  static RadioThemeData of(BuildContext context) {
    final RadioTheme? radioTheme = context
        .dependOnInheritedWidgetOfExactType<RadioTheme>();
    RadioThemeData? radioThemeData = radioTheme?.data;

    if (radioThemeData == null || !radioThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      radioThemeData ??= themeData.radioTheme;

      final radioValue = _RadioThemeData(themeData);

      final Color disabledColor =
          radioThemeData.disabledColor ?? radioValue.disabledColor;
      final Color activeColor =
          radioThemeData.activeColor ?? radioValue.activeColor;
      final Color hoverColor =
          radioThemeData.hoverColor ?? radioValue.hoverColor;
      final Color inactiveColor =
          radioThemeData.inactiveColor ?? radioValue.inactiveColor;
      final Color foreground =
          radioThemeData.foreground ?? radioValue.foreground;

      return radioThemeData.copyWith(
        disabledColor: disabledColor,
        activeColor: activeColor,
        hoverColor: hoverColor,
        inactiveColor: inactiveColor,
        foreground: foreground,
      );
    }

    assert(radioThemeData._isConcrete);

    return radioThemeData;
  }

  @override
  bool updateShouldNotify(RadioTheme oldWidget) => data != oldWidget.data;
}
