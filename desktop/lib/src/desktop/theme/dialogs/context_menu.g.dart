// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_menu.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [ContextMenu].
@immutable
class ContextMenuThemeData {
  /// Creates a [ContextMenuThemeData].
  const ContextMenuThemeData({
    this.iconThemeData,
    this.menuWidthStep,
    this.itemHeight,
    this.minMenuWidth,
    this.maxMenuWidth,
    this.menuHorizontalPadding,
    this.textStyle,
    this.selectedColor,
    this.selectedHighlightColor,
    this.selectedHoverColor,
    this.selectedForeground,
    this.hoverColor,
    this.highlightColor,
    this.background,
    this.color,
  });

  /// The icon theme.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// IconThemeData(size: kDefaultIconSize, color: textTheme.textHigh)
  /// ```
  final IconThemeData? iconThemeData;

  /// The menu step width.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0 * 120.0
  /// ```
  final double? menuWidthStep;

  /// The item height.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 32.0
  /// ```
  final double? itemHeight;

  /// The minimum width of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 2.0 * 120.0
  /// ```
  final double? minMenuWidth;

  /// The maximum width of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 6.0 * 120.0
  /// ```
  final double? maxMenuWidth;

  /// The horizontal padding for the menu item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 16.0
  /// ```
  final double? menuHorizontalPadding;

  /// The [TextStyle] of the item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body1.copyWith(fontSize: kDefaultFontSize)
  /// ```
  final TextStyle? textStyle;

  /// The color of an item when selected.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[30]
  /// ```
  final Color? selectedColor;

  /// The color of an item when selected and highlighted.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// highlightColor
  /// ```
  final Color? selectedHighlightColor;

  /// The color of an item when selected and hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// hoverColor
  /// ```
  final Color? selectedHoverColor;

  /// The text foreground when selected and hovered.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  final Color? selectedForeground;

  /// The color of an item when hovering over it.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.shade[30]
  /// ```
  final Color? hoverColor;

  /// The color of an item when highlighted color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  final Color? highlightColor;

  ///  The background color of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[8]
  /// ```
  final Color? background;

  /// The color of the menu border.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? color;

  /// Makes a copy of [ContextMenuThemeData] overwriting selected fields.
  ContextMenuThemeData copyWith({
    IconThemeData? iconThemeData,
    double? menuWidthStep,
    double? itemHeight,
    double? minMenuWidth,
    double? maxMenuWidth,
    double? menuHorizontalPadding,
    TextStyle? textStyle,
    Color? selectedColor,
    Color? selectedHighlightColor,
    Color? selectedHoverColor,
    Color? selectedForeground,
    Color? hoverColor,
    Color? highlightColor,
    Color? background,
    Color? color,
  }) {
    return ContextMenuThemeData(
      iconThemeData: iconThemeData ?? this.iconThemeData,
      menuWidthStep: menuWidthStep ?? this.menuWidthStep,
      itemHeight: itemHeight ?? this.itemHeight,
      minMenuWidth: minMenuWidth ?? this.minMenuWidth,
      maxMenuWidth: maxMenuWidth ?? this.maxMenuWidth,
      menuHorizontalPadding:
          menuHorizontalPadding ?? this.menuHorizontalPadding,
      textStyle: textStyle ?? this.textStyle,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedHighlightColor:
          selectedHighlightColor ?? this.selectedHighlightColor,
      selectedHoverColor: selectedHoverColor ?? this.selectedHoverColor,
      selectedForeground: selectedForeground ?? this.selectedForeground,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
      background: background ?? this.background,
      color: color ?? this.color,
    );
  }

  /// Merges the theme data [ContextMenuThemeData].
  ContextMenuThemeData merge(ContextMenuThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      iconThemeData: other.iconThemeData,
      menuWidthStep: other.menuWidthStep,
      itemHeight: other.itemHeight,
      minMenuWidth: other.minMenuWidth,
      maxMenuWidth: other.maxMenuWidth,
      menuHorizontalPadding: other.menuHorizontalPadding,
      textStyle: other.textStyle,
      selectedColor: other.selectedColor,
      selectedHighlightColor: other.selectedHighlightColor,
      selectedHoverColor: other.selectedHoverColor,
      selectedForeground: other.selectedForeground,
      hoverColor: other.hoverColor,
      highlightColor: other.highlightColor,
      background: other.background,
      color: other.color,
    );
  }

  bool get _isConcrete {
    return iconThemeData != null &&
        menuWidthStep != null &&
        itemHeight != null &&
        minMenuWidth != null &&
        maxMenuWidth != null &&
        menuHorizontalPadding != null &&
        textStyle != null &&
        selectedColor != null &&
        selectedHighlightColor != null &&
        selectedHoverColor != null &&
        selectedForeground != null &&
        hoverColor != null &&
        highlightColor != null &&
        background != null &&
        color != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      iconThemeData,
      menuWidthStep,
      itemHeight,
      minMenuWidth,
      maxMenuWidth,
      menuHorizontalPadding,
      textStyle,
      selectedColor,
      selectedHighlightColor,
      selectedHoverColor,
      selectedForeground,
      hoverColor,
      highlightColor,
      background,
      color,
    );
  }

  @override
  String toString() {
    return '''iconThemeData: The icon theme. Defaults to: ```dart IconThemeData(size: kDefaultIconSize, color: textTheme.textHigh) ```;menuWidthStep: The menu step width. Defaults to: ```dart 2.0 * 120.0 ```;itemHeight: The item height. Defaults to: ```dart 32.0 ```;minMenuWidth: The minimum width of the menu. Defaults to: ```dart 2.0 * 120.0 ```;maxMenuWidth: The maximum width of the menu. Defaults to: ```dart 6.0 * 120.0 ```;menuHorizontalPadding: The horizontal padding for the menu item. Defaults to: ```dart 16.0 ```;textStyle: The [TextStyle] of the item. Defaults to: ```dart textTheme.body1.copyWith(fontSize: kDefaultFontSize) ```;selectedColor: The color of an item when selected. Defaults to: ```dart colorScheme.primary[30] ```;selectedHighlightColor: The color of an item when selected and highlighted. Defaults to: ```dart highlightColor ```;selectedHoverColor: The color of an item when selected and hovered. Defaults to: ```dart hoverColor ```;selectedForeground: The text foreground when selected and hovered. Defaults to: ```dart textTheme.textHigh ```;hoverColor: The color of an item when hovering over it. Defaults to: ```dart colorScheme.shade[30] ```;highlightColor: The color of an item when highlighted color. Defaults to: ```dart colorScheme.background[20] ```;background:  The background color of the menu. Defaults to: ```dart colorScheme.background[8] ```;color: The color of the menu border. Defaults to: ```dart textTheme.textLow ```;''';
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
        other.iconThemeData == iconThemeData &&
        other.menuWidthStep == menuWidthStep &&
        other.itemHeight == itemHeight &&
        other.minMenuWidth == minMenuWidth &&
        other.maxMenuWidth == maxMenuWidth &&
        other.menuHorizontalPadding == menuHorizontalPadding &&
        other.textStyle == textStyle &&
        other.selectedColor == selectedColor &&
        other.selectedHighlightColor == selectedHighlightColor &&
        other.selectedHoverColor == selectedHoverColor &&
        other.selectedForeground == selectedForeground &&
        other.hoverColor == hoverColor &&
        other.highlightColor == highlightColor &&
        other.background == background &&
        other.color == color;
  }
}

/// Inherited theme for [ContextMenuThemeData].
@immutable
class ContextMenuTheme extends InheritedTheme {
  /// Creates a [ContextMenuTheme].
  const ContextMenuTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [ContextMenuTheme].
  final ContextMenuThemeData data;

  /// Merges the nearest [ContextMenuTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required ContextMenuThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => ContextMenuTheme(
        data: ContextMenuTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [ContextMenuTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    IconThemeData? iconThemeData,
    double? menuWidthStep,
    double? itemHeight,
    double? minMenuWidth,
    double? maxMenuWidth,
    double? menuHorizontalPadding,
    TextStyle? textStyle,
    Color? selectedColor,
    Color? selectedHighlightColor,
    Color? selectedHoverColor,
    Color? selectedForeground,
    Color? hoverColor,
    Color? highlightColor,
    Color? background,
    Color? color,
  }) {
    return Builder(
      key: key,
      builder: (context) => ContextMenuTheme(
        data: ContextMenuTheme.of(context).copyWith(
          iconThemeData: iconThemeData,
          menuWidthStep: menuWidthStep,
          itemHeight: itemHeight,
          minMenuWidth: minMenuWidth,
          maxMenuWidth: maxMenuWidth,
          menuHorizontalPadding: menuHorizontalPadding,
          textStyle: textStyle,
          selectedColor: selectedColor,
          selectedHighlightColor: selectedHighlightColor,
          selectedHoverColor: selectedHoverColor,
          selectedForeground: selectedForeground,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          background: background,
          color: color,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [ContextMenuTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final ContextMenuTheme? contextMenuTheme =
        context.findAncestorWidgetOfExactType<ContextMenuTheme>();
    return identical(this, contextMenuTheme)
        ? child
        : ContextMenuTheme(data: data, child: child);
  }

  /// Returns the nearest [ContextMenuTheme].
  static ContextMenuThemeData of(BuildContext context) {
    final ContextMenuTheme? contextMenuTheme =
        context.dependOnInheritedWidgetOfExactType<ContextMenuTheme>();
    ContextMenuThemeData? contextMenuThemeData = contextMenuTheme?.data;

    if (contextMenuThemeData == null || !contextMenuThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      contextMenuThemeData ??= themeData.contextMenuTheme;

      final _contextMenuThemeData =
          _ContextMenuThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final IconThemeData iconThemeData = contextMenuThemeData.iconThemeData ??
          _contextMenuThemeData.iconThemeData;
      final double menuWidthStep = contextMenuThemeData.menuWidthStep ??
          _contextMenuThemeData.menuWidthStep;
      final double itemHeight =
          contextMenuThemeData.itemHeight ?? _contextMenuThemeData.itemHeight;
      final double minMenuWidth = contextMenuThemeData.minMenuWidth ??
          _contextMenuThemeData.minMenuWidth;
      final double maxMenuWidth = contextMenuThemeData.maxMenuWidth ??
          _contextMenuThemeData.maxMenuWidth;
      final double menuHorizontalPadding =
          contextMenuThemeData.menuHorizontalPadding ??
              _contextMenuThemeData.menuHorizontalPadding;
      final TextStyle textStyle =
          contextMenuThemeData.textStyle ?? _contextMenuThemeData.textStyle;
      final Color selectedColor = contextMenuThemeData.selectedColor ??
          _contextMenuThemeData.selectedColor;
      final Color selectedHighlightColor =
          contextMenuThemeData.selectedHighlightColor ??
              _contextMenuThemeData.selectedHighlightColor;
      final Color selectedHoverColor =
          contextMenuThemeData.selectedHoverColor ??
              _contextMenuThemeData.selectedHoverColor;
      final Color selectedForeground =
          contextMenuThemeData.selectedForeground ??
              _contextMenuThemeData.selectedForeground;
      final Color hoverColor =
          contextMenuThemeData.hoverColor ?? _contextMenuThemeData.hoverColor;
      final Color highlightColor = contextMenuThemeData.highlightColor ??
          _contextMenuThemeData.highlightColor;
      final Color background =
          contextMenuThemeData.background ?? _contextMenuThemeData.background;
      final Color color =
          contextMenuThemeData.color ?? _contextMenuThemeData.color;

      return contextMenuThemeData.copyWith(
        iconThemeData: iconThemeData,
        menuWidthStep: menuWidthStep,
        itemHeight: itemHeight,
        minMenuWidth: minMenuWidth,
        maxMenuWidth: maxMenuWidth,
        menuHorizontalPadding: menuHorizontalPadding,
        textStyle: textStyle,
        selectedColor: selectedColor,
        selectedHighlightColor: selectedHighlightColor,
        selectedHoverColor: selectedHoverColor,
        selectedForeground: selectedForeground,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        background: background,
        color: color,
      );
    }

    assert(contextMenuThemeData._isConcrete);

    return contextMenuThemeData;
  }

  @override
  bool updateShouldNotify(ContextMenuTheme oldWidget) => data != oldWidget.data;
}
