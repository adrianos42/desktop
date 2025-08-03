// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Drawer].
@immutable
class DrawerThemeData {
  /// Creates a [DrawerThemeData].
  const DrawerThemeData({
    this.constraints,
    this.menuPadding,
    this.menuSpacing,
    this.titlePadding,
    this.bodyPadding,
    this.background,
    this.barrierColor,
    this.titleTextStyle,
    this.bodyTextAlign,
    this.imageFilter,
  });

  /// The [BoxConstraints] of the [Drawer].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// BoxConstraints.tightFor(width: 400.0)
  /// ```
  final BoxConstraints? constraints;

  /// The [EdgeInsets] padding of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0)
  /// ```
  final EdgeInsets? menuPadding;

  /// The spacing the menu items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 16.0
  /// ```
  final double? menuSpacing;

  /// The title [EdgeInsets] padding of the title.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0)
  /// ```
  final EdgeInsets? titlePadding;

  /// The body [EdgeInsets] padding of the body.
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.all(16.0)
  /// ```
  final EdgeInsets? bodyPadding;

  /// The background color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? background;

  /// The barrier color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20].withValues(alpha: (0.8)
  /// ```
  final Color? barrierColor;

  /// The [TextStyle] for the title.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.title
  /// ```
  final TextStyle? titleTextStyle;

  /// The [TextAlign] of the body text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// TextAlign.left
  /// ```
  final TextAlign? bodyTextAlign;

  /// The [ImageFilter] used for the drawer`s barrier.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0)
  /// ```
  final ImageFilter? imageFilter;

  /// Makes a copy of [DrawerThemeData] overwriting selected fields.
  DrawerThemeData copyWith({
    BoxConstraints? constraints,
    EdgeInsets? menuPadding,
    double? menuSpacing,
    EdgeInsets? titlePadding,
    EdgeInsets? bodyPadding,
    Color? background,
    Color? barrierColor,
    TextStyle? titleTextStyle,
    TextAlign? bodyTextAlign,
    ImageFilter? imageFilter,
  }) {
    return DrawerThemeData(
      constraints: constraints ?? this.constraints,
      menuPadding: menuPadding ?? this.menuPadding,
      menuSpacing: menuSpacing ?? this.menuSpacing,
      titlePadding: titlePadding ?? this.titlePadding,
      bodyPadding: bodyPadding ?? this.bodyPadding,
      background: background ?? this.background,
      barrierColor: barrierColor ?? this.barrierColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      bodyTextAlign: bodyTextAlign ?? this.bodyTextAlign,
      imageFilter: imageFilter ?? this.imageFilter,
    );
  }

  /// Merges the theme data [DrawerThemeData].
  DrawerThemeData merge(DrawerThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      constraints: other.constraints,
      menuPadding: other.menuPadding,
      menuSpacing: other.menuSpacing,
      titlePadding: other.titlePadding,
      bodyPadding: other.bodyPadding,
      background: other.background,
      barrierColor: other.barrierColor,
      titleTextStyle: other.titleTextStyle,
      bodyTextAlign: other.bodyTextAlign,
      imageFilter: other.imageFilter,
    );
  }

  bool get _isConcrete {
    return constraints != null &&
        menuPadding != null &&
        menuSpacing != null &&
        titlePadding != null &&
        bodyPadding != null &&
        background != null &&
        barrierColor != null &&
        titleTextStyle != null &&
        bodyTextAlign != null &&
        imageFilter != null;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      constraints,
      menuPadding,
      menuSpacing,
      titlePadding,
      bodyPadding,
      background,
      barrierColor,
      titleTextStyle,
      bodyTextAlign,
      imageFilter,
    ]);
  }

  @override
  String toString() {
    return r'''
constraints: The [BoxConstraints] of the [Drawer].

 Defaults to:

 ```dart
 BoxConstraints.tightFor(width: 400.0)
 ```;;menuPadding: The [EdgeInsets] padding of the menu.

 Defaults to:

 ```dart
 EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0)
 ```;;menuSpacing: The spacing the menu items.

 Defaults to:

 ```dart
 16.0
 ```;;titlePadding: The title [EdgeInsets] padding of the title.

 Defaults to:

 ```dart
 EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0)
 ```;;bodyPadding: The body [EdgeInsets] padding of the body.
 Defaults to:

 ```dart
 EdgeInsets.all(16.0)
 ```;;background: The background color.

 Defaults to:

 ```dart
 colorScheme.background[0]
 ```;;barrierColor: The barrier color.

 Defaults to:

 ```dart
 colorScheme.background[20].withValues(alpha: (0.8)
 ```;;titleTextStyle: The [TextStyle] for the title.

 Defaults to:

 ```dart
 textTheme.title
 ```;;bodyTextAlign: The [TextAlign] of the body text.

 Defaults to:

 ```dart
 TextAlign.left
 ```;;imageFilter: The [ImageFilter] used for the drawer`s barrier.

 Defaults to:

 ```dart
 ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0)
 ```;;
''';
  }

  @override
  bool operator ==(covariant DrawerThemeData other) {
    return identical(this, other) ||
        other.constraints == constraints &&
            other.menuPadding == menuPadding &&
            other.menuSpacing == menuSpacing &&
            other.titlePadding == titlePadding &&
            other.bodyPadding == bodyPadding &&
            other.background == background &&
            other.barrierColor == barrierColor &&
            other.titleTextStyle == titleTextStyle &&
            other.bodyTextAlign == bodyTextAlign &&
            other.imageFilter == imageFilter;
  }
}

/// Inherited theme for [DrawerThemeData].
@immutable
class DrawerTheme extends InheritedTheme {
  /// Creates a [DrawerTheme].
  const DrawerTheme({super.key, required super.child, required this.data});

  /// The data representing this [DrawerTheme].
  final DrawerThemeData data;

  /// Merges the nearest [DrawerTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required DrawerThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) =>
          DrawerTheme(data: DrawerTheme.of(context).merge(data), child: child),
    );
  }

  /// Makes a copy of the nearest [DrawerTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    BoxConstraints? constraints,
    EdgeInsets? menuPadding,
    double? menuSpacing,
    EdgeInsets? titlePadding,
    EdgeInsets? bodyPadding,
    Color? background,
    Color? barrierColor,
    TextStyle? titleTextStyle,
    TextAlign? bodyTextAlign,
    ImageFilter? imageFilter,
  }) {
    return Builder(
      key: key,
      builder: (context) => DrawerTheme(
        data: DrawerTheme.of(context).copyWith(
          constraints: constraints,
          menuPadding: menuPadding,
          menuSpacing: menuSpacing,
          titlePadding: titlePadding,
          bodyPadding: bodyPadding,
          background: background,
          barrierColor: barrierColor,
          titleTextStyle: titleTextStyle,
          bodyTextAlign: bodyTextAlign,
          imageFilter: imageFilter,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [DrawerTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final DrawerTheme? drawerTheme = context
        .findAncestorWidgetOfExactType<DrawerTheme>();
    return identical(this, drawerTheme)
        ? child
        : DrawerTheme(data: data, child: child);
  }

  /// Returns the nearest [DrawerTheme].
  static DrawerThemeData of(BuildContext context) {
    final DrawerTheme? drawerTheme = context
        .dependOnInheritedWidgetOfExactType<DrawerTheme>();
    DrawerThemeData? drawerThemeData = drawerTheme?.data;

    if (drawerThemeData == null || !drawerThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      drawerThemeData ??= themeData.drawerTheme;

      final drawerValue = _DrawerThemeData(themeData);

      final BoxConstraints constraints =
          drawerThemeData.constraints ?? drawerValue.constraints;
      final EdgeInsets menuPadding =
          drawerThemeData.menuPadding ?? drawerValue.menuPadding;
      final double menuSpacing =
          drawerThemeData.menuSpacing ?? drawerValue.menuSpacing;
      final EdgeInsets titlePadding =
          drawerThemeData.titlePadding ?? drawerValue.titlePadding;
      final EdgeInsets bodyPadding =
          drawerThemeData.bodyPadding ?? drawerValue.bodyPadding;
      final Color background =
          drawerThemeData.background ?? drawerValue.background;
      final Color barrierColor =
          drawerThemeData.barrierColor ?? drawerValue.barrierColor;
      final TextStyle titleTextStyle =
          drawerThemeData.titleTextStyle ?? drawerValue.titleTextStyle;
      final TextAlign bodyTextAlign =
          drawerThemeData.bodyTextAlign ?? drawerValue.bodyTextAlign;
      final ImageFilter imageFilter =
          drawerThemeData.imageFilter ?? drawerValue.imageFilter;

      return drawerThemeData.copyWith(
        constraints: constraints,
        menuPadding: menuPadding,
        menuSpacing: menuSpacing,
        titlePadding: titlePadding,
        bodyPadding: bodyPadding,
        background: background,
        barrierColor: barrierColor,
        titleTextStyle: titleTextStyle,
        bodyTextAlign: bodyTextAlign,
        imageFilter: imageFilter,
      );
    }

    assert(drawerThemeData._isConcrete);

    return drawerThemeData;
  }

  @override
  bool updateShouldNotify(DrawerTheme oldWidget) => data != oldWidget.data;
}
