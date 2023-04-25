// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_table.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [ListTable].
@immutable
class ListTableThemeData {
  /// Creates a [ListTableThemeData].
  const ListTableThemeData({
    this.iconThemeData,
    this.itemHeight,
    this.textStyle,
    this.selectedColor,
    this.selectedHighlightColor,
    this.selectedHoverColor,
    this.hoverColor,
    this.highlightColor,
    this.background,
    this.borderColor,
    this.borderHoverColor,
    this.borderHighlightColor,
    this.borderIndicatorColor,
  });

  ///
  final IconThemeData? iconThemeData;

  ///
  final double? itemHeight;

  ///
  final TextStyle? textStyle;

  ///
  final Color? selectedColor;

  ///
  final Color? selectedHighlightColor;

  ///
  final Color? selectedHoverColor;

  ///
  final Color? hoverColor;

  ///
  final Color? highlightColor;

  ///
  final Color? background;

  ///
  final Color? borderColor;

  ///
  final Color? borderHoverColor;

  ///
  final Color? borderHighlightColor;

  ///
  final Color? borderIndicatorColor;

  /// Makes a copy of [ListTableThemeData] overwriting selected fields.
  ListTableThemeData copyWith({
    IconThemeData? iconThemeData,
    double? itemHeight,
    TextStyle? textStyle,
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
      iconThemeData: iconThemeData ?? this.iconThemeData,
      itemHeight: itemHeight ?? this.itemHeight,
      textStyle: textStyle ?? this.textStyle,
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

  /// Merges the theme data [ListTableThemeData].
  ListTableThemeData merge(ListTableThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      iconThemeData: other.iconThemeData,
      itemHeight: other.itemHeight,
      textStyle: other.textStyle,
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

  bool get _isConcrete {
    return iconThemeData != null &&
        itemHeight != null &&
        textStyle != null &&
        selectedColor != null &&
        selectedHighlightColor != null &&
        selectedHoverColor != null &&
        hoverColor != null &&
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
      iconThemeData,
      itemHeight,
      textStyle,
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
  String toString() {
    return r'''
iconThemeData:;;itemHeight:;;textStyle:;;selectedColor:;;selectedHighlightColor:;;selectedHoverColor:;;hoverColor:;;highlightColor:;;background:;;borderColor:;;borderHoverColor:;;borderHighlightColor:;;borderIndicatorColor:;;
''';
  }

  @override
  bool operator ==(covariant ListTableThemeData other) {
    return identical(this, other) ||
        other.iconThemeData == iconThemeData &&
            other.itemHeight == itemHeight &&
            other.textStyle == textStyle &&
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

/// Inherited theme for [ListTableThemeData].
@immutable
class ListTableTheme extends InheritedTheme {
  /// Creates a [ListTableTheme].
  const ListTableTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [ListTableTheme].
  final ListTableThemeData data;

  /// Merges the nearest [ListTableTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required ListTableThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => ListTableTheme(
        data: ListTableTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [ListTableTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    IconThemeData? iconThemeData,
    double? itemHeight,
    TextStyle? textStyle,
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
    return Builder(
      key: key,
      builder: (context) => ListTableTheme(
        data: ListTableTheme.of(context).copyWith(
          iconThemeData: iconThemeData,
          itemHeight: itemHeight,
          textStyle: textStyle,
          selectedColor: selectedColor,
          selectedHighlightColor: selectedHighlightColor,
          selectedHoverColor: selectedHoverColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          background: background,
          borderColor: borderColor,
          borderHoverColor: borderHoverColor,
          borderHighlightColor: borderHighlightColor,
          borderIndicatorColor: borderIndicatorColor,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [ListTableTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final ListTableTheme? listTableTheme =
        context.findAncestorWidgetOfExactType<ListTableTheme>();
    return identical(this, listTableTheme)
        ? child
        : ListTableTheme(data: data, child: child);
  }

  /// Returns the nearest [ListTableTheme].
  static ListTableThemeData of(BuildContext context) {
    final ListTableTheme? listTableTheme =
        context.dependOnInheritedWidgetOfExactType<ListTableTheme>();
    ListTableThemeData? listTableThemeData = listTableTheme?.data;

    if (listTableThemeData == null || !listTableThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      listTableThemeData ??= themeData.listTableTheme;

      final _listTableThemeData =
          _ListTableThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final IconThemeData iconThemeData =
          listTableThemeData.iconThemeData ?? _listTableThemeData.iconThemeData;
      final double itemHeight =
          listTableThemeData.itemHeight ?? _listTableThemeData.itemHeight;
      final TextStyle textStyle =
          listTableThemeData.textStyle ?? _listTableThemeData.textStyle;
      final Color selectedColor =
          listTableThemeData.selectedColor ?? _listTableThemeData.selectedColor;
      final Color selectedHighlightColor =
          listTableThemeData.selectedHighlightColor ??
              _listTableThemeData.selectedHighlightColor;
      final Color selectedHoverColor = listTableThemeData.selectedHoverColor ??
          _listTableThemeData.selectedHoverColor;
      final Color hoverColor =
          listTableThemeData.hoverColor ?? _listTableThemeData.hoverColor;
      final Color highlightColor = listTableThemeData.highlightColor ??
          _listTableThemeData.highlightColor;
      final Color background =
          listTableThemeData.background ?? _listTableThemeData.background;
      final Color borderColor =
          listTableThemeData.borderColor ?? _listTableThemeData.borderColor;
      final Color borderHoverColor = listTableThemeData.borderHoverColor ??
          _listTableThemeData.borderHoverColor;
      final Color borderHighlightColor =
          listTableThemeData.borderHighlightColor ??
              _listTableThemeData.borderHighlightColor;
      final Color borderIndicatorColor =
          listTableThemeData.borderIndicatorColor ??
              _listTableThemeData.borderIndicatorColor;

      return listTableThemeData.copyWith(
        iconThemeData: iconThemeData,
        itemHeight: itemHeight,
        textStyle: textStyle,
        selectedColor: selectedColor,
        selectedHighlightColor: selectedHighlightColor,
        selectedHoverColor: selectedHoverColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        background: background,
        borderColor: borderColor,
        borderHoverColor: borderHoverColor,
        borderHighlightColor: borderHighlightColor,
        borderIndicatorColor: borderIndicatorColor,
      );
    }

    assert(listTableThemeData._isConcrete);

    return listTableThemeData;
  }

  @override
  bool updateShouldNotify(ListTableTheme oldWidget) => data != oldWidget.data;
}
