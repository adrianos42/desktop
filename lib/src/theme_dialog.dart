import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';

const EdgeInsets _kDialogPadding = EdgeInsets.all(16.0);
const EdgeInsets _kTitlePadding = EdgeInsets.only(bottom: 16.0);
const EdgeInsets _kMenuPadding = EdgeInsets.only(top: 16.0);
const EdgeInsets _kOutsidePadding = EdgeInsets.symmetric(vertical: 32.0);
const double _kMinDialogWidth = 640.0;
const double _kMinDialogHeight = 200.0;

class DialogThemeData {
  const DialogThemeData({
    this.dialogPadding = _kDialogPadding,
    this.outsidePadding = _kOutsidePadding,
    this.titlePadding = _kTitlePadding,
    this.menuPadding = _kMenuPadding,
    this.constraints = const BoxConstraints(
      minWidth: _kMinDialogWidth,
      minHeight: _kMinDialogHeight,
    ),
    this.background,
    this.barrierColor,
  })  : assert(dialogPadding != null),
        assert(outsidePadding != null),
        assert(titlePadding != null),
        assert(menuPadding != null),
        assert(constraints != null);

  final BoxConstraints constraints;

  final EdgeInsets menuPadding;

  final EdgeInsets titlePadding;

  final EdgeInsets outsidePadding;

  final EdgeInsets dialogPadding;

  final Color background;

  final Color barrierColor;

  DialogThemeData copyWidth({
    BoxConstraints constraints,
    EdgeInsets menuPadding,
    EdgeInsets titlePadding,
    EdgeInsets outsidePadding,
    EdgeInsets dialogPadding,
    Color background,
    Color barrierColor,
  }) {
    return DialogThemeData(
      constraints: constraints ?? this.constraints,
      menuPadding: menuPadding ?? this.menuPadding,
      titlePadding: titlePadding ?? this.titlePadding,
      outsidePadding: outsidePadding ?? this.outsidePadding,
      dialogPadding: dialogPadding ?? this.dialogPadding,
      background: background ?? this.background,
      barrierColor: barrierColor ?? this.barrierColor,
    );
  }

  bool get isConcrete {
    return constraints != null &&
        menuPadding != null &&
        titlePadding != null &&
        outsidePadding != null &&
        dialogPadding != null &&
        background != null &&
        barrierColor != null;
  }

  @override
  int get hashCode {
    return hashValues(
      constraints,
      menuPadding,
      titlePadding,
      outsidePadding,
      dialogPadding,
      background,
      barrierColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is DialogThemeData &&
        other.constraints == constraints &&
        other.menuPadding == menuPadding &&
        other.titlePadding == titlePadding &&
        other.outsidePadding == outsidePadding &&
        other.dialogPadding == dialogPadding &&
        other.background == background &&
        other.barrierColor == barrierColor;
  }
}

class DialogTheme extends InheritedTheme {
  const DialogTheme({
    @required this.data,
    Widget child,
    Key key,
  })  : assert(data != null),
        super(child: child);

  final DialogThemeData data;

  static DialogThemeData of(BuildContext context) {
    final DialogTheme dialogTheme =
        context.dependOnInheritedWidgetOfExactType<DialogTheme>();
    DialogThemeData dialogThemeData = dialogTheme?.data;

    if (dialogThemeData?.background == null ||
        dialogThemeData.barrierColor == null) {
      final ThemeData themeData = Theme.of(context);
      dialogThemeData ??= themeData.dialogTheme;

      if (dialogThemeData.background == null) {
        dialogThemeData = dialogThemeData.copyWidth(
            background: themeData.colorScheme.background);
      }

      if (dialogThemeData.barrierColor == null) {
        dialogThemeData =
            dialogThemeData.copyWidth(barrierColor: Color(0x80404040));
      }
    }

    assert(dialogThemeData.isConcrete);

    return dialogThemeData;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final DialogTheme ancestorTheme =
        context.findAncestorWidgetOfExactType<DialogTheme>();
    return identical(this, ancestorTheme)
        ? child
        : DialogTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(DialogTheme oldWidget) => data != oldWidget.data;
}
