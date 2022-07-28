import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme_data.dart';
import 'theme_text.dart';
import 'constants.dart';

const double _kPadding = 8.0;
const double _kFontSize = 14.0;

@immutable
class TreeThemeData {
  ///
  const TreeThemeData({
    this.textStyle,
    this.color,
    this.hoverColor,
    this.highlightColor,
  });

  /// The style for the text. The color is ignored.
  final TextStyle? textStyle;

  /// The color of the tree item.
  final Color? color;

  /// The hover color of the tree item.
  final Color? hoverColor;

  /// The highlight color of the tree item.
  final Color? highlightColor;

  ///
  TreeThemeData copyWidth({
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

  @override
  int get hashCode {
    return Object.hash(
      textStyle,
      color,
      hoverColor,
      highlightColor,
    );
  }

  ///
  bool get isConcrete {
    return textStyle != null &&
        color != null &&
        hoverColor != null &&
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
    return other is TreeThemeData &&
        other.textStyle == textStyle &&
        other.color == color &&
        other.hoverColor == hoverColor &&
        other.highlightColor == highlightColor;
  }
}

///
@immutable
class TreeTheme extends InheritedTheme {
  ///
  const TreeTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  /// The tree theme data.
  final TreeThemeData data;

  ///
  static TreeThemeData of(BuildContext context) {
    final TreeTheme? treeTheme =
        context.dependOnInheritedWidgetOfExactType<TreeTheme>();
    TreeThemeData? treeThemeData = treeTheme?.data;

    if (treeThemeData == null || !treeThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      treeThemeData ??= themeData.treeTheme;

      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      final TextStyle textStyle = treeThemeData.textStyle ??
          textTheme.body2.copyWith(fontSize: _kFontSize);

      final Color color =
          treeThemeData.color ?? colorScheme.shade[kInactiveColorIndex];

      final Color hoverColor =
          treeThemeData.hoverColor ?? colorScheme.shade[kHoverColorIndex];

      final Color highlightColor = treeThemeData.highlightColor ??
          colorScheme.primary[kHighlightColorIndex];

      treeThemeData = treeThemeData.copyWidth(
        textStyle: textStyle,
        color: color,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
      );
    }

    assert(treeThemeData.isConcrete);

    return treeThemeData;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final TreeTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<TreeTheme>();
    return identical(this, ancestorTheme)
        ? child
        : TreeTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(TreeTheme oldWidget) => data != oldWidget.data;
}
