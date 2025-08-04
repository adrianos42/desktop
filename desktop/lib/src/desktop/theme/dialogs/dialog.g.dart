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
    this.menuPadding,
    this.menuSpacing,
    this.titlePadding,
    this.bodyPadding,
    this.background,
    this.barrierColor,
    this.titleTextStyle,
    this.bodyTextAlign,
    this.imageFilter,
    this.constraints,
  });

  /// The [EdgeInsets] padding of the menu.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0)
  /// ```
  final EdgeInsets? menuPadding;

  /// The spacing the menu items.
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// 16.0
  /// ```
  final double? menuSpacing;

  /// The title [EdgeInsets] padding of the title.
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
  /// colorScheme.background[20].withValues(alpha: (0.8)
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

  /// The [BoxConstraints] of the [Dialog].
  ///
  /// Defaults to:
  ///
  /// ```dart
  /// BoxConstraints(minWidth: 640.0, minHeight: 120.0)
  /// ```
  final BoxConstraints? constraints;

  /// Makes a copy of [DialogThemeData] overwriting selected fields.
  DialogThemeData copyWith({
    EdgeInsets? menuPadding,
    double? menuSpacing,
    EdgeInsets? titlePadding,
    EdgeInsets? bodyPadding,
    Color? background,
    Color? barrierColor,
    TextStyle? titleTextStyle,
    TextAlign? bodyTextAlign,
    ImageFilter? imageFilter,
    BoxConstraints? constraints,
  }) {
    return DialogThemeData(
      menuPadding: menuPadding ?? this.menuPadding,
      menuSpacing: menuSpacing ?? this.menuSpacing,
      titlePadding: titlePadding ?? this.titlePadding,
      bodyPadding: bodyPadding ?? this.bodyPadding,
      background: background ?? this.background,
      barrierColor: barrierColor ?? this.barrierColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      bodyTextAlign: bodyTextAlign ?? this.bodyTextAlign,
      imageFilter: imageFilter ?? this.imageFilter,
      constraints: constraints ?? this.constraints,
    );
  }

  /// Merges the theme data [DialogThemeData].
  DialogThemeData merge(DialogThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      menuPadding: other.menuPadding,
      menuSpacing: other.menuSpacing,
      titlePadding: other.titlePadding,
      bodyPadding: other.bodyPadding,
      background: other.background,
      barrierColor: other.barrierColor,
      titleTextStyle: other.titleTextStyle,
      bodyTextAlign: other.bodyTextAlign,
      imageFilter: other.imageFilter,
      constraints: other.constraints,
    );
  }

  bool get _isConcrete {
    return menuPadding != null &&
        menuSpacing != null &&
        titlePadding != null &&
        bodyPadding != null &&
        background != null &&
        barrierColor != null &&
        titleTextStyle != null &&
        bodyTextAlign != null &&
        imageFilter != null &&
        constraints != null;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      menuPadding,
      menuSpacing,
      titlePadding,
      bodyPadding,
      background,
      barrierColor,
      titleTextStyle,
      bodyTextAlign,
      imageFilter,
      constraints,
    ]);
  }

  @override
  String toString() {
    return r'''
menuPadding: The [EdgeInsets] padding of the menu.

 Defaults to:

 ```dart
 EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0)
 ```;;menuSpacing: The spacing the menu items.

 Defaults to:

 ```dart
 16.0
 ```;;titlePadding: The title [EdgeInsets] padding of the title.

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
 colorScheme.background[20].withValues(alpha: (0.8)
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
 ```;;constraints: The [BoxConstraints] of the [Dialog].

 Defaults to:

 ```dart
 BoxConstraints(minWidth: 640.0, minHeight: 120.0)
 ```;;
''';
  }

  @override
  bool operator ==(covariant DialogThemeData other) {
    return identical(this, other) ||
        other.menuPadding == menuPadding &&
            other.menuSpacing == menuSpacing &&
            other.titlePadding == titlePadding &&
            other.bodyPadding == bodyPadding &&
            other.background == background &&
            other.barrierColor == barrierColor &&
            other.titleTextStyle == titleTextStyle &&
            other.bodyTextAlign == bodyTextAlign &&
            other.imageFilter == imageFilter &&
            other.constraints == constraints;
  }
}

/// Inherited theme for [DialogThemeData].
@immutable
class DialogTheme extends InheritedTheme {
  /// Creates a [DialogTheme].
  const DialogTheme({super.key, required super.child, required this.data});

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
      builder: (context) =>
          DialogTheme(data: DialogTheme.of(context).merge(data), child: child),
    );
  }

  /// Makes a copy of the nearest [DialogTheme] overwriting selected fields.
  static Widget copyWith({
    Key? key,
    required Widget child,
    EdgeInsets? menuPadding,
    double? menuSpacing,
    EdgeInsets? titlePadding,
    EdgeInsets? bodyPadding,
    Color? background,
    Color? barrierColor,
    TextStyle? titleTextStyle,
    TextAlign? bodyTextAlign,
    ImageFilter? imageFilter,
    BoxConstraints? constraints,
  }) {
    return Builder(
      key: key,
      builder: (context) => DialogTheme(
        data: DialogTheme.of(context).copyWith(
          menuPadding: menuPadding,
          menuSpacing: menuSpacing,
          titlePadding: titlePadding,
          bodyPadding: bodyPadding,
          background: background,
          barrierColor: barrierColor,
          titleTextStyle: titleTextStyle,
          bodyTextAlign: bodyTextAlign,
          imageFilter: imageFilter,
          constraints: constraints,
        ),
        child: child,
      ),
    );
  }

  /// Returns a copy of [DialogTheme] with the specified [child].
  @override
  Widget wrap(BuildContext context, Widget child) {
    final DialogTheme? dialogTheme = context
        .findAncestorWidgetOfExactType<DialogTheme>();
    return identical(this, dialogTheme)
        ? child
        : DialogTheme(data: data, child: child);
  }

  /// Returns the nearest [DialogTheme].
  static DialogThemeData of(BuildContext context) {
    final DialogTheme? dialogTheme = context
        .dependOnInheritedWidgetOfExactType<DialogTheme>();
    DialogThemeData? dialogThemeData = dialogTheme?.data;

    if (dialogThemeData == null || !dialogThemeData._isConcrete) {
      final ThemeData themeData = Theme.of(context);

      dialogThemeData ??= themeData.dialogTheme;

      final dialogValue = _DialogThemeData(themeData);

      final EdgeInsets menuPadding =
          dialogThemeData.menuPadding ?? dialogValue.menuPadding;
      final double menuSpacing =
          dialogThemeData.menuSpacing ?? dialogValue.menuSpacing;
      final EdgeInsets titlePadding =
          dialogThemeData.titlePadding ?? dialogValue.titlePadding;
      final EdgeInsets bodyPadding =
          dialogThemeData.bodyPadding ?? dialogValue.bodyPadding;
      final Color background =
          dialogThemeData.background ?? dialogValue.background;
      final Color barrierColor =
          dialogThemeData.barrierColor ?? dialogValue.barrierColor;
      final TextStyle titleTextStyle =
          dialogThemeData.titleTextStyle ?? dialogValue.titleTextStyle;
      final TextAlign bodyTextAlign =
          dialogThemeData.bodyTextAlign ?? dialogValue.bodyTextAlign;
      final ImageFilter imageFilter =
          dialogThemeData.imageFilter ?? dialogValue.imageFilter;
      final BoxConstraints constraints =
          dialogThemeData.constraints ?? dialogValue.constraints;

      return dialogThemeData.copyWith(
        menuPadding: menuPadding,
        menuSpacing: menuSpacing,
        titlePadding: titlePadding,
        bodyPadding: bodyPadding,
        background: background,
        barrierColor: barrierColor,
        titleTextStyle: titleTextStyle,
        bodyTextAlign: bodyTextAlign,
        imageFilter: imageFilter,
        constraints: constraints,
      );
    }

    assert(dialogThemeData._isConcrete);

    return dialogThemeData;
  }

  @override
  bool updateShouldNotify(DialogTheme oldWidget) => data != oldWidget.data;
}
