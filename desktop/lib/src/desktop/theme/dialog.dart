import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'theme_data.dart';

const EdgeInsets _kbodyPadding = EdgeInsets.all(16.0);
const EdgeInsets _kTitlePadding = EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0);
const EdgeInsets _kMenuPadding = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0);
const double _kMinDialogWidth = 640.0;
const double _kMinDialogHeight = 120.0;

@immutable
class DialogThemeData {
  const DialogThemeData({
    this.bodyPadding = _kbodyPadding,
    this.titlePadding = _kTitlePadding,
    this.menuPadding = _kMenuPadding,
    this.titleTextStyle,
    this.bodyTextAlign,
    this.constraints = const BoxConstraints(
      minWidth: _kMinDialogWidth,
      minHeight: _kMinDialogHeight,
    ),
    this.background,
    this.barrierColor,
  });

  final BoxConstraints constraints;

  final EdgeInsets menuPadding;

  final EdgeInsets titlePadding;

  final EdgeInsets bodyPadding;

  final Color? background;

  final Color? barrierColor;

  final TextStyle? titleTextStyle;

  final TextAlign? bodyTextAlign;

  DialogThemeData copyWidth({
    BoxConstraints? constraints,
    EdgeInsets? menuPadding,
    EdgeInsets? titlePadding,
    EdgeInsets? bodyPadding,
    Color? background,
    Color? barrierColor,
    TextStyle? titleTextStyle,
    TextAlign? bodyTextAlign,
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
    );
  }

  bool get isConcrete {
    return background != null &&
        barrierColor != null &&
        titleTextStyle != null &&
        bodyTextAlign != null;
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
    return other is DialogThemeData &&
        other.constraints == constraints &&
        other.menuPadding == menuPadding &&
        other.titlePadding == titlePadding &&
        other.bodyPadding == bodyPadding &&
        other.background == background &&
        other.barrierColor == barrierColor &&
        other.titleTextStyle == titleTextStyle &&
        other.bodyTextAlign == bodyTextAlign;
  }
}

@immutable
class DialogTheme extends InheritedTheme {
  const DialogTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  final DialogThemeData data;

  static DialogThemeData of(BuildContext context) {
    final DialogTheme? dialogTheme =
        context.dependOnInheritedWidgetOfExactType<DialogTheme>();
    DialogThemeData? dialogThemeData = dialogTheme?.data;

    if (dialogThemeData == null || !dialogThemeData.isConcrete) {
      final ThemeData themeData = Theme.of(context);
      dialogThemeData ??= themeData.dialogTheme;

      final Color background =
          dialogThemeData.background ?? themeData.colorScheme.background[0];
      final Color barrierColor = dialogThemeData.barrierColor ??
          (themeData.colorScheme.brightness == Brightness.light
              ? const HSLColor.fromAHSL(0.8, 0.0, 0.0, 0.8).toColor()
              : const HSLColor.fromAHSL(0.8, 0.0, 0.0, 0.2).toColor());
      final TextStyle titleTextStyle =
          dialogThemeData.titleTextStyle ?? themeData.textTheme.title;
      final TextAlign bodyTextAlign =
          dialogThemeData.bodyTextAlign ?? TextAlign.justify;

      dialogThemeData = dialogThemeData.copyWidth(
        background: background,
        barrierColor: barrierColor,
        titleTextStyle: titleTextStyle,
        bodyTextAlign: bodyTextAlign,
      );
    }

    return dialogThemeData; // TODO(as): ???
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final DialogTheme? ancestorTheme =
        context.findAncestorWidgetOfExactType<DialogTheme>();
    return identical(this, ancestorTheme)
        ? child
        : DialogTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(DialogTheme oldWidget) => data != oldWidget.data;
}
