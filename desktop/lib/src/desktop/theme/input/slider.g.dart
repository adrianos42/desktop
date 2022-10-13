// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Slider].
@immutable
class SliderThemeData {
  /// Creates a [SliderThemeData].
  const SliderThemeData({
    this.disabledColor,
    this.activeColor,
    this.activeHoverColor,
    this.trackColor,
    this.hightlightColor,
  });

  ///
  final Color? disabledColor;

  ///
  final Color? activeColor;

  ///
  final Color? activeHoverColor;

  ///
  final Color? trackColor;

  ///
  final Color? hightlightColor;

  /// Makes a copy of [SliderThemeData] overwriting selected fields.
  SliderThemeData copyWith({
    Color? disabledColor,
    Color? activeColor,
    Color? activeHoverColor,
    Color? trackColor,
    Color? hightlightColor,
  }) {
    return SliderThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      activeHoverColor: activeHoverColor ?? this.activeHoverColor,
      trackColor: trackColor ?? this.trackColor,
      hightlightColor: hightlightColor ?? this.hightlightColor,
    );
  }

  /// Merges the theme data [SliderThemeData].
  SliderThemeData merge(SliderThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      disabledColor: other.disabledColor,
      activeColor: other.activeColor,
      activeHoverColor: other.activeHoverColor,
      trackColor: other.trackColor,
      hightlightColor: other.hightlightColor,
    );
  }

  bool get _isConcrete {
    return disabledColor != null &&
        activeColor != null &&
        activeHoverColor != null &&
        trackColor != null &&
        hightlightColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      disabledColor,
      activeColor,
      activeHoverColor,
      trackColor,
      hightlightColor,
    );
  }

  @override
  String toString() {
    return '''disabledColor:;activeColor:;activeHoverColor:;trackColor:;hightlightColor:;''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SliderThemeData &&
        other.disabledColor == disabledColor &&
        other.activeColor == activeColor &&
        other.activeHoverColor == activeHoverColor &&
        other.trackColor == trackColor &&
        other.hightlightColor == hightlightColor;
  }
}

/// Inherited theme for [SliderThemeData].
@immutable
class SliderTheme extends InheritedTheme {
  /// Creates a [SliderTheme].
  const SliderTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [SliderTheme].
  final SliderThemeData data;

  /// Merges the nearest [SliderTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required SliderThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => SliderTheme(
        data: SliderTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [SliderTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    Color? disabledColor,
    Color? activeColor,
    Color? activeHoverColor,
    Color? trackColor,
    Color? hightlightColor,
  }) {
    return Builder(
      key: key,
      builder: (context) => SliderTheme(
        data: SliderTheme.of(context).copyWith(
          disabledColor: disabledColor,
          activeColor: activeColor,
          activeHoverColor: activeHoverColor,
          trackColor: trackColor,
          hightlightColor: hightlightColor,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [SliderTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final SliderTheme? sliderTheme =
        context.findAncestorWidgetOfExactType<SliderTheme>();
    return identical(this, sliderTheme)
        ? child
        : SliderTheme(data: data, child: child);
  }

  /// Returns the nearest [SliderTheme].
  static SliderThemeData of(BuildContext context) {
    final SliderTheme? sliderTheme =
        context.dependOnInheritedWidgetOfExactType<SliderTheme>();
    SliderThemeData? sliderThemeData = sliderTheme?.data;

    if (sliderThemeData == null || !sliderThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      sliderThemeData ??= themeData.sliderTheme;

      final _sliderThemeData =
          _SliderThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final Color disabledColor =
          sliderThemeData.disabledColor ?? _sliderThemeData.disabledColor;
      final Color activeColor =
          sliderThemeData.activeColor ?? _sliderThemeData.activeColor;
      final Color activeHoverColor =
          sliderThemeData.activeHoverColor ?? _sliderThemeData.activeHoverColor;
      final Color trackColor =
          sliderThemeData.trackColor ?? _sliderThemeData.trackColor;
      final Color hightlightColor =
          sliderThemeData.hightlightColor ?? _sliderThemeData.hightlightColor;

      return sliderThemeData.copyWith(
        disabledColor: disabledColor,
        activeColor: activeColor,
        activeHoverColor: activeHoverColor,
        trackColor: trackColor,
        hightlightColor: hightlightColor,
      );
    }

    assert(sliderThemeData._isConcrete);

    return sliderThemeData;
  }

  @override
  bool updateShouldNotify(SliderTheme oldWidget) => data != oldWidget.data;
}
