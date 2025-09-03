// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_switch.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [ToggleSwitch].
@immutable
class ToggleSwitchThemeData {
  /// Creates a [ToggleSwitchThemeData].
  const ToggleSwitchThemeData({
    this.disabledColor,
    this.activeColor,
    this.activeHoverColor,
    this.inactiveColor,
    this.inactiveHoverColor,
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

  /// Makes a copy of [ToggleSwitchThemeData] overwriting selected fields.
  ToggleSwitchThemeData copyWith({
    Color? disabledColor,
    Color? activeColor,
    Color? activeHoverColor,
    Color? inactiveColor,
    Color? inactiveHoverColor,
    Color? foreground,
  }) {
    return ToggleSwitchThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      activeHoverColor: activeHoverColor ?? this.activeHoverColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      inactiveHoverColor: inactiveHoverColor ?? this.inactiveHoverColor,
      foreground: foreground ?? this.foreground,
    );
  }

  /// Merges the theme data [ToggleSwitchThemeData].
  ToggleSwitchThemeData merge(ToggleSwitchThemeData? other) {
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
    );
  }

  bool get _isConcrete {
    return disabledColor != null &&
        activeColor != null &&
        activeHoverColor != null &&
        inactiveColor != null &&
        inactiveHoverColor != null &&
        foreground != null;
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
 ```;;
''';
  }

  @override
  bool operator ==(covariant ToggleSwitchThemeData other) {
    return identical(this, other) ||
        other.disabledColor == disabledColor &&
            other.activeColor == activeColor &&
            other.activeHoverColor == activeHoverColor &&
            other.inactiveColor == inactiveColor &&
            other.inactiveHoverColor == inactiveHoverColor &&
            other.foreground == foreground;
  }
}

/// Inherited theme for [ToggleSwitchThemeData].
@immutable
class ToggleSwitchTheme extends InheritedTheme {
  /// Creates a [ToggleSwitchTheme].
  const ToggleSwitchTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The data representing this [ToggleSwitchTheme].
  final ToggleSwitchThemeData data;

  /// Merges the nearest [ToggleSwitchTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required ToggleSwitchThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => ToggleSwitchTheme(
        data: ToggleSwitchTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [ToggleSwitchTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    Color? disabledColor,
    Color? activeColor,
    Color? activeHoverColor,
    Color? inactiveColor,
    Color? inactiveHoverColor,
    Color? foreground,
  }) {
    return Builder(
      key: key,
      builder: (context) => ToggleSwitchTheme(
        data: ToggleSwitchTheme.of(context).copyWith(
          disabledColor: disabledColor,
          activeColor: activeColor,
          activeHoverColor: activeHoverColor,
          inactiveColor: inactiveColor,
          inactiveHoverColor: inactiveHoverColor,
          foreground: foreground,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [ToggleSwitchTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final ToggleSwitchTheme? toggleSwitchTheme = context
        .findAncestorWidgetOfExactType<ToggleSwitchTheme>();
    return identical(this, toggleSwitchTheme)
        ? child
        : ToggleSwitchTheme(data: data, child: child);
  }

  /// Returns the nearest [ToggleSwitchTheme].
  static ToggleSwitchThemeData of(BuildContext context) {
    final ToggleSwitchTheme? toggleSwitchTheme = context
        .dependOnInheritedWidgetOfExactType<ToggleSwitchTheme>();
    ToggleSwitchThemeData? toggleSwitchThemeData = toggleSwitchTheme?.data;

    if (toggleSwitchThemeData == null || !toggleSwitchThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      toggleSwitchThemeData ??= themeData.toggleSwitchTheme;

      final toggleSwitchValue = _ToggleSwitchThemeData(themeData);

      final Color disabledColor =
          toggleSwitchThemeData.disabledColor ??
          toggleSwitchValue.disabledColor;
      final Color activeColor =
          toggleSwitchThemeData.activeColor ?? toggleSwitchValue.activeColor;
      final Color activeHoverColor =
          toggleSwitchThemeData.activeHoverColor ??
          toggleSwitchValue.activeHoverColor;
      final Color inactiveColor =
          toggleSwitchThemeData.inactiveColor ??
          toggleSwitchValue.inactiveColor;
      final Color inactiveHoverColor =
          toggleSwitchThemeData.inactiveHoverColor ??
          toggleSwitchValue.inactiveHoverColor;
      final Color foreground =
          toggleSwitchThemeData.foreground ?? toggleSwitchValue.foreground;

      return toggleSwitchThemeData.copyWith(
        disabledColor: disabledColor,
        activeColor: activeColor,
        activeHoverColor: activeHoverColor,
        inactiveColor: inactiveColor,
        inactiveHoverColor: inactiveHoverColor,
        foreground: foreground,
      );
    }

    assert(toggleSwitchThemeData._isConcrete);

    return toggleSwitchThemeData;
  }

  @override
  bool updateShouldNotify(ToggleSwitchTheme oldWidget) =>
      data != oldWidget.data;
}
