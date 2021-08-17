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
  });

  final IconThemeData? iconThemeData;

  final double? menuWidthStep;

  final double? itemHeight;

  final double? minMenuWidth;

  final double? maxMenuWidth;

  final double? menuHorizontalPadding;

  final TextStyle? textStyle;

  final HSLColor? selectedColor;

  final HSLColor? selectedHighlightColor;

  final HSLColor? selectedHoverColor;

  final HSLColor? hoverColor;

  final HSLColor? highlightColor;

  final HSLColor? background;

  ContextMenuThemeData copyWith({
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    ColorScheme? colorScheme,
    double? menuWidthStep,
    double? itemHeight,
    double? minMenuWidth,
    double? maxMenuWidth,
    double? menuHorizontalPadding,
    HSLColor? selectedColor,
    HSLColor? selectedHighlightColor,
    HSLColor? selectedHoverColor,
    HSLColor? hoverColor,
    HSLColor? highlightColor,
    HSLColor? background,
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
        background != null;
  }

  @override
  int get hashCode {
    return hashValues(
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
        other.background == background;
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

      final HSLColor selectedHighlightColor =
          contextMenuThemeData.selectedHighlightColor ??
              colorScheme.primary[60];

      final HSLColor hoverColor =
          contextMenuThemeData.hoverColor ?? colorScheme.background[20];

      final HSLColor highlightColor =
          contextMenuThemeData.highlightColor ?? colorScheme.background[10];

      final HSLColor selectedColor =
          contextMenuThemeData.selectedColor ?? colorScheme.primary[30];

      final HSLColor background =
          contextMenuThemeData.background ?? colorScheme.background[4];

      final HSLColor selectedHoverColor =
          contextMenuThemeData.selectedHoverColor ??
              colorScheme.primary[40]; // TODO(as): ???

      final IconThemeData iconThemeData = contextMenuThemeData.iconThemeData ??
          IconThemeData(size: kIconSize, color: textTheme.textHigh.toColor());

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

  static Widget merge(
    BuildContext context,
    Widget child, {
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    ColorScheme? colorScheme,
    double? menuWidthStep,
    double? itemHeight,
    double? minMenuWidth,
    double? maxMenuWidth,
    double? menuHorizontalPadding,
    HSLColor? selectedColor,
    HSLColor? selectedHighlightColor,
    HSLColor? selectedHoverColor,
    HSLColor? hoverColor,
    HSLColor? highlightColor,
    HSLColor? background,
  }) {
    return ContextMenuTheme(
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
      ),
    );
  }
}
