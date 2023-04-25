// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrollbar.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Scrollbar].
@immutable
class ScrollbarThemeData {
  /// Creates a [ScrollbarThemeData].
  const ScrollbarThemeData({
    this.disabledColor,
    this.color,
    this.hoverColor,
    this.highlightColor,
    this.inhoverColor,
    this.foreground,
    this.trackColor,
  });

  ///
  final Color? disabledColor;

  ///
  final Color? color;

  ///
  final Color? hoverColor;

  ///
  final Color? highlightColor;

  ///
  final Color? inhoverColor;

  ///
  final Color? foreground;

  ///
  final Color? trackColor;

  /// Makes a copy of [ScrollbarThemeData] overwriting selected fields.
  ScrollbarThemeData copyWith({
    Color? disabledColor,
    Color? color,
    Color? hoverColor,
    Color? highlightColor,
    Color? inhoverColor,
    Color? foreground,
    Color? trackColor,
  }) {
    return ScrollbarThemeData(
      disabledColor: disabledColor ?? this.disabledColor,
      color: color ?? this.color,
      hoverColor: hoverColor ?? this.hoverColor,
      highlightColor: highlightColor ?? this.highlightColor,
      inhoverColor: inhoverColor ?? this.inhoverColor,
      foreground: foreground ?? this.foreground,
      trackColor: trackColor ?? this.trackColor,
    );
  }

  /// Merges the theme data [ScrollbarThemeData].
  ScrollbarThemeData merge(ScrollbarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      disabledColor: other.disabledColor,
      color: other.color,
      hoverColor: other.hoverColor,
      highlightColor: other.highlightColor,
      inhoverColor: other.inhoverColor,
      foreground: other.foreground,
      trackColor: other.trackColor,
    );
  }

  bool get _isConcrete {
    return disabledColor != null &&
        color != null &&
        hoverColor != null &&
        highlightColor != null &&
        inhoverColor != null &&
        foreground != null &&
        trackColor != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      disabledColor,
      color,
      hoverColor,
      highlightColor,
      inhoverColor,
      foreground,
      trackColor,
    );
  }

  @override
  String toString() {
    return r'''
disabledColor:;;color:;;hoverColor:;;highlightColor:;;inhoverColor:;;foreground:;;trackColor:;;
''';
  }

  @override
  bool operator ==(covariant ScrollbarThemeData other) {
    return identical(this, other) ||
        other.disabledColor == disabledColor &&
            other.color == color &&
            other.hoverColor == hoverColor &&
            other.highlightColor == highlightColor &&
            other.inhoverColor == inhoverColor &&
            other.foreground == foreground &&
            other.trackColor == trackColor;
  }
}

/// Inherited theme for [ScrollbarThemeData].
@immutable
class ScrollbarTheme extends InheritedTheme {
  /// Creates a [ScrollbarTheme].
  const ScrollbarTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [ScrollbarTheme].
  final ScrollbarThemeData data;

  /// Merges the nearest [ScrollbarTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required ScrollbarThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => ScrollbarTheme(
        data: ScrollbarTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [ScrollbarTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    Color? disabledColor,
    Color? color,
    Color? hoverColor,
    Color? highlightColor,
    Color? inhoverColor,
    Color? foreground,
    Color? trackColor,
  }) {
    return Builder(
      key: key,
      builder: (context) => ScrollbarTheme(
        data: ScrollbarTheme.of(context).copyWith(
          disabledColor: disabledColor,
          color: color,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          inhoverColor: inhoverColor,
          foreground: foreground,
          trackColor: trackColor,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [ScrollbarTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final ScrollbarTheme? scrollbarTheme =
        context.findAncestorWidgetOfExactType<ScrollbarTheme>();
    return identical(this, scrollbarTheme)
        ? child
        : ScrollbarTheme(data: data, child: child);
  }

  /// Returns the nearest [ScrollbarTheme].
  static ScrollbarThemeData of(BuildContext context) {
    final ScrollbarTheme? scrollbarTheme =
        context.dependOnInheritedWidgetOfExactType<ScrollbarTheme>();
    ScrollbarThemeData? scrollbarThemeData = scrollbarTheme?.data;

    if (scrollbarThemeData == null || !scrollbarThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      scrollbarThemeData ??= themeData.scrollbarTheme;

      final _scrollbarThemeData =
          _ScrollbarThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final Color disabledColor =
          scrollbarThemeData.disabledColor ?? _scrollbarThemeData.disabledColor;
      final Color color = scrollbarThemeData.color ?? _scrollbarThemeData.color;
      final Color hoverColor =
          scrollbarThemeData.hoverColor ?? _scrollbarThemeData.hoverColor;
      final Color highlightColor = scrollbarThemeData.highlightColor ??
          _scrollbarThemeData.highlightColor;
      final Color inhoverColor =
          scrollbarThemeData.inhoverColor ?? _scrollbarThemeData.inhoverColor;
      final Color foreground =
          scrollbarThemeData.foreground ?? _scrollbarThemeData.foreground;
      final Color trackColor =
          scrollbarThemeData.trackColor ?? _scrollbarThemeData.trackColor;

      return scrollbarThemeData.copyWith(
        disabledColor: disabledColor,
        color: color,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        inhoverColor: inhoverColor,
        foreground: foreground,
        trackColor: trackColor,
      );
    }

    assert(scrollbarThemeData._isConcrete);

    return scrollbarThemeData;
  }

  @override
  bool updateShouldNotify(ScrollbarTheme oldWidget) => data != oldWidget.data;
}
