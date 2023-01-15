// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Tab].
@immutable
class TabThemeData {
  /// Creates a [TabThemeData].
  const TabThemeData({
    this.textStyle,
    this.iconThemeData,
    this.itemSpacing,
    this.height,
    this.color,
    this.hoverColor,
    this.backgroundColor,
    this.highlightColor,
  });

  /// The style for the text. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: kDefaultFontSize, overflow: TextOverflow.ellipsis)
  /// ```
  final TextStyle? textStyle;

  /// The theme for the icon. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: kDefaultIconSize)
  /// ```
  final IconThemeData? iconThemeData;

  /// The space between items inside the tab bar, if they are simple text or an icon.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 8.0
  /// ```
  final double? itemSpacing;

  /// The height of the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 36.0
  /// ```
  final double? height;

  /// The color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? color;

  /// The hover color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  final Color? hoverColor;

  /// The background of the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? backgroundColor;

  /// The highlight color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  final Color? highlightColor;

  /// Makes a copy of [TabThemeData] overwriting selected fields.
  TabThemeData copyWith({
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    double? itemSpacing,
    double? height,
    Color? color,
    Color? hoverColor,
    Color? backgroundColor,
    Color? highlightColor,
  }) {
    return TabThemeData(
      textStyle: textStyle ?? this.textStyle,
      iconThemeData: iconThemeData ?? this.iconThemeData,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      height: height ?? this.height,
      color: color ?? this.color,
      hoverColor: hoverColor ?? this.hoverColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  /// Merges the theme data [TabThemeData].
  TabThemeData merge(TabThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textStyle: other.textStyle,
      iconThemeData: other.iconThemeData,
      itemSpacing: other.itemSpacing,
      height: other.height,
      color: other.color,
      hoverColor: other.hoverColor,
      backgroundColor: other.backgroundColor,
      highlightColor: other.highlightColor,
    );
  }

  bool get _isConcrete {
    return textStyle != null &&
        iconThemeData != null &&
        itemSpacing != null &&
        height != null &&
        color != null &&
        hoverColor != null &&
        backgroundColor != null &&
        highlightColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      textStyle,
      iconThemeData,
      itemSpacing,
      height,
      color,
      hoverColor,
      backgroundColor,
      highlightColor,
    );
  }

  @override
  String toString() {
    return r'''
textStyle: The style for the text. The color is ignored.

 Defaults to:

 ```dart
 textTheme.body2.copyWith(fontSize: kDefaultFontSize, overflow: TextOverflow.ellipsis)
 ```;;iconThemeData: The theme for the icon. The color is ignored.

 Defaults to:

 ```dart
 IconThemeData(size: kDefaultIconSize)
 ```;;itemSpacing: The space between items inside the tab bar, if they are simple text or an icon.

 Defaults to:

 ```dart
 8.0
 ```;;height: The height of the tab bar.

 Defaults to:

 ```dart
 36.0
 ```;;color: The color of the tab item.

 Defaults to:

 ```dart
 textTheme.textLow
 ```;;hoverColor: The hover color of the tab item.

 Defaults to:

 ```dart
 colorScheme.shade[100]
 ```;;backgroundColor: The background of the tab bar.

 Defaults to:

 ```dart
 colorScheme.background[0]
 ```;;highlightColor: The highlight color of the tab item.

 Defaults to:

 ```dart
 colorScheme.primary[60]
 ```;;
''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is TabThemeData &&
        other.textStyle == textStyle &&
        other.iconThemeData == iconThemeData &&
        other.itemSpacing == itemSpacing &&
        other.height == height &&
        other.color == color &&
        other.hoverColor == hoverColor &&
        other.backgroundColor == backgroundColor &&
        other.highlightColor == highlightColor;
  }
}

/// Inherited theme for [TabThemeData].
@immutable
class TabTheme extends InheritedTheme {
  /// Creates a [TabTheme].
  const TabTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [TabTheme].
  final TabThemeData data;

  /// Merges the nearest [TabTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required TabThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => TabTheme(
        data: TabTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [TabTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    double? itemSpacing,
    double? height,
    Color? color,
    Color? hoverColor,
    Color? backgroundColor,
    Color? highlightColor,
  }) {
    return Builder(
      key: key,
      builder: (context) => TabTheme(
        data: TabTheme.of(context).copyWith(
          textStyle: textStyle,
          iconThemeData: iconThemeData,
          itemSpacing: itemSpacing,
          height: height,
          color: color,
          hoverColor: hoverColor,
          backgroundColor: backgroundColor,
          highlightColor: highlightColor,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [TabTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final TabTheme? tabTheme =
        context.findAncestorWidgetOfExactType<TabTheme>();
    return identical(this, tabTheme)
        ? child
        : TabTheme(data: data, child: child);
  }

  /// Returns the nearest [TabTheme].
  static TabThemeData of(BuildContext context) {
    final TabTheme? tabTheme =
        context.dependOnInheritedWidgetOfExactType<TabTheme>();
    TabThemeData? tabThemeData = tabTheme?.data;

    if (tabThemeData == null || !tabThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      tabThemeData ??= themeData.tabTheme;

      final _tabThemeData =
          _TabThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final TextStyle textStyle =
          tabThemeData.textStyle ?? _tabThemeData.textStyle;
      final IconThemeData iconThemeData =
          tabThemeData.iconThemeData ?? _tabThemeData.iconThemeData;
      final double itemSpacing =
          tabThemeData.itemSpacing ?? _tabThemeData.itemSpacing;
      final double height = tabThemeData.height ?? _tabThemeData.height;
      final Color color = tabThemeData.color ?? _tabThemeData.color;
      final Color hoverColor =
          tabThemeData.hoverColor ?? _tabThemeData.hoverColor;
      final Color backgroundColor =
          tabThemeData.backgroundColor ?? _tabThemeData.backgroundColor;
      final Color highlightColor =
          tabThemeData.highlightColor ?? _tabThemeData.highlightColor;

      return tabThemeData.copyWith(
        textStyle: textStyle,
        iconThemeData: iconThemeData,
        itemSpacing: itemSpacing,
        height: height,
        color: color,
        hoverColor: hoverColor,
        backgroundColor: backgroundColor,
        highlightColor: highlightColor,
      );
    }

    assert(tabThemeData._isConcrete);

    return tabThemeData;
  }

  @override
  bool updateShouldNotify(TabTheme oldWidget) => data != oldWidget.data;
}
