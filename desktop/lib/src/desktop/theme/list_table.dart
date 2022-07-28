import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'constants.dart';
import 'theme_data.dart';
import 'theme_text.dart';

const double _kDefaultItemHeight = 34.0;

@immutable
class ListTableThemeData {
  /// Creates a [ListTableThemeData].
  const ListTableThemeData({
    this.itemHeight,
    this.textStyle,
    this.iconThemeData,
    this.selectedColor,
    this.selectedHighlightColor,
    this.selectedHoverColor,
    this.hoverColor,
    this.highlightColor,
    this.background,
    this.borderColor,
    this.borderHighlightColor,
    this.borderIndicatorColor,
    this.borderHoverColor,
  });

  final IconThemeData? iconThemeData;

  final double? itemHeight;

  final TextStyle? textStyle;

  final Color? selectedColor;

  final Color? selectedHighlightColor;

  final Color? selectedHoverColor;

  final Color? hoverColor;

  final Color? highlightColor;

  final Color? background;

  final Color? borderColor;

  final Color? borderHoverColor;

  final Color? borderHighlightColor;

  final Color? borderIndicatorColor;

  ListTableThemeData copyWith({
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    ColorScheme? colorScheme,
    double? itemHeight,
    Color? selectedColor,
    Color? selectedHighlightColor,
    Color? selectedHoverColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? background,
    Color? borderColor,
    Color? borderHoverColor,
    Color? borderHighlightColor,
    Color? borderIndicatorColor,
  }) {
    return ListTableThemeData(
      textStyle: textStyle ?? this.textStyle,
      iconThemeData: iconThemeData ?? this.iconThemeData,
      itemHeight: itemHeight ?? this.itemHeight,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedHighlightColor:
          selectedHighlightColor ?? this.selectedHighlightColor,
      selectedHoverColor: selectedHoverColor ?? this.selectedHoverColor,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
      background: background ?? this.background,
      borderColor: borderColor ?? this.borderColor,
      borderHoverColor: borderHoverColor ?? this.borderHoverColor,
      borderHighlightColor: borderHighlightColor ?? this.borderHighlightColor,
      borderIndicatorColor: borderIndicatorColor ?? this.borderIndicatorColor,
    );
  }

  ListTableThemeData merge(ListTableThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textStyle: other.textStyle,
      iconThemeData: other.iconThemeData,
      itemHeight: other.itemHeight,
      selectedColor: other.selectedColor,
      selectedHighlightColor: other.selectedHighlightColor,
      selectedHoverColor: other.selectedHoverColor,
      hoverColor: other.hoverColor,
      highlightColor: other.highlightColor,
      background: other.background,
      borderColor: other.borderColor,
      borderHoverColor: other.borderHoverColor,
      borderHighlightColor: other.borderHighlightColor,
      borderIndicatorColor: other.borderIndicatorColor,
    );
  }

  bool get isConcrete {
    return textStyle != null &&
        iconThemeData != null &&
        selectedColor != null &&
        selectedHighlightColor != null &&
        selectedHoverColor != null &&
        hoverColor != null &&
        itemHeight != null &&
        highlightColor != null &&
        background != null &&
        borderColor != null &&
        borderHoverColor != null &&
        borderHighlightColor != null &&
        borderIndicatorColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      textStyle,
      iconThemeData,
      itemHeight,
      selectedColor,
      selectedHighlightColor,
      selectedHoverColor,
      hoverColor,
      highlightColor,
      background,
      borderColor,
      borderHoverColor,
      borderHighlightColor,
      borderIndicatorColor,
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
    return other is ListTableThemeData &&
        other.textStyle == textStyle &&
        other.iconThemeData == iconThemeData &&
        other.itemHeight == itemHeight &&
        other.selectedColor == selectedColor &&
        other.selectedHighlightColor == selectedHighlightColor &&
        other.selectedHoverColor == selectedHoverColor &&
        other.hoverColor == hoverColor &&
        other.highlightColor == highlightColor &&
        other.background == background &&
        other.borderColor == borderColor &&
        other.borderHoverColor == borderHoverColor &&
        other.borderHighlightColor == borderHighlightColor &&
        other.borderIndicatorColor == borderIndicatorColor;
  }
}

@immutable
class ListTableTheme extends InheritedTheme {
  /// Creates a [ListTableTheme].
  const ListTableTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  /// The [ListTableThemeData].
  final ListTableThemeData data;

  static ListTableThemeData of(BuildContext context) {
    final ListTableTheme? listTableTheme =
        context.dependOnInheritedWidgetOfExactType<ListTableTheme>();
    ListTableThemeData? listTableThemeData = listTableTheme?.data;

    if (listTableThemeData == null || !listTableThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      listTableThemeData ??= themeData.listTableTheme;

      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      final TextStyle textStyle = listTableThemeData.textStyle ??
          textTheme.body1.copyWith(fontSize: kFontSize);

      final Color selectedHighlightColor =
          listTableThemeData.selectedHighlightColor ?? colorScheme.primary[60];

      final Color hoverColor =
          listTableThemeData.hoverColor ?? colorScheme.background[20];

      final Color highlightColor =
          listTableThemeData.highlightColor ?? colorScheme.background[10];

      final Color selectedColor =
          listTableThemeData.selectedColor ?? colorScheme.primary[30];

      final Color background =
          listTableThemeData.background ?? colorScheme.background[4];

      final Color selectedHoverColor = listTableThemeData.selectedHoverColor ??
          colorScheme.primary[40]; // TODO(as): ???

      final Color borderColor =
          listTableThemeData.borderColor ?? colorScheme.shade[40];
      final Color borderHoverColor = colorScheme.shade[kHoverColorIndex];
      final Color borderHighlightColor = colorScheme.primary[50];
      final Color borderIndicatorColor = colorScheme.primary[50];

      final IconThemeData iconThemeData = listTableThemeData.iconThemeData ??
          IconThemeData(size: kIconSize, color: textTheme.textHigh);

      final double itemHeight =
          listTableThemeData.itemHeight ?? _kDefaultItemHeight;

      listTableThemeData = listTableThemeData.copyWith(
        iconThemeData: iconThemeData,
        textStyle: textStyle,
        selectedColor: selectedColor,
        selectedHighlightColor: selectedHighlightColor,
        selectedHoverColor: selectedHoverColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        itemHeight: itemHeight,
        background: background,
        borderColor: borderColor,
        borderHoverColor: borderHoverColor,
        borderHighlightColor: borderHighlightColor,
        borderIndicatorColor: borderIndicatorColor,
      );
    }

    assert(listTableThemeData.isConcrete);

    return listTableThemeData;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ListTableTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<ListTableTheme>();
    return identical(this, ancestorTheme)
        ? child
        : ListTableTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(ListTableTheme oldWidget) => data != oldWidget.data;

  /// Merges with the nearest [ListTableTheme].
  static Widget merge({
    Key? key,
    required ListTableThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (context) => ListTableTheme(
        key: key,
        data: ListTableTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Copies with the nearest [ListTableTheme].
  static Widget copyWith({
    required Widget child,
    Key? key,
    TextStyle? textStyle,
    IconThemeData? iconThemeData,
    ColorScheme? colorScheme,
    double? itemHeight,
    Color? selectedColor,
    Color? selectedHighlightColor,
    Color? selectedHoverColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? background,
  }) {
    return Builder(
      key: key,
      builder: (context) => ListTableTheme(
        child: child,
        data: ListTableTheme.of(context).copyWith(
          textStyle: textStyle,
          iconThemeData: iconThemeData,
          colorScheme: colorScheme,
          itemHeight: itemHeight,
          selectedColor: selectedColor,
          selectedHighlightColor: selectedHighlightColor,
          selectedHoverColor: selectedHoverColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          background: background,
        ),
      ),
    );
  }
}
