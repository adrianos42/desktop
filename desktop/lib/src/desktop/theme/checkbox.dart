import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';
import 'theme_text.dart';
import 'constants.dart';

@immutable
class CheckboxThemeData {
  const CheckboxThemeData({
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

  CheckboxThemeData copyWith({
    HSLColor? disabledColor,
    HSLColor? activeColor,
    HSLColor? foreground,
    HSLColor? activeHoverColor,
    HSLColor? inactiveColor,
    HSLColor? inactiveHoverColor,
  }) {
    return CheckboxThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      foreground: foreground ?? this.foreground,
      activeHoverColor: activeHoverColor ?? this.activeHoverColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      inactiveHoverColor: inactiveHoverColor ?? this.inactiveHoverColor,
    );
  }

  CheckboxThemeData merge(CheckboxThemeData? other) {
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
    return other is CheckboxThemeData &&
        other.disabledColor == disabledColor &&
        other.activeColor == activeColor &&
        other.activeHoverColor == activeHoverColor &&
        other.inactiveHoverColor == inactiveHoverColor &&
        other.inactiveColor == inactiveColor &&
        other.activeHoverColor == activeHoverColor &&
        other.foreground == foreground;
  }
}

@immutable
class CheckboxTheme extends InheritedTheme {
  const CheckboxTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final CheckboxThemeData data;

  static Widget merge({
    Key? key,
    required CheckboxThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (context) => CheckboxTheme(
        key: key,
        data: CheckboxTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  static CheckboxThemeData of(BuildContext context) {
    final CheckboxTheme? checkboxTheme =
        context.dependOnInheritedWidgetOfExactType<CheckboxTheme>();
    CheckboxThemeData? checkboxThemeData = checkboxTheme?.data;

    if (checkboxThemeData == null || !checkboxThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      checkboxThemeData ??= themeData.checkboxTheme;

      final ColorScheme colorScheme = themeData.colorScheme;
      // final TextTheme textTheme = Theme.of(context).textTheme; // TODO(as): ???

      final HSLColor foreground =
          checkboxThemeData.foreground ?? colorScheme.background[0];

      final HSLColor activeHoverColor = checkboxThemeData.activeHoverColor ??
          colorScheme.shade[kHoverColorIndex];

      final HSLColor activeColor = checkboxThemeData.activeColor ??
          colorScheme.primary[kHighlightColorIndex];

      final HSLColor inactiveHoverColor =
          checkboxThemeData.inactiveHoverColor ??
              colorScheme.shade[kHoverColorIndex];

      final HSLColor inactiveColor = checkboxThemeData.inactiveColor ??
          colorScheme.shade[kInactiveColorIndex];

      final HSLColor disabledColor =
          checkboxThemeData.disabledColor ?? colorScheme.disabled;

      checkboxThemeData = checkboxThemeData.copyWith(
        disabledColor: disabledColor,
        activeColor: activeColor,
        foreground: foreground,
        activeHoverColor: activeHoverColor,
        inactiveHoverColor: inactiveHoverColor,
        inactiveColor: inactiveColor,
      );
    }

    assert(checkboxThemeData.isConcrete);

    return checkboxThemeData;
  }

  @override
  bool updateShouldNotify(CheckboxTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final CheckboxTheme? checkboxTheme =
        context.findAncestorWidgetOfExactType<CheckboxTheme>();
    return identical(this, checkboxTheme)
        ? child
        : CheckboxTheme(data: data, child: child);
  }
}
