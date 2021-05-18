import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';

@immutable
class ScrollbarThemeData {
  const ScrollbarThemeData({
    this.disabledColor,
    this.color,
    this.foreground,
    this.hoverColor,
    this.highlightColor,
    this.inhoverColor,
  });

  final HSLColor? disabledColor;

  final HSLColor? color;

  final HSLColor? hoverColor;

  final HSLColor? highlightColor;

  final HSLColor? inhoverColor;

  final HSLColor? foreground;

  ScrollbarThemeData copyWith({
    HSLColor? disabledColor,
    HSLColor? color,
    HSLColor? foreground,
    HSLColor? hoverColor,
    HSLColor? highlightColor,
    HSLColor? inhoverColor,
  }) {
    return ScrollbarThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      color: color ?? this.color,
      foreground: foreground ?? this.foreground,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
      inhoverColor: inhoverColor ?? this.inhoverColor,
    );
  }

  ScrollbarThemeData merge(ScrollbarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      disabledColor: other.disabledColor,
      color: other.color,
      foreground: other.foreground,
      hoverColor: other.hoverColor,
      highlightColor: other.highlightColor,
      inhoverColor: inhoverColor,
    );
  }

  bool get isConcrete {
    return disabledColor != null &&
        color != null &&
        hoverColor != null &&
        inhoverColor != null &&
        highlightColor != null &&
        foreground != null;
  }

  @override
  int get hashCode {
    return hashValues(
      disabledColor,
      color,
      foreground,
      hoverColor,
      highlightColor,
      inhoverColor,
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
    return other is ScrollbarThemeData &&
        other.disabledColor == disabledColor &&
        other.color == color &&
        other.hoverColor == hoverColor &&
        other.inhoverColor == inhoverColor &&
        other.highlightColor == highlightColor &&
        other.foreground == foreground;
  }
}

@immutable
class ScrollbarTheme extends InheritedTheme {
  const ScrollbarTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final ScrollbarThemeData data;

  static Widget merge({
    Key? key,
    required ScrollbarThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (context) => ScrollbarTheme(
        key: key,
        data: ScrollbarTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  static ScrollbarThemeData of(BuildContext context) {
    final ScrollbarTheme? scrollbarTheme =
        context.dependOnInheritedWidgetOfExactType<ScrollbarTheme>();
    ScrollbarThemeData? scrollbarThemeData = scrollbarTheme?.data;

    if (scrollbarThemeData == null || !scrollbarThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      scrollbarThemeData ??= themeData.scrollbarTheme;

      final ColorScheme colorScheme = themeData.colorScheme;

      final HSLColor color = scrollbarThemeData.color ?? colorScheme.shade[40];

      final HSLColor hoverColor =
          scrollbarThemeData.hoverColor ?? colorScheme.shade[50];

      final HSLColor highlightColor =
          scrollbarThemeData.color ?? colorScheme.shade[60];

      final HSLColor foreground =
          scrollbarThemeData.foreground ?? colorScheme.shade[100];

      final HSLColor inhoverColor =
          scrollbarThemeData.hoverColor ?? colorScheme.shade[70];

      final HSLColor disabledColor =
          scrollbarThemeData.disabledColor ?? colorScheme.disabled;

      scrollbarThemeData = scrollbarThemeData.copyWith(
        disabledColor: disabledColor,
        color: color,
        foreground: foreground,
        hoverColor: hoverColor,
        inhoverColor: inhoverColor,
        highlightColor: highlightColor,
      );
    }

    assert(scrollbarThemeData.isConcrete);

    return scrollbarThemeData;
  }

  @override
  bool updateShouldNotify(ScrollbarTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ScrollbarTheme? scrollbarTheme =
        context.findAncestorWidgetOfExactType<ScrollbarTheme>();
    return identical(this, scrollbarTheme)
        ? child
        : ScrollbarTheme(data: data, child: child);
  }
}
