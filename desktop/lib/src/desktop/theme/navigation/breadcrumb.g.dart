// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breadcrumb.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Breadcrumb].
@immutable
class BreadcrumbThemeData {
  /// Creates a [BreadcrumbThemeData].
  const BreadcrumbThemeData({
    this.padding,
    this.height,
    this.itemSpacing,
    this.color,
    this.iconTheme,
    this.textStyle,
    this.backgroundColor,
    this.highlightColor,
  });

  /// The padding for the breadcrumb.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.symmetric(horizontal: 8.0)
  /// ```
  final EdgeInsets? padding;

  /// The height of the breadcrumb.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 36.0
  /// ```
  final double? height;

  /// The space between items inside the breadcrumb.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0
  /// ```
  final double? itemSpacing;

  /// The color of the breadcrumb text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? color;

  /// The theme for the breadcrumb icon.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: 20.0)
  /// ```
  final IconThemeData? iconTheme;

  /// The style for the text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: kDefaultFontSize, overflow: TextOverflow.ellipsis)
  /// ```
  final TextStyle? textStyle;

  /// The background color of the breadcrumb.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? backgroundColor;

  /// The color of the breadcrumb items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textPrimaryHigh
  /// ```
  final Color? highlightColor;

  /// Makes a copy of [BreadcrumbThemeData] overwriting selected fields.
  BreadcrumbThemeData copyWith({
    EdgeInsets? padding,
    double? height,
    double? itemSpacing,
    Color? color,
    IconThemeData? iconTheme,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? highlightColor,
  }) {
    return BreadcrumbThemeData(
      padding: padding ?? this.padding,
      height: height ?? this.height,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      color: color ?? this.color,
      iconTheme: iconTheme ?? this.iconTheme,
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  /// Merges the theme data [BreadcrumbThemeData].
  BreadcrumbThemeData merge(BreadcrumbThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      padding: other.padding,
      height: other.height,
      itemSpacing: other.itemSpacing,
      color: other.color,
      iconTheme: other.iconTheme,
      textStyle: other.textStyle,
      backgroundColor: other.backgroundColor,
      highlightColor: other.highlightColor,
    );
  }

  bool get _isConcrete {
    return padding != null &&
        height != null &&
        itemSpacing != null &&
        color != null &&
        iconTheme != null &&
        textStyle != null &&
        backgroundColor != null &&
        highlightColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      padding,
      height,
      itemSpacing,
      color,
      iconTheme,
      textStyle,
      backgroundColor,
      highlightColor,
    );
  }

  @override
  String toString() {
    return r'''
padding: The padding for the breadcrumb.

 Defaults to:

 ```dart
 EdgeInsets.symmetric(horizontal: 8.0)
 ```;;height: The height of the breadcrumb.

 Defaults to:

 ```dart
 36.0
 ```;;itemSpacing: The space between items inside the breadcrumb.

 Defaults to:

 ```dart
 2.0
 ```;;color: The color of the breadcrumb text.

 Defaults to:

 ```dart
 textTheme.textLow
 ```;;iconTheme: The theme for the breadcrumb icon.

 Defaults to:

 ```dart
 IconThemeData(size: 20.0)
 ```;;textStyle: The style for the text.

 Defaults to:

 ```dart
 textTheme.body2.copyWith(fontSize: kDefaultFontSize, overflow: TextOverflow.ellipsis)
 ```;;backgroundColor: The background color of the breadcrumb.

 Defaults to:

 ```dart
 colorScheme.background[0]
 ```;;highlightColor: The color of the breadcrumb items.

 Defaults to:

 ```dart
 textTheme.textPrimaryHigh
 ```;;
''';
  }

  @override
  bool operator ==(covariant BreadcrumbThemeData other) {
    return identical(this, other) ||
        other.padding == padding &&
            other.height == height &&
            other.itemSpacing == itemSpacing &&
            other.color == color &&
            other.iconTheme == iconTheme &&
            other.textStyle == textStyle &&
            other.backgroundColor == backgroundColor &&
            other.highlightColor == highlightColor;
  }
}

/// Inherited theme for [BreadcrumbThemeData].
@immutable
class BreadcrumbTheme extends InheritedTheme {
  /// Creates a [BreadcrumbTheme].
  const BreadcrumbTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [BreadcrumbTheme].
  final BreadcrumbThemeData data;

  /// Merges the nearest [BreadcrumbTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required BreadcrumbThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => BreadcrumbTheme(
        data: BreadcrumbTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [BreadcrumbTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    double? height,
    double? itemSpacing,
    Color? color,
    IconThemeData? iconTheme,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? highlightColor,
  }) {
    return Builder(
      key: key,
      builder: (context) => BreadcrumbTheme(
        data: BreadcrumbTheme.of(context).copyWith(
          padding: padding,
          height: height,
          itemSpacing: itemSpacing,
          color: color,
          iconTheme: iconTheme,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          highlightColor: highlightColor,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [BreadcrumbTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final BreadcrumbTheme? breadcrumbTheme =
        context.findAncestorWidgetOfExactType<BreadcrumbTheme>();
    return identical(this, breadcrumbTheme)
        ? child
        : BreadcrumbTheme(data: data, child: child);
  }

  /// Returns the nearest [BreadcrumbTheme].
  static BreadcrumbThemeData of(BuildContext context) {
    final BreadcrumbTheme? breadcrumbTheme =
        context.dependOnInheritedWidgetOfExactType<BreadcrumbTheme>();
    BreadcrumbThemeData? breadcrumbThemeData = breadcrumbTheme?.data;

    if (breadcrumbThemeData == null || !breadcrumbThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      breadcrumbThemeData ??= themeData.breadcrumbTheme;

      final _breadcrumbThemeData =
          _BreadcrumbThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final EdgeInsets padding =
          breadcrumbThemeData.padding ?? _breadcrumbThemeData.padding;
      final double height =
          breadcrumbThemeData.height ?? _breadcrumbThemeData.height;
      final double itemSpacing =
          breadcrumbThemeData.itemSpacing ?? _breadcrumbThemeData.itemSpacing;
      final Color color =
          breadcrumbThemeData.color ?? _breadcrumbThemeData.color;
      final IconThemeData iconTheme =
          breadcrumbThemeData.iconTheme ?? _breadcrumbThemeData.iconTheme;
      final TextStyle textStyle =
          breadcrumbThemeData.textStyle ?? _breadcrumbThemeData.textStyle;
      final Color backgroundColor = breadcrumbThemeData.backgroundColor ??
          _breadcrumbThemeData.backgroundColor;
      final Color highlightColor = breadcrumbThemeData.highlightColor ??
          _breadcrumbThemeData.highlightColor;

      return breadcrumbThemeData.copyWith(
        padding: padding,
        height: height,
        itemSpacing: itemSpacing,
        color: color,
        iconTheme: iconTheme,
        textStyle: textStyle,
        backgroundColor: backgroundColor,
        highlightColor: highlightColor,
      );
    }

    assert(breadcrumbThemeData._isConcrete);

    return breadcrumbThemeData;
  }

  @override
  bool updateShouldNotify(BreadcrumbTheme oldWidget) => data != oldWidget.data;
}
