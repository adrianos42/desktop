// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog.dart';

// **************************************************************************
// ThemeDataGenerator
// **************************************************************************

/// Theme data for [Dialog].
@immutable
class DialogThemeData {
  /// Creates a [DialogThemeData].
  const DialogThemeData({
    this.constraints,
    this.menuPadding,
    this.titlePadding,
    this.bodyPadding,
    this.background,
    this.barrierColor,
    this.titleTextStyle,
    this.bodyTextAlign,
    this.imageFilter,
  });

  /// The [BoxConstraints] of the [Dialog].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// BoxConstraints(minWidth: 640.0, minHeight: 120.0)
  /// ```
  final BoxConstraints? constraints;

  /// The [EdgeInsets] padding of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0)
  /// ```
  final EdgeInsets? menuPadding;

  /// The title [EdgeInsets] pagging of the title.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0)
  /// ```
  final EdgeInsets? titlePadding;

  /// The body [EdgeInsets] padding of the body.
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.all(16.0)
  /// ```
  final EdgeInsets? bodyPadding;

  /// The background color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[0]
  /// ```
  final Color? background;

  /// The barrier color.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// colorScheme.background[20].withOpacity(0.8)
  /// ```
  final Color? barrierColor;

  /// The [TextStyle] for the title.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// textTheme.title
  /// ```
  final TextStyle? titleTextStyle;

  /// The [TextAlign] of the body text.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// TextAlign.left
  /// ```
  final TextAlign? bodyTextAlign;

  /// The [ImageFilter] used for the dialog`s barrier.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0)
  /// ```
  final ImageFilter? imageFilter;

  /// Makes a copy of [DialogThemeData] overwriting selected fields.
  DialogThemeData copyWith({
    BoxConstraints? constraints,
    EdgeInsets? menuPadding,
    EdgeInsets? titlePadding,
    EdgeInsets? bodyPadding,
    Color? background,
    Color? barrierColor,
    TextStyle? titleTextStyle,
    TextAlign? bodyTextAlign,
    ImageFilter? imageFilter,
  }) {
    return DialogThemeData(
      constraints: constraints ?? this.constraints,
      menuPadding: menuPadding ?? this.menuPadding,
      titlePadding: titlePadding ?? this.titlePadding,
      bodyPadding: bodyPadding ?? this.bodyPadding,
      background: background ?? this.background,
      barrierColor: barrierColor ?? this.barrierColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      bodyTextAlign: bodyTextAlign ?? this.bodyTextAlign,
      imageFilter: imageFilter ?? this.imageFilter,
    );
  }

  /// Merges the theme data [DialogThemeData].
  DialogThemeData merge(DialogThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      constraints: other.constraints,
      menuPadding: other.menuPadding,
      titlePadding: other.titlePadding,
      bodyPadding: other.bodyPadding,
      background: other.background,
      barrierColor: other.barrierColor,
      titleTextStyle: other.titleTextStyle,
      bodyTextAlign: other.bodyTextAlign,
      imageFilter: other.imageFilter,
    );
  }

  bool get _isConcrete {
    return constraints != null &&
        menuPadding != null &&
        titlePadding != null &&
        bodyPadding != null &&
        background != null &&
        barrierColor != null &&
        titleTextStyle != null &&
        bodyTextAlign != null &&
        imageFilter != null;
  }

  @override
  int get hashCode {
    return Object.hash(
      constraints,
      menuPadding,
      titlePadding,
      bodyPadding,
      background,
      barrierColor,
      titleTextStyle,
      bodyTextAlign,
      imageFilter,
    );
  }

  @override
  String toString() {
    return r'''
constraints: The [BoxConstraints] of the [Dialog].
 
 Defaults to:
 
 ```dart
 BoxConstraints(minWidth: 640.0, minHeight: 120.0)
 ```;;menuPadding: The [EdgeInsets] padding of the menu.
 
 Defaults to:
 
 ```dart
 EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0)
 ```;;titlePadding: The title [EdgeInsets] pagging of the title.
 
 Defaults to:
 
 ```dart
 EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0)
 ```;;bodyPadding: The body [EdgeInsets] padding of the body.
 Defaults to:
 
 ```dart
 EdgeInsets.all(16.0)
 ```;;background: The background color.
 
 Defaults to:
 
 ```dart
 colorScheme.background[0]
 ```;;barrierColor: The barrier color.
 
 Defaults to:
 
 ```dart
 colorScheme.background[20].withOpacity(0.8)
 ```;;titleTextStyle: The [TextStyle] for the title.
 
 Defaults to:
 
 ```dart
 textTheme.title
 ```;;bodyTextAlign: The [TextAlign] of the body text.
 
 Defaults to:
 
 ```dart
 TextAlign.left
 ```;;imageFilter: The [ImageFilter] used for the dialog`s barrier.
 
 Defaults to:
 
 ```dart
 ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0)
 ```;;
''';
  }

  @override
  bool operator ==(covariant DialogThemeData other) {
    return identical(this, other) ||
        other.constraints == constraints &&
            other.menuPadding == menuPadding &&
            other.titlePadding == titlePadding &&
            other.bodyPadding == bodyPadding &&
            other.background == background &&
            other.barrierColor == barrierColor &&
            other.titleTextStyle == titleTextStyle &&
            other.bodyTextAlign == bodyTextAlign &&
            other.imageFilter == imageFilter;
  }
}

/// Inherited theme for [DialogThemeData].
@immutable
class DialogTheme extends InheritedTheme {
  /// Creates a [DialogTheme].
  const DialogTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The data representing this [DialogTheme].
  final DialogThemeData data;

  /// Merges the nearest [DialogTheme] with a specified [child].
  static Widget merge({
    Key? key,
    required DialogThemeData data,
    required Widget child,
  }) {
    return Builder(
      key: key,
      builder: (context) => DialogTheme(
        data: DialogTheme.of(context).merge(data),
        child: child,
      ),
    );
  }

  /// Makes a copy of the nearest [DialogTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    BoxConstraints? constraints,
    EdgeInsets? menuPadding,
    EdgeInsets? titlePadding,
    EdgeInsets? bodyPadding,
    Color? background,
    Color? barrierColor,
    TextStyle? titleTextStyle,
    TextAlign? bodyTextAlign,
    ImageFilter? imageFilter,
  }) {
    return Builder(
      key: key,
      builder: (context) => DialogTheme(
        data: DialogTheme.of(context).copyWith(
          constraints: constraints,
          menuPadding: menuPadding,
          titlePadding: titlePadding,
          bodyPadding: bodyPadding,
          background: background,
          barrierColor: barrierColor,
          titleTextStyle: titleTextStyle,
          bodyTextAlign: bodyTextAlign,
          imageFilter: imageFilter,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [DialogTheme] with the specified [child].
  @override
  Widget wrap(
    BuildContext context,
    Widget child,
  ) {
    final DialogTheme? dialogTheme =
        context.findAncestorWidgetOfExactType<DialogTheme>();
    return identical(this, dialogTheme)
        ? child
        : DialogTheme(data: data, child: child);
  }

  /// Returns the nearest [DialogTheme].
  static DialogThemeData of(BuildContext context) {
    final DialogTheme? dialogTheme =
        context.dependOnInheritedWidgetOfExactType<DialogTheme>();
    DialogThemeData? dialogThemeData = dialogTheme?.data;

    if (dialogThemeData == null || !dialogThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;
      final ColorScheme colorScheme = themeData.colorScheme;

      dialogThemeData ??= themeData.dialogTheme;

      final _dialogThemeData =
          _DialogThemeData(textTheme: textTheme, colorScheme: colorScheme);

      final BoxConstraints constraints =
          dialogThemeData.constraints ?? _dialogThemeData.constraints;
      final EdgeInsets menuPadding =
          dialogThemeData.menuPadding ?? _dialogThemeData.menuPadding;
      final EdgeInsets titlePadding =
          dialogThemeData.titlePadding ?? _dialogThemeData.titlePadding;
      final EdgeInsets bodyPadding =
          dialogThemeData.bodyPadding ?? _dialogThemeData.bodyPadding;
      final Color background =
          dialogThemeData.background ?? _dialogThemeData.background;
      final Color barrierColor =
          dialogThemeData.barrierColor ?? _dialogThemeData.barrierColor;
      final TextStyle titleTextStyle =
          dialogThemeData.titleTextStyle ?? _dialogThemeData.titleTextStyle;
      final TextAlign bodyTextAlign =
          dialogThemeData.bodyTextAlign ?? _dialogThemeData.bodyTextAlign;
      final ImageFilter imageFilter =
          dialogThemeData.imageFilter ?? _dialogThemeData.imageFilter;

      return dialogThemeData.copyWith(
        constraints: constraints,
        menuPadding: menuPadding,
        titlePadding: titlePadding,
        bodyPadding: bodyPadding,
        background: background,
        barrierColor: barrierColor,
        titleTextStyle: titleTextStyle,
        bodyTextAlign: bodyTextAlign,
        imageFilter: imageFilter,
      );
    }

    assert(dialogThemeData._isConcrete);

    return dialogThemeData;
  }

  @override
  bool updateShouldNotify(DialogTheme oldWidget) => data != oldWidget.data;
}
