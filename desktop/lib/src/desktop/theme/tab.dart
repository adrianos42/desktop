import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'constants.dart';
import 'theme_data.dart';
import 'theme_text.dart';

const double _kTabHeight = 36.0;
const double _kPadding = 8.0;
const double _kFontSize = 14.0;

@immutable
class TabThemeData {
  ///
  const TabThemeData({
    this.textStyle,
    this.height,
    this.itemSpacing,
    this.iconThemeData,
    this.color,
    this.hoverColor,
    this.backgroundColor,
    this.highlightColor,
  });

  /// The style for the text. The color is ignored.
  final TextStyle? textStyle;

  /// The theme for the icon. The color is ignored.
  final IconThemeData? iconThemeData;

  /// The space between items inside the tab bar, if they are simple text or an icon.
  final double? itemSpacing;

  /// The height of the tab bar.
  final double? height;

  /// The color of the tab item.
  final Color? color;

  /// The hover color of the tab item.
  final Color? hoverColor;

  /// The background of the tab bar.
  final Color? backgroundColor;

  /// The highlight color of the tab item.
  final Color? highlightColor;

  ///
  TabThemeData copyWidth({
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

  ///
  bool get isConcrete {
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

///
@immutable
class TabTheme extends InheritedTheme {
  ///
  const TabTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  /// The tab theme data.
  final TabThemeData data;

  ///
  static TabThemeData of(BuildContext context) {
    final TabTheme? tabTheme =
        context.dependOnInheritedWidgetOfExactType<TabTheme>();
    TabThemeData? tabThemeData = tabTheme?.data;

    if (tabThemeData == null || !tabThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      tabThemeData ??= themeData.tabTheme;

      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      final TextStyle textStyle = tabThemeData.textStyle ??
          textTheme.body2.copyWith(
            fontSize: _kFontSize,
            overflow: TextOverflow.ellipsis,
          );

      final Color color =
          tabThemeData.color ?? colorScheme.shade[kInactiveColorIndex];

      final Color hoverColor =
          tabThemeData.hoverColor ?? colorScheme.shade[100];

      final Color highlightColor =
          tabThemeData.highlightColor ?? colorScheme.primary[60];

      final IconThemeData iconThemeData =
          tabThemeData.iconThemeData ?? const IconThemeData(size: kIconSize);

      final double height = tabThemeData.height ?? _kTabHeight;

      final double itemSpacing = tabThemeData.itemSpacing ?? _kPadding;

      final Color backgroundColor =
          tabThemeData.backgroundColor ?? colorScheme.background[0];

      tabThemeData = tabThemeData.copyWidth(
        textStyle: textStyle,
        color: color,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        height: height,
        iconThemeData: iconThemeData,
        itemSpacing: itemSpacing,
        backgroundColor: backgroundColor,
      );
    }

    assert(tabThemeData.isConcrete);

    return tabThemeData;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final TabTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<TabTheme>();
    return identical(this, ancestorTheme)
        ? child
        : TabTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(TabTheme oldWidget) => data != oldWidget.data;
}
