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

  /// Makes a copy of [RadioThemeData] overwriting selected fields.
  RadioThemeData copyWith({
    Color? disabledColor,
    Color? activeColor,
    Color? activeHoverColor,
    Color? inactiveColor,
    Color? inactiveHoverColor,
    Color? foreground,
  }) {
    return RadioThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      activeHoverColor: activeHoverColor ?? this.activeHoverColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      inactiveHoverColor: inactiveHoverColor ?? this.inactiveHoverColor,
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
    return '''disabledColor:;activeColor:;activeHoverColor:;inactiveColor:;inactiveHoverColor:;foreground:;''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RadioThemeData &&
        other.disabledColor == disabledColor &&
        other.activeColor == activeColor &&
        other.activeHoverColor == activeHoverColor &&
        other.inactiveColor == inactiveColor &&
        other.inactiveHoverColor == inactiveHoverColor &&
        other.foreground == foreground;
  }
}

/// Inherited theme for [RadioThemeData].
@immutable
class RadioTheme extends InheritedTheme {
  /// Creates a [RadioTheme].
  const RadioTheme({
    super.key,
    required super.child,
    required this.data,
  });

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
      builder: (context) => RadioTheme(
        data: RadioTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [RadioTheme] overwriting selected fields.
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
      builder: (context) => RadioTheme(
        data: RadioTheme.of(context).copyWith(
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

  /// Returns a copy of [RadioTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final RadioTheme? radioTheme =
        context.findAncestorWidgetOfExactType<RadioTheme>();
    return identical(this, radioTheme)
        ? child
        : RadioTheme(data: data, child: child);
  }

  /// Returns the nearest [RadioTheme].
  static RadioThemeData of(BuildContext context) {
    final RadioTheme? radioTheme =
        context.dependOnInheritedWidgetOfExactType<RadioTheme>();
    RadioThemeData? radioThemeData = radioTheme?.data;

    if (radioThemeData == null || !radioThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      radioThemeData ??= themeData.radioTheme;

      final _radioThemeData =
          _RadioThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final Color disabledColor =
          radioThemeData.disabledColor ?? _radioThemeData.disabledColor;
      final Color activeColor =
          radioThemeData.activeColor ?? _radioThemeData.activeColor;
      final Color activeHoverColor =
          radioThemeData.activeHoverColor ?? _radioThemeData.activeHoverColor;
      final Color inactiveColor =
          radioThemeData.inactiveColor ?? _radioThemeData.inactiveColor;
      final Color inactiveHoverColor = radioThemeData.inactiveHoverColor ??
          _radioThemeData.inactiveHoverColor;
      final Color foreground =
          radioThemeData.foreground ?? _radioThemeData.foreground;

      return radioThemeData.copyWith(
        disabledColor: disabledColor,
        activeColor: activeColor,
        activeHoverColor: activeHoverColor,
        inactiveColor: inactiveColor,
        inactiveHoverColor: inactiveHoverColor,
        foreground: foreground,
      );
    }

    assert(radioThemeData._isConcrete);

    return radioThemeData;
  }

  @override
  bool updateShouldNotify(RadioTheme oldWidget) => data != oldWidget.data;
}
