import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';
import 'theme_text.dart';
import 'constants.dart';

@immutable
class SliderThemeData {
  const SliderThemeData({
    this.disabledColor,
    this.activeColor,
    this.trackColor,
    this.activeHoverColor,
  });

  final Color? disabledColor;

  final Color? activeColor;

  final Color? activeHoverColor;

  final Color? trackColor;

  SliderThemeData copyWith({
    Color? disabledColor,
    Color? activeColor,
    Color? trackColor,
    Color? activeHoverColor,
  }) {
    return SliderThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      trackColor: trackColor ?? this.trackColor,
      activeHoverColor: activeHoverColor ?? this.activeHoverColor,
    );
  }

  SliderThemeData merge(SliderThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      disabledColor: other.disabledColor,
      activeColor: other.activeColor,
      trackColor: other.trackColor,
      activeHoverColor: other.activeHoverColor,
    );
  }

  bool get isConcrete {
    return disabledColor != null &&
        activeColor != null &&
        activeHoverColor != null &&
        trackColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      disabledColor,
      activeColor,
      trackColor,
      activeHoverColor,
    );
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
        other.trackColor == trackColor;
  }
}

@immutable
class SliderTheme extends InheritedTheme {
  const SliderTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final SliderThemeData data;

  static Widget merge({
    Key? key,
    required SliderThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (context) => SliderTheme(
        key: key,
        data: SliderTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  static SliderThemeData of(BuildContext context) {
    final SliderTheme? sliderTheme =
        context.dependOnInheritedWidgetOfExactType<SliderTheme>();
    SliderThemeData? sliderThemeData = sliderTheme?.data;

    if (sliderThemeData == null || !sliderThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      sliderThemeData ??= themeData.sliderTheme;

      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      final Color trackColor =
          sliderThemeData.trackColor ?? colorScheme.shade[kItemBackgroundIndex];

      final Color activeHoverColor = sliderThemeData.activeHoverColor ??
          colorScheme.shade[kHoverColorIndex];

      final Color activeColor = sliderThemeData.activeColor ??
          colorScheme.primary[kHighlightColorIndex];

      final Color disabledColor =
          sliderThemeData.disabledColor ?? colorScheme.disabled;

      sliderThemeData = sliderThemeData.copyWith(
        disabledColor: disabledColor,
        activeColor: activeColor,
        trackColor: trackColor,
        activeHoverColor: activeHoverColor,
      );
    }

    assert(sliderThemeData.isConcrete);

    return sliderThemeData;
  }

  @override
  bool updateShouldNotify(SliderTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final SliderTheme? sliderTheme =
        context.findAncestorWidgetOfExactType<SliderTheme>();
    return identical(this, sliderTheme)
        ? child
        : SliderTheme(data: data, child: child);
  }
}
