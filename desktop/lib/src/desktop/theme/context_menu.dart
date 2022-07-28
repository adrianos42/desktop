import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'constants.dart';
import 'theme_data.dart';
import 'theme_text.dart';

const double _kDefaultItemHeight = 34.0;
const double _kMenuWidthStep = 120.0;
const double _kMenuHorizontalPadding = 16.0;
const double _kMinMenuWidth = 2.0 * _kMenuWidthStep;
const double _kMaxMenuWidth = 6.0 * _kMenuWidthStep;

@immutable
class ContextMenuThemeData {
  /// Creates a [ContextMenuThemeData].
  const ContextMenuThemeData({
    this.itemHeight,
    this.menuWidthStep,
    this.minMenuWidth,
    this.menuHorizontalPadding,
    this.maxMenuWidth,
    this.textStyle,
    this.iconThemeData,
    this.selectedColor,
    this.selectedHighlightColor,
    this.selectedHoverColor,
    this.hoverColor,
    this.highlightColor,
    this.background,
    this.color,
  });

  /// The icon theme.
  final IconThemeData? iconThemeData;

  /// The menu step width.
  final double? menuWidthStep;

  /// The item height.
  final double? itemHeight;

  /// The minimum width of the menu.
  final double? minMenuWidth;

  /// The maximum width of the menu.
  final double? maxMenuWidth;

  /// The horizontal padding for the menu item.
  final double? menuHorizontalPadding;

  /// The [TextStyle] of the item.
  final TextStyle? textStyle;

  /// The color of an item when selected.
  final Color? selectedColor;

  /// The color of an item when selected and highlighted. 
  final Color? selectedHighlightColor;

  /// The color of an item when selected and hovered.
  final Color? selectedHoverColor;

  /// The color of an item when hovering over it.
  final Color? hoverColor;

  /// The color of an item when highlighted color.
  final Color? highlightColor;

  ///  The background color of the menu.
  final Color? background;

  /// The color of the menu border.
  final Color? color;

  ContextMenuThemeData copyWith({
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    ColorScheme? colorScheme,
    double? menuWidthStep,
    double? itemHeight,
    double? minMenuWidth,
    double? maxMenuWidth,
    double? menuHorizontalPadding,
    Color? selectedColor,
    Color? selectedHighlightColor,
    Color? selectedHoverColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? background,
    Color? color,
  }) {
    return ContextMenuThemeData(
      textStyle: textStyle ?? this.textStyle,
      iconThemeData: iconThemeData ?? this.iconThemeData,
      menuWidthStep: menuWidthStep ?? this.menuWidthStep,
      itemHeight: itemHeight ?? this.itemHeight,
      minMenuWidth: minMenuWidth ?? this.minMenuWidth,
      maxMenuWidth: maxMenuWidth ?? this.maxMenuWidth,
      menuHorizontalPadding:
          menuHorizontalPadding ?? this.menuHorizontalPadding,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedHighlightColor:
          selectedHighlightColor ?? this.selectedHighlightColor,
      selectedHoverColor: selectedHoverColor ?? this.selectedHoverColor,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
      background: background ?? this.background,
      color: color ?? this.color,
    );
  }

  ContextMenuThemeData merge(ContextMenuThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textStyle: other.textStyle,
      iconThemeData: other.iconThemeData,
      menuWidthStep: other.minMenuWidth,
      itemHeight: other.itemHeight,
      minMenuWidth: other.minMenuWidth,
      maxMenuWidth: other.maxMenuWidth,
      selectedColor: other.selectedColor,
      selectedHighlightColor: other.selectedHighlightColor,
      selectedHoverColor: other.selectedHoverColor,
      hoverColor: other.hoverColor,
      highlightColor: other.highlightColor,
      background: other.background,
      menuHorizontalPadding: other.menuHorizontalPadding,
      color: other.color,
    );
  }

  bool get isConcrete {
    return textStyle != null &&
        iconThemeData != null &&
        selectedColor != null &&
        selectedHighlightColor != null &&
        selectedHoverColor != null &&
        hoverColor != null &&
        menuWidthStep != null &&
        itemHeight != null &&
        minMenuWidth != null &&
        maxMenuWidth != null &&
        menuHorizontalPadding != null &&
        highlightColor != null &&
        background != null &&
        color != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      textStyle,
      iconThemeData,
      menuWidthStep,
      itemHeight,
      minMenuWidth,
      maxMenuWidth,
      menuHorizontalPadding,
      selectedColor,
      selectedHighlightColor,
      selectedHoverColor,
      hoverColor,
      highlightColor,
      background,
      color,
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
    return other is ContextMenuThemeData &&
        other.textStyle == textStyle &&
        other.iconThemeData == iconThemeData &&
        other.menuWidthStep == menuWidthStep &&
        other.itemHeight == itemHeight &&
        other.minMenuWidth == minMenuWidth &&
        other.maxMenuWidth == maxMenuWidth &&
        other.menuHorizontalPadding == menuHorizontalPadding &&
        other.selectedColor == selectedColor &&
        other.selectedHighlightColor == selectedHighlightColor &&
        other.selectedHoverColor == selectedHoverColor &&
        other.hoverColor == hoverColor &&
        other.highlightColor == highlightColor &&
        other.background == background && 
        other.color == color;
  }
}

@immutable
class ContextMenuTheme extends InheritedTheme {
  /// Creates a [ContextMenuTheme].
  const ContextMenuTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  /// The [ContextMenuThemeData].
  final ContextMenuThemeData data;

  static ContextMenuThemeData of(BuildContext context) {
    final ContextMenuTheme? contextMenuTheme =
        context.dependOnInheritedWidgetOfExactType<ContextMenuTheme>();
    ContextMenuThemeData? contextMenuThemeData = contextMenuTheme?.data;

    if (contextMenuThemeData == null || !contextMenuThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      contextMenuThemeData ??= themeData.contextMenuTheme;

      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      final TextStyle textStyle = contextMenuThemeData.textStyle ??
          textTheme.body1.copyWith(fontSize: kFontSize);

      final Color selectedHighlightColor =
          contextMenuThemeData.selectedHighlightColor ??
              colorScheme.primary[60];

      final Color hoverColor =
          contextMenuThemeData.hoverColor ?? colorScheme.background[20];

      final Color highlightColor =
          contextMenuThemeData.highlightColor ?? colorScheme.background[10];

      final Color selectedColor =
          contextMenuThemeData.selectedColor ?? colorScheme.primary[30];

      final Color background =
          contextMenuThemeData.background ?? colorScheme.background[8];

      final Color selectedHoverColor =
          contextMenuThemeData.selectedHoverColor ??
              colorScheme.primary[40]; // TODO(as): ???

      final Color color = colorScheme.shade[kInactiveColorIndex];

      final IconThemeData iconThemeData = contextMenuThemeData.iconThemeData ??
          IconThemeData(size: kIconSize, color: textTheme.textHigh);

      final double itemHeight =
          contextMenuThemeData.itemHeight ?? _kDefaultItemHeight;
      final double menuWidthStep =
          contextMenuThemeData.menuWidthStep ?? _kMenuWidthStep;
      final double minMenuWidth =
          contextMenuThemeData.minMenuWidth ?? _kMinMenuWidth;
      final double maxMenuWidth =
          contextMenuThemeData.maxMenuWidth ?? _kMaxMenuWidth;
      final double menuHorizontalPadding =
          contextMenuThemeData.menuHorizontalPadding ?? _kMenuHorizontalPadding;

      contextMenuThemeData = contextMenuThemeData.copyWith(
        iconThemeData: iconThemeData,
        textStyle: textStyle,
        selectedColor: selectedColor,
        selectedHighlightColor: selectedHighlightColor,
        selectedHoverColor: selectedHoverColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        itemHeight: itemHeight,
        menuWidthStep: menuWidthStep,
        minMenuWidth: minMenuWidth,
        maxMenuWidth: maxMenuWidth,
        menuHorizontalPadding: menuHorizontalPadding,
        background: background,
        color: color,
      );
    }

    assert(contextMenuThemeData.isConcrete);

    return contextMenuThemeData;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ContextMenuTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<ContextMenuTheme>();
    return identical(this, ancestorTheme)
        ? child
        : ContextMenuTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(ContextMenuTheme oldWidget) => data != oldWidget.data;

  static Widget copyWith({
    Key? key,
    required Widget child,
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    ColorScheme? colorScheme,
    double? menuWidthStep,
    double? itemHeight,
    double? minMenuWidth,
    double? maxMenuWidth,
    double? menuHorizontalPadding,
    Color? selectedColor,
    Color? selectedHighlightColor,
    Color? selectedHoverColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? background,
    Color? color,
  }) {
    return Builder(
      key: key,
      builder: (context) => ContextMenuTheme(
        child: child,
        data: ContextMenuTheme.of(context).copyWith(
          textStyle: textStyle,
          iconThemeData: iconThemeData,
          colorScheme: colorScheme,
          menuWidthStep: menuWidthStep,
          itemHeight: itemHeight,
          minMenuWidth: minMenuWidth,
          maxMenuWidth: maxMenuWidth,
          menuHorizontalPadding: menuHorizontalPadding,
          selectedColor: selectedColor,
          selectedHighlightColor: selectedHighlightColor,
          selectedHoverColor: selectedHoverColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          background: background,
          color: color,
        ),
      ),
    );
  }
}
