// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Tree].
@immutable
class TreeThemeData {
  /// Creates a [TreeThemeData].
  const TreeThemeData({
    this.textStyle,
    this.color,
    this.hoverColor,
    this.highlightColor,
    this.indicatorHighlightColor,
    this.indicatorHoverColor,
    this.indicatorColor,
  });

  /// The style for the text. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: defaultFontSize)
  /// ```
  final TextStyle? textStyle;

  /// The color of the tree item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textLow
  /// ```
  final Color? color;

  /// The hover color of the tree item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  final Color? hoverColor;

  /// The highlight color of the tree item.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  final Color? highlightColor;

  /// The indicator highlight color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.primary[60]
  /// ```
  final Color? indicatorHighlightColor;

  /// The indicator hover highlight color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.textHigh
  /// ```
  final Color? indicatorHoverColor;

  /// The indicator color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20]
  /// ```
  final Color? indicatorColor;

  /// Makes a copy of [TreeThemeData] overwriting selected fields.
  TreeThemeData copyWith({
    TextStyle? textStyle,
    Color? color,
    Color? hoverColor,
    Color? highlightColor,
    Color? indicatorHighlightColor,
    Color? indicatorHoverColor,
    Color? indicatorColor,
  }) {
    return TreeThemeData(
      textStyle: textStyle ?? this.textStyle,
      color: color ?? this.color,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
      indicatorHighlightColor:
          indicatorHighlightColor ?? this.indicatorHighlightColor,
      indicatorHoverColor: indicatorHoverColor ?? this.indicatorHoverColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
    );
  }

  /// Merges the theme data [TreeThemeData].
  TreeThemeData merge(TreeThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textStyle: other.textStyle,
      color: other.color,
      hoverColor: other.hoverColor,
      highlightColor: other.highlightColor,
      indicatorHighlightColor: other.indicatorHighlightColor,
      indicatorHoverColor: other.indicatorHoverColor,
      indicatorColor: other.indicatorColor,
    );
  }

  bool get _isConcrete {
    return textStyle != null &&
        color != null &&
        hoverColor != null &&
        highlightColor != null &&
        indicatorHighlightColor != null &&
        indicatorHoverColor != null &&
        indicatorColor != null;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      textStyle,
      color,
      hoverColor,
      highlightColor,
      indicatorHighlightColor,
      indicatorHoverColor,
      indicatorColor,
    ]);
  }

  @override
  String toString() {
    return r'''
textStyle: The style for the text. The color is ignored.

 Defaults to:

 ```dart
 textTheme.body2.copyWith(fontSize: defaultFontSize)
 ```;;color: The color of the tree item.

 Defaults to:

 ```dart
 textTheme.textLow
 ```;;hoverColor: The hover color of the tree item.

 Defaults to:

 ```dart
 textTheme.textHigh
 ```;;highlightColor: The highlight color of the tree item.

 Defaults to:

 ```dart
 colorScheme.primary[60]
 ```;;indicatorHighlightColor: The indicator highlight color.

 Defaults to:

 ```dart
 colorScheme.primary[60]
 ```;;indicatorHoverColor: The indicator hover highlight color.

 Defaults to:

 ```dart
 textTheme.textHigh
 ```;;indicatorColor: The indicator color.

 Defaults to:

 ```dart
 colorScheme.background[20]
 ```;;
''';
  }

  @override
  bool operator ==(covariant TreeThemeData other) {
    return identical(this, other) ||
        other.textStyle == textStyle &&
            other.color == color &&
            other.hoverColor == hoverColor &&
            other.highlightColor == highlightColor &&
            other.indicatorHighlightColor == indicatorHighlightColor &&
            other.indicatorHoverColor == indicatorHoverColor &&
            other.indicatorColor == indicatorColor;
  }
}

/// Inherited theme for [TreeThemeData].
@immutable
class TreeTheme extends InheritedTheme {
  /// Creates a [TreeTheme].
  const TreeTheme({super.key, required super.child, required this.data});

  /// The data representing this [TreeTheme].
  final TreeThemeData data;

  /// Merges the nearest [TreeTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required TreeThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) =>
          TreeTheme(data: TreeTheme.of(context).merge(data), child: child),
    );
  }

  /// Makes a copy of the nearest [TreeTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    TextStyle? textStyle,
    Color? color,
    Color? hoverColor,
    Color? highlightColor,
    Color? indicatorHighlightColor,
    Color? indicatorHoverColor,
    Color? indicatorColor,
  }) {
    return Builder(
      key: key,
      builder: (context) => TreeTheme(
        data: TreeTheme.of(context).copyWith(
          textStyle: textStyle,
          color: color,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          indicatorHighlightColor: indicatorHighlightColor,
          indicatorHoverColor: indicatorHoverColor,
          indicatorColor: indicatorColor,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [TreeTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final TreeTheme? treeTheme = context
        .findAncestorWidgetOfExactType<TreeTheme>();
    return identical(this, treeTheme)
        ? child
        : TreeTheme(data: data, child: child);
  }

  /// Returns the nearest [TreeTheme].
  static TreeThemeData of(BuildContext context) {
    final TreeTheme? treeTheme = context
        .dependOnInheritedWidgetOfExactType<TreeTheme>();
    TreeThemeData? treeThemeData = treeTheme?.data;

    if (treeThemeData == null || !treeThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      treeThemeData ??= themeData.treeTheme;

      final treeValue = _TreeThemeData(themeData);

      final TextStyle textStyle =
          treeThemeData.textStyle ?? treeValue.textStyle;
      final Color color = treeThemeData.color ?? treeValue.color;
      final Color hoverColor = treeThemeData.hoverColor ?? treeValue.hoverColor;
      final Color highlightColor =
          treeThemeData.highlightColor ?? treeValue.highlightColor;
      final Color indicatorHighlightColor =
          treeThemeData.indicatorHighlightColor ??
          treeValue.indicatorHighlightColor;
      final Color indicatorHoverColor =
          treeThemeData.indicatorHoverColor ?? treeValue.indicatorHoverColor;
      final Color indicatorColor =
          treeThemeData.indicatorColor ?? treeValue.indicatorColor;

      return treeThemeData.copyWith(
        textStyle: textStyle,
        color: color,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        indicatorHighlightColor: indicatorHighlightColor,
        indicatorHoverColor: indicatorHoverColor,
        indicatorColor: indicatorColor,
      );
    }

    assert(treeThemeData._isConcrete);

    return treeThemeData;
  }

  @override
  bool updateShouldNotify(TreeTheme oldWidget) => data != oldWidget.data;
}
