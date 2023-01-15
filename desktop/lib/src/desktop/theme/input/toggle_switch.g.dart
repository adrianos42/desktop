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

  ///
  final Color? disabledColor;

  ///
  final Color? activeColor;

  ///
  final Color? activeHoverColor;

  ///
  final Color? inactiveColor;

  ///
  final Color? inactiveHoverColor;

  ///
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
    return Object.hash(
      disabledColor,
      activeColor,
      activeHoverColor,
      inactiveColor,
      inactiveHoverColor,
      foreground,
    );
  }

  @override
  String toString() {
    return r'''
disabledColor:;;activeColor:;;activeHoverColor:;;inactiveColor:;;inactiveHoverColor:;;foreground:;;
''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ToggleSwitchThemeData &&
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
    required super.child,
    required this.data,
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
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final ToggleSwitchTheme? toggleSwitchTheme =
        context.findAncestorWidgetOfExactType<ToggleSwitchTheme>();
    return identical(this, toggleSwitchTheme)
        ? child
        : ToggleSwitchTheme(data: data, child: child);
  }

  /// Returns the nearest [ToggleSwitchTheme].
  static ToggleSwitchThemeData of(BuildContext context) {
    final ToggleSwitchTheme? toggleSwitchTheme =
        context.dependOnInheritedWidgetOfExactType<ToggleSwitchTheme>();
    ToggleSwitchThemeData? toggleSwitchThemeData = toggleSwitchTheme?.data;

    if (toggleSwitchThemeData == null || !toggleSwitchThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      toggleSwitchThemeData ??= themeData.toggleSwitchTheme;

      final _toggleSwitchThemeData = _ToggleSwitchThemeData(
          textTheme: textTheme, colorScheme: colorScheme);

      final Color disabledColor = toggleSwitchThemeData.disabledColor ??
          _toggleSwitchThemeData.disabledColor;
      final Color activeColor = toggleSwitchThemeData.activeColor ??
          _toggleSwitchThemeData.activeColor;
      final Color activeHoverColor = toggleSwitchThemeData.activeHoverColor ??
          _toggleSwitchThemeData.activeHoverColor;
      final Color inactiveColor = toggleSwitchThemeData.inactiveColor ??
          _toggleSwitchThemeData.inactiveColor;
      final Color inactiveHoverColor =
          toggleSwitchThemeData.inactiveHoverColor ??
              _toggleSwitchThemeData.inactiveHoverColor;
      final Color foreground =
          toggleSwitchThemeData.foreground ?? _toggleSwitchThemeData.foreground;

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
