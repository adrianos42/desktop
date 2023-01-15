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
  });

  /// The style for the text. The color is ignored.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.body2.copyWith(fontSize: kDefaultFontSize)
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

  /// Makes a copy of [TreeThemeData] overwriting selected fields.
  TreeThemeData copyWith({
    TextStyle? textStyle,
    Color? color,
    Color? hoverColor,
    Color? highlightColor,
  }) {
    return TreeThemeData(
      textStyle: textStyle ?? this.textStyle,
      color: color ?? this.color,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
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
    );
  }

  bool get _isConcrete {
    return textStyle != null &&
        color != null &&
        hoverColor != null &&
        highlightColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      textStyle,
      color,
      hoverColor,
      highlightColor,
    );
  }

  @override
  String toString() {
    return r'''
textStyle: The style for the text. The color is ignored.

 Defaults to:

 ```dart
 textTheme.body2.copyWith(fontSize: kDefaultFontSize)
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
    return other is TreeThemeData &&
        other.textStyle == textStyle &&
        other.color == color &&
        other.hoverColor == hoverColor &&
        other.highlightColor == highlightColor;
  }
}

/// Inherited theme for [TreeThemeData].
@immutable
class TreeTheme extends InheritedTheme {
  /// Creates a [TreeTheme].
  const TreeTheme({
    super.key,
    required super.child,
    required this.data,
  });

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
      builder: (context) => TreeTheme(
        data: TreeTheme.of(context).merge(data),
        child: child,
      ),
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
  }) {
    return Builder(
      key: key,
      builder: (context) => TreeTheme(
        data: TreeTheme.of(context).copyWith(
          textStyle: textStyle,
          color: color,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [TreeTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final TreeTheme? treeTheme =
        context.findAncestorWidgetOfExactType<TreeTheme>();
    return identical(this, treeTheme)
        ? child
        : TreeTheme(data: data, child: child);
  }

  /// Returns the nearest [TreeTheme].
  static TreeThemeData of(BuildContext context) {
    final TreeTheme? treeTheme =
        context.dependOnInheritedWidgetOfExactType<TreeTheme>();
    TreeThemeData? treeThemeData = treeTheme?.data;

    if (treeThemeData == null || !treeThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      treeThemeData ??= themeData.treeTheme;

      final _treeThemeData =
          _TreeThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final TextStyle textStyle =
          treeThemeData.textStyle ?? _treeThemeData.textStyle;
      final Color color = treeThemeData.color ?? _treeThemeData.color;
      final Color hoverColor =
          treeThemeData.hoverColor ?? _treeThemeData.hoverColor;
      final Color highlightColor =
          treeThemeData.highlightColor ?? _treeThemeData.highlightColor;

      return treeThemeData.copyWith(
        textStyle: textStyle,
        color: color,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
      );
    }

    assert(treeThemeData._isConcrete);

    return treeThemeData;
  }

  @override
  bool updateShouldNotify(TreeTheme oldWidget) => data != oldWidget.data;
}
