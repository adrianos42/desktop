import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';

const double _kNavWidth = 36.0;
const double _kNavHeight = 40.0;
const double _kPadding = 8.0;
const double _kSideWidth = 2.0;
const double _kNavItemsSpacing = 8.0;

const Duration _kChangeDuration = Duration(milliseconds: 200);

@immutable
class NavThemeData {
  const NavThemeData({
    this.colorScheme,
    this.indicatorWidth = _kSideWidth,
    this.width = _kNavWidth,
    this.height = _kNavHeight,
    this.itemsSpacing = _kNavItemsSpacing,
    this.animationDuration = _kChangeDuration,
  });

  //Color get background => const Color(0x000D0D0D);

  Color? get foreground => null;

  IconThemeData get iconThemeData => IconThemeData(size: width - _kPadding * 2);

  // The space between items inside the navbar
  // In this order
  // - The back button does not have it.
  // - If it has a leading menu, as a top or left padding.
  // - The navigation items have at both side.
  // - If it has a trailing menu, as a bottom or right padding.
  final double itemsSpacing;

  // final Color _background;

  // final Color _foreground;

  final ColorScheme? colorScheme;

  final double width;

  final double height;

  final double indicatorWidth;

  final Duration animationDuration;

  NavThemeData copyWidth({
    //Color background,
    //Color foreground,
    double? itemsSpacing,
    double? width,
    double? height,
    double? indicatorWidth,
    Duration? animationDuration,
    ColorScheme? colorScheme,
  }) {
    return NavThemeData(
//      background: background ?? this.background,
      //    foreground: foreground ?? this.foreground,
      itemsSpacing: itemsSpacing ?? this.itemsSpacing,
      colorScheme: colorScheme ?? this.colorScheme,
      width: width ?? this.width,
      height: height ?? this.height,
      indicatorWidth: indicatorWidth ?? this.indicatorWidth,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  int get hashCode {
    return Object.hash(
      //  _background,
      //_foreground,
      itemsSpacing,
      indicatorWidth,
      width,
      height,
      animationDuration,
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
    return other is NavThemeData &&
        //other._background == _background &&
        //other._foreground == _foreground &&
        other.itemsSpacing == itemsSpacing &&
        other.indicatorWidth == indicatorWidth &&
        other.width == width &&
        other.height == height &&
        other.animationDuration == animationDuration;
  }
}

@immutable
class NavTheme extends InheritedTheme {
  const NavTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  final NavThemeData data;

  static NavThemeData of(BuildContext context) {
    final NavTheme? navTheme =
        context.dependOnInheritedWidgetOfExactType<NavTheme>();
    NavThemeData? navThemeData = navTheme?.data;

    if (navThemeData == null || navThemeData.colorScheme == null) {
      final ThemeData themeData = Theme.of(context);
      navThemeData ??= themeData.navTheme;
      if (navThemeData.colorScheme == null) {
        navThemeData =
            navThemeData.copyWidth(colorScheme: themeData.colorScheme);
      }
    }

    return navThemeData;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final NavTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<NavTheme>();
    return identical(this, ancestorTheme)
        ? child
        : NavTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(NavTheme oldWidget) => data != oldWidget.data;
}
