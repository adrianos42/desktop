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
    this.padding,
    this.height,
    this.width,
    this.tabBarBackgroundColor,
    this.textStyle,
    this.iconThemeData,
    this.itemSpacing,
    this.itemPadding,
    this.itemColor,
    this.itemHoverColor,
    this.itemHighlightColor,
    this.itemFilled,
    this.itemBackgroundColor,
    this.itemHoverBackgroundColor,
    this.itemHighlightBackgroundColor,
    this.menuTransitionDuration,
    this.menuTrasitionCurve,
    this.menuTrasitionReverseCurve,
  });

  /// The padding for the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.zero
  /// ```
  final EdgeInsets? padding;

  /// The height of the tab bar when the axis is horizontal.
  /// When the value is `0.0`, the height of the tab bar will be
  /// the intrinsic height of the children.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 36.0
  /// ```
  final double? height;

  /// The width of the tab bar when the axis is vertical.
  /// When the value is `0.0`, the width of the tab bar will be
  /// the intrinsic width of the children.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 0.0
  /// ```
  final double? width;

  /// The background of the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? tabBarBackgroundColor;

  /// The style for the text. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: defaultFontSize, overflow: TextOverflow.ellipsis)
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

  /// The padding for the items in the tab bar.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.symmetric(horizontal: itemSpacing)
  /// ```
  final EdgeInsets? itemPadding;

  /// The color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? itemColor;

  /// The hover color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[100]
  /// ```
  final Color? itemHoverColor;

  /// The highlight color of the tab item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  final Color? itemHighlightColor;

  /// If the tab bar item should use a filled button.
  /// See [itemBackgroundColor] to change the background color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// false
  /// ```
  final bool? itemFilled;

  /// The background color when the button is filled.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[30]
  /// ```
  final Color? itemBackgroundColor;

  /// The background color when the button is being hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[30]
  /// ```
  final Color? itemHoverBackgroundColor;

  /// The background color when the button is pressed.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  final Color? itemHighlightBackgroundColor;

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

  /// Makes a copy of [TabThemeData] overwriting selected fields.
  TabThemeData copyWith({
    EdgeInsets? padding,
    double? height,
    double? width,
    Color? tabBarBackgroundColor,
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    double? itemSpacing,
    EdgeInsets? itemPadding,
    Color? itemColor,
    Color? itemHoverColor,
    Color? itemHighlightColor,
    bool? itemFilled,
    Color? itemBackgroundColor,
    Color? itemHoverBackgroundColor,
    Color? itemHighlightBackgroundColor,
    Duration? menuTransitionDuration,
    Curve? menuTrasitionCurve,
    Curve? menuTrasitionReverseCurve,
  }) {
    return TabThemeData(
      padding: padding ?? this.padding,
      height: height ?? this.height,
      width: width ?? this.width,
      tabBarBackgroundColor:
          tabBarBackgroundColor ?? this.tabBarBackgroundColor,
      textStyle: textStyle ?? this.textStyle,
      iconThemeData: iconThemeData ?? this.iconThemeData,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      itemPadding: itemPadding ?? this.itemPadding,
      itemColor: itemColor ?? this.itemColor,
      itemHoverColor: itemHoverColor ?? this.itemHoverColor,
      itemHighlightColor: itemHighlightColor ?? this.itemHighlightColor,
      itemFilled: itemFilled ?? this.itemFilled,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemHoverBackgroundColor:
          itemHoverBackgroundColor ?? this.itemHoverBackgroundColor,
      itemHighlightBackgroundColor:
          itemHighlightBackgroundColor ?? this.itemHighlightBackgroundColor,
      menuTransitionDuration:
          menuTransitionDuration ?? this.menuTransitionDuration,
      menuTrasitionCurve: menuTrasitionCurve ?? this.menuTrasitionCurve,
      menuTrasitionReverseCurve:
          menuTrasitionReverseCurve ?? this.menuTrasitionReverseCurve,
    );
  }

  /// Merges the theme data [TabThemeData].
  TabThemeData merge(TabThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      padding: other.padding,
      height: other.height,
      width: other.width,
      tabBarBackgroundColor: other.tabBarBackgroundColor,
      textStyle: other.textStyle,
      iconThemeData: other.iconThemeData,
      itemSpacing: other.itemSpacing,
      itemPadding: other.itemPadding,
      itemColor: other.itemColor,
      itemHoverColor: other.itemHoverColor,
      itemHighlightColor: other.itemHighlightColor,
      itemFilled: other.itemFilled,
      itemBackgroundColor: other.itemBackgroundColor,
      itemHoverBackgroundColor: other.itemHoverBackgroundColor,
      itemHighlightBackgroundColor: other.itemHighlightBackgroundColor,
      menuTransitionDuration: other.menuTransitionDuration,
      menuTrasitionCurve: other.menuTrasitionCurve,
      menuTrasitionReverseCurve: other.menuTrasitionReverseCurve,
    );
  }

  bool get _isConcrete {
    return padding != null &&
        height != null &&
        width != null &&
        tabBarBackgroundColor != null &&
        textStyle != null &&
        iconThemeData != null &&
        itemSpacing != null &&
        itemPadding != null &&
        itemColor != null &&
        itemHoverColor != null &&
        itemHighlightColor != null &&
        itemFilled != null &&
        itemBackgroundColor != null &&
        itemHoverBackgroundColor != null &&
        itemHighlightBackgroundColor != null &&
        menuTransitionDuration != null &&
        menuTrasitionCurve != null &&
        menuTrasitionReverseCurve != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      padding,
      height,
      width,
      tabBarBackgroundColor,
      textStyle,
      iconThemeData,
      itemSpacing,
      itemPadding,
      itemColor,
      itemHoverColor,
      itemHighlightColor,
      itemFilled,
      itemBackgroundColor,
      itemHoverBackgroundColor,
      itemHighlightBackgroundColor,
      menuTransitionDuration,
      menuTrasitionCurve,
      menuTrasitionReverseCurve,
    );
  }

  @override
  String toString() {
    return r'''
padding: The padding for the tab bar.

 Defaults to:

 ```dart
 EdgeInsets.zero
 ```;;height: The height of the tab bar when the axis is horizontal.
 When the value is `0.0`, the height of the tab bar will be
 the intrinsic height of the children.

 Defaults to:

 ```dart
 36.0
 ```;;width: The width of the tab bar when the axis is vertical.
 When the value is `0.0`, the width of the tab bar will be
 the intrinsic width of the children.

 Defaults to:

 ```dart
 0.0
 ```;;tabBarBackgroundColor: The background of the tab bar.

 Defaults to:

 ```dart
 colorScheme.background[0]
 ```;;textStyle: The style for the text. The color is ignored.

 Defaults to:

 ```dart
 textTheme.body2.copyWith(fontSize: defaultFontSize, overflow: TextOverflow.ellipsis)
 ```;;iconThemeData: The theme for the icon. The color is ignored.

 Defaults to:

 ```dart
 IconThemeData(size: kDefaultIconSize)
 ```;;itemSpacing: The space between items inside the tab bar, if they are simple text or an icon.

 Defaults to:

 ```dart
 8.0
 ```;;itemPadding: The padding for the items in the tab bar.

 Defaults to:

 ```dart
 EdgeInsets.symmetric(horizontal: itemSpacing)
 ```;;itemColor: The color of the tab item.

 Defaults to:

 ```dart
 textTheme.textLow
 ```;;itemHoverColor: The hover color of the tab item.

 Defaults to:

 ```dart
 colorScheme.shade[100]
 ```;;itemHighlightColor: The highlight color of the tab item.

 Defaults to:

 ```dart
 colorScheme.primary[60]
 ```;;itemFilled: If the tab bar item should use a filled button.
 See [itemBackgroundColor] to change the background color.

 Defaults to:

 ```dart
 false
 ```;;itemBackgroundColor: The background color when the button is filled.

 Defaults to:

 ```dart
 colorScheme.primary[30]
 ```;;itemHoverBackgroundColor: The background color when the button is being hovered.

 Defaults to:

 ```dart
 colorScheme.shade[30]
 ```;;itemHighlightBackgroundColor: The background color when the button is pressed.

 Defaults to:

 ```dart
 colorScheme.background[20]
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
  bool operator ==(covariant TabThemeData other) {
    return identical(this, other) ||
        other.padding == padding &&
            other.height == height &&
            other.width == width &&
            other.tabBarBackgroundColor == tabBarBackgroundColor &&
            other.textStyle == textStyle &&
            other.iconThemeData == iconThemeData &&
            other.itemSpacing == itemSpacing &&
            other.itemPadding == itemPadding &&
            other.itemColor == itemColor &&
            other.itemHoverColor == itemHoverColor &&
            other.itemHighlightColor == itemHighlightColor &&
            other.itemFilled == itemFilled &&
            other.itemBackgroundColor == itemBackgroundColor &&
            other.itemHoverBackgroundColor == itemHoverBackgroundColor &&
            other.itemHighlightBackgroundColor ==
                itemHighlightBackgroundColor &&
            other.menuTransitionDuration == menuTransitionDuration &&
            other.menuTrasitionCurve == menuTrasitionCurve &&
            other.menuTrasitionReverseCurve == menuTrasitionReverseCurve;
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
    EdgeInsets? padding,
    double? height,
    double? width,
    Color? tabBarBackgroundColor,
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    double? itemSpacing,
    EdgeInsets? itemPadding,
    Color? itemColor,
    Color? itemHoverColor,
    Color? itemHighlightColor,
    bool? itemFilled,
    Color? itemBackgroundColor,
    Color? itemHoverBackgroundColor,
    Color? itemHighlightBackgroundColor,
    Duration? menuTransitionDuration,
    Curve? menuTrasitionCurve,
    Curve? menuTrasitionReverseCurve,
  }) {
    return Builder(
      key: key,
      builder: (context) => TabTheme(
        data: TabTheme.of(context).copyWith(
          padding: padding,
          height: height,
          width: width,
          tabBarBackgroundColor: tabBarBackgroundColor,
          textStyle: textStyle,
          iconThemeData: iconThemeData,
          itemSpacing: itemSpacing,
          itemPadding: itemPadding,
          itemColor: itemColor,
          itemHoverColor: itemHoverColor,
          itemHighlightColor: itemHighlightColor,
          itemFilled: itemFilled,
          itemBackgroundColor: itemBackgroundColor,
          itemHoverBackgroundColor: itemHoverBackgroundColor,
          itemHighlightBackgroundColor: itemHighlightBackgroundColor,
          menuTransitionDuration: menuTransitionDuration,
          menuTrasitionCurve: menuTrasitionCurve,
          menuTrasitionReverseCurve: menuTrasitionReverseCurve,
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

      final tabValue =
          _TabThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final EdgeInsets padding = tabThemeData.padding ?? tabValue.padding;
      final double height = tabThemeData.height ?? tabValue.height;
      final double width = tabThemeData.width ?? tabValue.width;
      final Color tabBarBackgroundColor =
          tabThemeData.tabBarBackgroundColor ?? tabValue.tabBarBackgroundColor;
      final TextStyle textStyle = tabThemeData.textStyle ?? tabValue.textStyle;
      final IconThemeData iconThemeData =
          tabThemeData.iconThemeData ?? tabValue.iconThemeData;
      final double itemSpacing =
          tabThemeData.itemSpacing ?? tabValue.itemSpacing;
      final EdgeInsets itemPadding =
          tabThemeData.itemPadding ?? tabValue.itemPadding;
      final Color itemColor = tabThemeData.itemColor ?? tabValue.itemColor;
      final Color itemHoverColor =
          tabThemeData.itemHoverColor ?? tabValue.itemHoverColor;
      final Color itemHighlightColor =
          tabThemeData.itemHighlightColor ?? tabValue.itemHighlightColor;
      final bool itemFilled = tabThemeData.itemFilled ?? tabValue.itemFilled;
      final Color itemBackgroundColor =
          tabThemeData.itemBackgroundColor ?? tabValue.itemBackgroundColor;
      final Color itemHoverBackgroundColor =
          tabThemeData.itemHoverBackgroundColor ??
              tabValue.itemHoverBackgroundColor;
      final Color itemHighlightBackgroundColor =
          tabThemeData.itemHighlightBackgroundColor ??
              tabValue.itemHighlightBackgroundColor;
      final Duration menuTransitionDuration =
          tabThemeData.menuTransitionDuration ??
              tabValue.menuTransitionDuration;
      final Curve menuTrasitionCurve =
          tabThemeData.menuTrasitionCurve ?? tabValue.menuTrasitionCurve;
      final Curve menuTrasitionReverseCurve =
          tabThemeData.menuTrasitionReverseCurve ??
              tabValue.menuTrasitionReverseCurve;

      return tabThemeData.copyWith(
        padding: padding,
        height: height,
        width: width,
        tabBarBackgroundColor: tabBarBackgroundColor,
        textStyle: textStyle,
        iconThemeData: iconThemeData,
        itemSpacing: itemSpacing,
        itemPadding: itemPadding,
        itemColor: itemColor,
        itemHoverColor: itemHoverColor,
        itemHighlightColor: itemHighlightColor,
        itemFilled: itemFilled,
        itemBackgroundColor: itemBackgroundColor,
        itemHoverBackgroundColor: itemHoverBackgroundColor,
        itemHighlightBackgroundColor: itemHighlightBackgroundColor,
        menuTransitionDuration: menuTransitionDuration,
        menuTrasitionCurve: menuTrasitionCurve,
        menuTrasitionReverseCurve: menuTrasitionReverseCurve,
      );
    }

    assert(tabThemeData._isConcrete);

    return tabThemeData;
  }

  @override
  bool updateShouldNotify(TabTheme oldWidget) => data != oldWidget.data;
}
