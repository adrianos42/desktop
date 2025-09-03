// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkbox.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Checkbox].
@immutable
class CheckboxThemeData {
  /// Creates a [CheckboxThemeData].
  const CheckboxThemeData({
    this.disabledColor,
    this.activeColor,
    this.activeHoverColor,
    this.inactiveColor,
    this.inactiveHoverColor,
    this.foreground,
    this.hoverForeground,
    this.containerSize,
  });

  /// The disabled color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
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
  final Color? activeHoverColor;

  /// The inactive color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? inactiveColor;

  /// The inactive hover color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  final Color? inactiveHoverColor;

  /// The foreground color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  final Color? foreground;

  /// The hover foreground color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? hoverForeground;

  /// The container size.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 32.0
  /// ```
  final double? containerSize;

  /// Makes a copy of [CheckboxThemeData] overwriting selected fields.
  CheckboxThemeData copyWith({
    Color? disabledColor,
    Color? activeColor,
    Color? activeHoverColor,
    Color? inactiveColor,
    Color? inactiveHoverColor,
    Color? foreground,
    Color? hoverForeground,
    double? containerSize,
  }) {
    return CheckboxThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      activeHoverColor: activeHoverColor ?? this.activeHoverColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      inactiveHoverColor: inactiveHoverColor ?? this.inactiveHoverColor,
      foreground: foreground ?? this.foreground,
      hoverForeground: hoverForeground ?? this.hoverForeground,
      containerSize: containerSize ?? this.containerSize,
    );
  }

  /// Merges the theme data [CheckboxThemeData].
  CheckboxThemeData merge(CheckboxThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      disabledColor: other.disabledColor,
      activeColor: other.activeColor,
      activeHoverColor: other.activeHoverColor,
      inactiveColor: other.inactiveColor,
      inactiveHoverColor: other.inactiveHoverColor,
      foreground: other.foreground,
      hoverForeground: other.hoverForeground,
      containerSize: other.containerSize,
    );
  }

  bool get _isConcrete {
    return disabledColor != null &&
        activeColor != null &&
        activeHoverColor != null &&
        inactiveColor != null &&
        inactiveHoverColor != null &&
        foreground != null &&
        hoverForeground != null &&
        containerSize != null;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      disabledColor,
      activeColor,
      activeHoverColor,
      inactiveColor,
      inactiveHoverColor,
      foreground,
      hoverForeground,
      containerSize,
    ]);
  }

  @override
  String toString() {
    return r'''
disabledColor: The disabled color.

 Defaults to:

 ```dart
 textTheme.textLow
 ```;;activeColor: The active color.

 Defaults to:

 ```dart
 colorScheme.primary[50]
 ```;;activeHoverColor: The active hover color.

 Defaults to:

 ```dart
 textTheme.textHigh
 ```;;inactiveColor: The inactive color.

 Defaults to:

 ```dart
 textTheme.textLow
 ```;;inactiveHoverColor: The inactive hover color.

 Defaults to:

 ```dart
 textTheme.textHigh
 ```;;foreground: The foreground color.

 Defaults to:

 ```dart
 colorScheme.shade[100]
 ```;;hoverForeground: The hover foreground color.

 Defaults to:

 ```dart
 colorScheme.background[0]
 ```;;containerSize: The container size.

 Defaults to:

 ```dart
 32.0
 ```;;
''';
  }

  @override
  bool operator ==(covariant CheckboxThemeData other) {
    return identical(this, other) ||
        other.disabledColor == disabledColor &&
            other.activeColor == activeColor &&
            other.activeHoverColor == activeHoverColor &&
            other.inactiveColor == inactiveColor &&
            other.inactiveHoverColor == inactiveHoverColor &&
            other.foreground == foreground &&
            other.hoverForeground == hoverForeground &&
            other.containerSize == containerSize;
  }
}

/// Inherited theme for [CheckboxThemeData].
@immutable
class CheckboxTheme extends InheritedTheme {
  /// Creates a [CheckboxTheme].
  const CheckboxTheme({super.key, required this.data, required super.child});

  /// The data representing this [CheckboxTheme].
  final CheckboxThemeData data;

  /// Merges the nearest [CheckboxTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required CheckboxThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => CheckboxTheme(
        data: CheckboxTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [CheckboxTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    Color? disabledColor,
    Color? activeColor,
    Color? activeHoverColor,
    Color? inactiveColor,
    Color? inactiveHoverColor,
    Color? foreground,
    Color? hoverForeground,
    double? containerSize,
  }) {
    return Builder(
      key: key,
      builder: (context) => CheckboxTheme(
        data: CheckboxTheme.of(context).copyWith(
          disabledColor: disabledColor,
          activeColor: activeColor,
          activeHoverColor: activeHoverColor,
          inactiveColor: inactiveColor,
          inactiveHoverColor: inactiveHoverColor,
          foreground: foreground,
          hoverForeground: hoverForeground,
          containerSize: containerSize,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [CheckboxTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final CheckboxTheme? checkboxTheme = context
        .findAncestorWidgetOfExactType<CheckboxTheme>();
    return identical(this, checkboxTheme)
        ? child
        : CheckboxTheme(data: data, child: child);
  }

  /// Returns the nearest [CheckboxTheme].
  static CheckboxThemeData of(BuildContext context) {
    final CheckboxTheme? checkboxTheme = context
        .dependOnInheritedWidgetOfExactType<CheckboxTheme>();
    CheckboxThemeData? checkboxThemeData = checkboxTheme?.data;

    if (checkboxThemeData == null || !checkboxThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      checkboxThemeData ??= themeData.checkboxTheme;

      final checkboxValue = _CheckboxThemeData(themeData);

      final Color disabledColor =
          checkboxThemeData.disabledColor ?? checkboxValue.disabledColor;
      final Color activeColor =
          checkboxThemeData.activeColor ?? checkboxValue.activeColor;
      final Color activeHoverColor =
          checkboxThemeData.activeHoverColor ?? checkboxValue.activeHoverColor;
      final Color inactiveColor =
          checkboxThemeData.inactiveColor ?? checkboxValue.inactiveColor;
      final Color inactiveHoverColor =
          checkboxThemeData.inactiveHoverColor ??
          checkboxValue.inactiveHoverColor;
      final Color foreground =
          checkboxThemeData.foreground ?? checkboxValue.foreground;
      final Color hoverForeground =
          checkboxThemeData.hoverForeground ?? checkboxValue.hoverForeground;
      final double containerSize =
          checkboxThemeData.containerSize ?? checkboxValue.containerSize;

      return checkboxThemeData.copyWith(
        disabledColor: disabledColor,
        activeColor: activeColor,
        activeHoverColor: activeHoverColor,
        inactiveColor: inactiveColor,
        inactiveHoverColor: inactiveHoverColor,
        foreground: foreground,
        hoverForeground: hoverForeground,
        containerSize: containerSize,
      );
    }

    assert(checkboxThemeData._isConcrete);

    return checkboxThemeData;
  }

  @override
  bool updateShouldNotify(CheckboxTheme oldWidget) => data != oldWidget.data;
}
