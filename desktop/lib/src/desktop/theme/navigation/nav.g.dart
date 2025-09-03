// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Nav].
@immutable
class NavThemeData {
  /// Creates a [NavThemeData].
  const NavThemeData({
    this.iconThemeData,
    this.itemSpacing,
    this.verticalItemSpacing,
    this.width,
    this.height,
    this.indicatorWidth,
    this.animationDuration,
    this.navBarBackgroundColor,
    this.menuTransitionDuration,
    this.menuTrasitionCurve,
    this.menuTrasitionReverseCurve,
  });

  /// The [IconThemeData] for the nav items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: width - 8.0 * 2.0)
  /// ```
  final IconThemeData? iconThemeData;

  /// The space between items inside the navbar.
  ///
  /// In this order:
  /// - The back button does not have it.
  /// - If it has a leading menu, as a top or left padding.
  /// - The navigation items have at both side.
  /// - If it has a trailing menu, as a bottom or right padding.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 8.0
  /// ```
  final double? itemSpacing;

  /// The space between items inside the axis is vertical.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 12.0
  /// ```
  final double? verticalItemSpacing;

  /// The width of the nab bar when the axis is [Axis.horizontal].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 36.0
  /// ```
  final double? width;

  /// The height of the nav when the axis is [Axis.vertical].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 40.0
  /// ```
  final double? height;

  /// The width of the indicator.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0
  /// ```
  final double? indicatorWidth;

  /// The animation [Duration] for the nav items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 200)
  /// ```
  final Duration? animationDuration;

  /// The background of the nav bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? navBarBackgroundColor;

  /// The duration of the menu transition.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Duration(milliseconds: 400)
  /// ```
  final Duration? menuTransitionDuration;

  /// The animation curve of the menu transition.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Curves.fastEaseInToSlowEaseOut
  /// ```
  final Curve? menuTrasitionCurve;

  /// The animation reverse curve of the menu transition.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// Curves.fastEaseInToSlowEaseOut.flipped
  /// ```
  final Curve? menuTrasitionReverseCurve;

  /// Makes a copy of [NavThemeData] overwriting selected fields.
  NavThemeData copyWith({
    IconThemeData? iconThemeData,
    double? itemSpacing,
    double? verticalItemSpacing,
    double? width,
    double? height,
    double? indicatorWidth,
    Duration? animationDuration,
    Color? navBarBackgroundColor,
    Duration? menuTransitionDuration,
    Curve? menuTrasitionCurve,
    Curve? menuTrasitionReverseCurve,
  }) {
    return NavThemeData(
      iconThemeData: iconThemeData ?? this.iconThemeData,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      verticalItemSpacing: verticalItemSpacing ?? this.verticalItemSpacing,
      width: width ?? this.width,
      height: height ?? this.height,
      indicatorWidth: indicatorWidth ?? this.indicatorWidth,
      animationDuration: animationDuration ?? this.animationDuration,
      navBarBackgroundColor:
          navBarBackgroundColor ?? this.navBarBackgroundColor,
      menuTransitionDuration:
          menuTransitionDuration ?? this.menuTransitionDuration,
      menuTrasitionCurve: menuTrasitionCurve ?? this.menuTrasitionCurve,
      menuTrasitionReverseCurve:
          menuTrasitionReverseCurve ?? this.menuTrasitionReverseCurve,
    );
  }

  /// Merges the theme data [NavThemeData].
  NavThemeData merge(NavThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      iconThemeData: other.iconThemeData,
      itemSpacing: other.itemSpacing,
      verticalItemSpacing: other.verticalItemSpacing,
      width: other.width,
      height: other.height,
      indicatorWidth: other.indicatorWidth,
      animationDuration: other.animationDuration,
      navBarBackgroundColor: other.navBarBackgroundColor,
      menuTransitionDuration: other.menuTransitionDuration,
      menuTrasitionCurve: other.menuTrasitionCurve,
      menuTrasitionReverseCurve: other.menuTrasitionReverseCurve,
    );
  }

  bool get _isConcrete {
    return iconThemeData != null &&
        itemSpacing != null &&
        verticalItemSpacing != null &&
        width != null &&
        height != null &&
        indicatorWidth != null &&
        animationDuration != null &&
        navBarBackgroundColor != null &&
        menuTransitionDuration != null &&
        menuTrasitionCurve != null &&
        menuTrasitionReverseCurve != null;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      iconThemeData,
      itemSpacing,
      verticalItemSpacing,
      width,
      height,
      indicatorWidth,
      animationDuration,
      navBarBackgroundColor,
      menuTransitionDuration,
      menuTrasitionCurve,
      menuTrasitionReverseCurve,
    ]);
  }

  @override
  String toString() {
    return r'''
iconThemeData: The [IconThemeData] for the nav items.

 Defaults to:

 ```dart
 IconThemeData(size: width - 8.0 * 2.0)
 ```;;itemSpacing: The space between items inside the navbar.

 In this order:
 - The back button does not have it.
 - If it has a leading menu, as a top or left padding.
 - The navigation items have at both side.
 - If it has a trailing menu, as a bottom or right padding.

 Defaults to:

 ```dart
 8.0
 ```;;verticalItemSpacing: The space between items inside the axis is vertical.

 Defaults to:

 ```dart
 12.0
 ```;;width: The width of the nab bar when the axis is [Axis.horizontal].

 Defaults to:

 ```dart
 36.0
 ```;;height: The height of the nav when the axis is [Axis.vertical].

 Defaults to:

 ```dart
 40.0
 ```;;indicatorWidth: The width of the indicator.

 Defaults to:

 ```dart
 2.0
 ```;;animationDuration: The animation [Duration] for the nav items.

 Defaults to:

 ```dart
 Duration(milliseconds: 200)
 ```;;navBarBackgroundColor: The background of the nav bar.

 Defaults to:

 ```dart
 colorScheme.background[0]
 ```;;menuTransitionDuration: The duration of the menu transition.

 Defaults to:

 ```dart
 Duration(milliseconds: 400)
 ```;;menuTrasitionCurve: The animation curve of the menu transition.

 Defaults to:

 ```dart
 Curves.fastEaseInToSlowEaseOut
 ```;;menuTrasitionReverseCurve: The animation reverse curve of the menu transition.

 Defaults to:

 ```dart
 Curves.fastEaseInToSlowEaseOut.flipped
 ```;;
''';
  }

  @override
  bool operator ==(covariant NavThemeData other) {
    return identical(this, other) ||
        other.iconThemeData == iconThemeData &&
            other.itemSpacing == itemSpacing &&
            other.verticalItemSpacing == verticalItemSpacing &&
            other.width == width &&
            other.height == height &&
            other.indicatorWidth == indicatorWidth &&
            other.animationDuration == animationDuration &&
            other.navBarBackgroundColor == navBarBackgroundColor &&
            other.menuTransitionDuration == menuTransitionDuration &&
            other.menuTrasitionCurve == menuTrasitionCurve &&
            other.menuTrasitionReverseCurve == menuTrasitionReverseCurve;
  }
}

/// Inherited theme for [NavThemeData].
@immutable
class NavTheme extends InheritedTheme {
  /// Creates a [NavTheme].
  const NavTheme({super.key, required this.data, required super.child});

  /// The data representing this [NavTheme].
  final NavThemeData data;

  /// Merges the nearest [NavTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required NavThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) =>
          NavTheme(data: NavTheme.of(context).merge(data), child: child),
    );
  }

  /// Makes a copy of the nearest [NavTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    IconThemeData? iconThemeData,
    double? itemSpacing,
    double? verticalItemSpacing,
    double? width,
    double? height,
    double? indicatorWidth,
    Duration? animationDuration,
    Color? navBarBackgroundColor,
    Duration? menuTransitionDuration,
    Curve? menuTrasitionCurve,
    Curve? menuTrasitionReverseCurve,
  }) {
    return Builder(
      key: key,
      builder: (context) => NavTheme(
        data: NavTheme.of(context).copyWith(
          iconThemeData: iconThemeData,
          itemSpacing: itemSpacing,
          verticalItemSpacing: verticalItemSpacing,
          width: width,
          height: height,
          indicatorWidth: indicatorWidth,
          animationDuration: animationDuration,
          navBarBackgroundColor: navBarBackgroundColor,
          menuTransitionDuration: menuTransitionDuration,
          menuTrasitionCurve: menuTrasitionCurve,
          menuTrasitionReverseCurve: menuTrasitionReverseCurve,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [NavTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final NavTheme? navTheme = context
        .findAncestorWidgetOfExactType<NavTheme>();
    return identical(this, navTheme)
        ? child
        : NavTheme(data: data, child: child);
  }

  /// Returns the nearest [NavTheme].
  static NavThemeData of(BuildContext context) {
    final NavTheme? navTheme = context
        .dependOnInheritedWidgetOfExactType<NavTheme>();
    NavThemeData? navThemeData = navTheme?.data;

    if (navThemeData == null || !navThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      navThemeData ??= themeData.navTheme;

      final navValue = _NavThemeData(themeData);

      final IconThemeData iconThemeData =
          navThemeData.iconThemeData ?? navValue.iconThemeData;
      final double itemSpacing =
          navThemeData.itemSpacing ?? navValue.itemSpacing;
      final double verticalItemSpacing =
          navThemeData.verticalItemSpacing ?? navValue.verticalItemSpacing;
      final double width = navThemeData.width ?? navValue.width;
      final double height = navThemeData.height ?? navValue.height;
      final double indicatorWidth =
          navThemeData.indicatorWidth ?? navValue.indicatorWidth;
      final Duration animationDuration =
          navThemeData.animationDuration ?? navValue.animationDuration;
      final Color navBarBackgroundColor =
          navThemeData.navBarBackgroundColor ?? navValue.navBarBackgroundColor;
      final Duration menuTransitionDuration =
          navThemeData.menuTransitionDuration ??
          navValue.menuTransitionDuration;
      final Curve menuTrasitionCurve =
          navThemeData.menuTrasitionCurve ?? navValue.menuTrasitionCurve;
      final Curve menuTrasitionReverseCurve =
          navThemeData.menuTrasitionReverseCurve ??
          navValue.menuTrasitionReverseCurve;

      return navThemeData.copyWith(
        iconThemeData: iconThemeData,
        itemSpacing: itemSpacing,
        verticalItemSpacing: verticalItemSpacing,
        width: width,
        height: height,
        indicatorWidth: indicatorWidth,
        animationDuration: animationDuration,
        navBarBackgroundColor: navBarBackgroundColor,
        menuTransitionDuration: menuTransitionDuration,
        menuTrasitionCurve: menuTrasitionCurve,
        menuTrasitionReverseCurve: menuTrasitionReverseCurve,
      );
    }

    assert(navThemeData._isConcrete);

    return navThemeData;
  }

  @override
  bool updateShouldNotify(NavTheme oldWidget) => data != oldWidget.data;
}
