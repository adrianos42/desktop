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
    this.itemsSpacing,
    this.width,
    this.height,
    this.indicatorWidth,
    this.animationDuration,
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
  final double? itemsSpacing;

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

  /// Makes a copy of [NavThemeData] overwriting selected fields.
  NavThemeData copyWith({
    IconThemeData? iconThemeData,
    double? itemsSpacing,
    double? width,
    double? height,
    double? indicatorWidth,
    Duration? animationDuration,
  }) {
    return NavThemeData(
      iconThemeData: iconThemeData ?? this.iconThemeData,
      itemsSpacing: itemsSpacing ?? this.itemsSpacing,
      width: width ?? this.width,
      height: height ?? this.height,
      indicatorWidth: indicatorWidth ?? this.indicatorWidth,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  /// Merges the theme data [NavThemeData].
  NavThemeData merge(NavThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      iconThemeData: other.iconThemeData,
      itemsSpacing: other.itemsSpacing,
      width: other.width,
      height: other.height,
      indicatorWidth: other.indicatorWidth,
      animationDuration: other.animationDuration,
    );
  }

  bool get _isConcrete {
    return iconThemeData != null &&
        itemsSpacing != null &&
        width != null &&
        height != null &&
        indicatorWidth != null &&
        animationDuration != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      iconThemeData,
      itemsSpacing,
      width,
      height,
      indicatorWidth,
      animationDuration,
    );
  }

  @override
  String toString() {
    return r'''
iconThemeData: The [IconThemeData] for the nav items.

 Defaults to:

 ```dart
 IconThemeData(size: width - 8.0 * 2.0)
 ```;;itemsSpacing: The space between items inside the navbar.

 In this order:
 - The back button does not have it.
 - If it has a leading menu, as a top or left padding.
 - The navigation items have at both side.
 - If it has a trailing menu, as a bottom or right padding.

 Defaults to:

 ```dart
 8.0
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
 ```;;
''';
  }

  @override
  bool operator ==(covariant NavThemeData other) {
    return identical(this, other) ||
        other.iconThemeData == iconThemeData &&
            other.itemsSpacing == itemsSpacing &&
            other.width == width &&
            other.height == height &&
            other.indicatorWidth == indicatorWidth &&
            other.animationDuration == animationDuration;
  }
}

/// Inherited theme for [NavThemeData].
@immutable
class NavTheme extends InheritedTheme {
  /// Creates a [NavTheme].
  const NavTheme({
    super.key,
    required super.child,
    required this.data,
  });

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
      builder: (context) => NavTheme(
        data: NavTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [NavTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    IconThemeData? iconThemeData,
    double? itemsSpacing,
    double? width,
    double? height,
    double? indicatorWidth,
    Duration? animationDuration,
  }) {
    return Builder(
      key: key,
      builder: (context) => NavTheme(
        data: NavTheme.of(context).copyWith(
          iconThemeData: iconThemeData,
          itemsSpacing: itemsSpacing,
          width: width,
          height: height,
          indicatorWidth: indicatorWidth,
          animationDuration: animationDuration,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [NavTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final NavTheme? navTheme =
        context.findAncestorWidgetOfExactType<NavTheme>();
    return identical(this, navTheme)
        ? child
        : NavTheme(data: data, child: child);
  }

  /// Returns the nearest [NavTheme].
  static NavThemeData of(BuildContext context) {
    final NavTheme? navTheme =
        context.dependOnInheritedWidgetOfExactType<NavTheme>();
    NavThemeData? navThemeData = navTheme?.data;

    if (navThemeData == null || !navThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      navThemeData ??= themeData.navTheme;

      final _navThemeData =
          _NavThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final IconThemeData iconThemeData =
          navThemeData.iconThemeData ?? _navThemeData.iconThemeData;
      final double itemsSpacing =
          navThemeData.itemsSpacing ?? _navThemeData.itemsSpacing;
      final double width = navThemeData.width ?? _navThemeData.width;
      final double height = navThemeData.height ?? _navThemeData.height;
      final double indicatorWidth =
          navThemeData.indicatorWidth ?? _navThemeData.indicatorWidth;
      final Duration animationDuration =
          navThemeData.animationDuration ?? _navThemeData.animationDuration;

      return navThemeData.copyWith(
        iconThemeData: iconThemeData,
        itemsSpacing: itemsSpacing,
        width: width,
        height: height,
        indicatorWidth: indicatorWidth,
        animationDuration: animationDuration,
      );
    }

    assert(navThemeData._isConcrete);

    return navThemeData;
  }

  @override
  bool updateShouldNotify(NavTheme oldWidget) => data != oldWidget.data;
}
