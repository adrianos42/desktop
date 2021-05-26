import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';
import 'theme_text.dart';
import 'constants.dart';

@immutable
class ToggleSwitchThemeData {
  const ToggleSwitchThemeData({
    this.disabledColor,
    this.activeColor,
    this.foreground,
    this.activeHoverColor,
    this.inactiveColor,
    this.inactiveHoverColor,
  });

  final HSLColor? disabledColor;

  final HSLColor? activeColor;

  final HSLColor? activeHoverColor;

  final HSLColor? inactiveColor;

  final HSLColor? inactiveHoverColor;

  final HSLColor? foreground;

  ToggleSwitchThemeData copyWith({
    HSLColor? disabledColor,
    HSLColor? activeColor,
    HSLColor? foreground,
    HSLColor? activeHoverColor,
    HSLColor? inactiveColor,
    HSLColor? inactiveHoverColor,
  }) {
    return ToggleSwitchThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      foreground: foreground ?? this.foreground,
      activeHoverColor: activeHoverColor ?? this.activeHoverColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      inactiveHoverColor: inactiveHoverColor ?? this.inactiveHoverColor,
    );
  }

  ToggleSwitchThemeData merge(ToggleSwitchThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      disabledColor: other.disabledColor,
      activeColor: other.activeColor,
      foreground: other.foreground,
      activeHoverColor: other.activeHoverColor,
      inactiveColor: other.inactiveColor,
      inactiveHoverColor: inactiveHoverColor,
    );
  }

  bool get isConcrete {
    return disabledColor != null &&
        activeColor != null &&
        activeHoverColor != null &&
        inactiveHoverColor != null &&
        inactiveColor != null &&
        foreground != null;
  }

  @override
  int get hashCode {
    return hashValues(
      disabledColor,
      activeColor,
      foreground,
      activeHoverColor,
      inactiveColor,
      inactiveHoverColor,
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
    return other is ToggleSwitchThemeData &&
        other.disabledColor == disabledColor &&
        other.activeColor == activeColor &&
        other.activeHoverColor == activeHoverColor &&
        other.inactiveHoverColor == inactiveHoverColor &&
        other.inactiveColor == inactiveColor &&
        other.foreground == foreground;
  }
}

@immutable
class ToggleSwitchTheme extends InheritedTheme {
  const ToggleSwitchTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final ToggleSwitchThemeData data;

  static Widget merge({
    Key? key,
    required ToggleSwitchThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (context) => ToggleSwitchTheme(
        key: key,
        data: ToggleSwitchTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  static ToggleSwitchThemeData of(BuildContext context) {
    final ToggleSwitchTheme? toggleSwitchTheme =
        context.dependOnInheritedWidgetOfExactType<ToggleSwitchTheme>();
    ToggleSwitchThemeData? toggleSwitchThemeData = toggleSwitchTheme?.data;

    if (toggleSwitchThemeData == null || !toggleSwitchThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      toggleSwitchThemeData ??= themeData.toggleSwitchTheme;

      final ColorScheme colorScheme = Theme.of(context).colorScheme;

      final HSLColor foreground = toggleSwitchThemeData.foreground ??
          colorScheme.shade[kHoverColorIndex];

      final HSLColor activeHoverColor =
          toggleSwitchThemeData.activeHoverColor ??
              colorScheme.shade[kHoverColorIndex];

      final HSLColor activeColor = toggleSwitchThemeData.activeColor ??
          colorScheme.primary[kHighlightColorIndex];

      final HSLColor inactiveHoverColor =
          toggleSwitchThemeData.inactiveHoverColor ??
              colorScheme.shade[kHoverColorIndex];

      final HSLColor inactiveColor = toggleSwitchThemeData.inactiveColor ??
          colorScheme.shade[kInactiveColorIndex];

      final HSLColor disabledColor =
          toggleSwitchThemeData.disabledColor ?? colorScheme.disabled;

      toggleSwitchThemeData = toggleSwitchThemeData.copyWith(
        disabledColor: disabledColor,
        activeColor: activeColor,
        foreground: foreground,
        activeHoverColor: activeHoverColor,
        inactiveHoverColor: inactiveHoverColor,
        inactiveColor: inactiveColor,
      );
    }

    assert(toggleSwitchThemeData.isConcrete);

    return toggleSwitchThemeData;
  }

  @override
  bool updateShouldNotify(ToggleSwitchTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ToggleSwitchTheme? toggleSwitchTheme =
        context.findAncestorWidgetOfExactType<ToggleSwitchTheme>();
    return identical(this, toggleSwitchTheme)
        ? child
        : ToggleSwitchTheme(data: data, child: child);
  }
}
