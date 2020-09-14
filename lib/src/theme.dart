import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'theme_data.dart';

export 'theme_data.dart' show ThemeData;

class Theme extends StatelessWidget {
  const Theme({
    Key key,
    @required this.data,
    @required this.child,
  })  : assert(data != null),
        assert(child != null),
        super(key: key);

  final ThemeData data;

  static ThemeData of(BuildContext context) {
    final _InheritedTheme inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return inheritedTheme?.theme?.data ?? ThemeData.dark();
  }

  static Brightness brightnessOf(BuildContext context) {
    final _InheritedTheme inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();

    assert(inheritedTheme != null);

    return inheritedTheme.theme.data.brightness;
  }

  final Widget child;

  static invertedThemeOf(BuildContext context) {
    final _InheritedTheme inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();

    assert(inheritedTheme != null);

    return inheritedTheme.theme.data.invertedTheme;
  }

  @override
  build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: Builder(
        builder: (context) => DefaultTextStyle(
          style: of(context).textTheme.body1,
          child: child,
        ),
      ),
    );
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    Key key,
    @required this.theme,
    @required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final Theme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final _InheritedTheme ancestorTheme = context.findAncestorWidgetOfExactType<_InheritedTheme>();
    return identical(this, ancestorTheme) ? child : Theme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) =>
      theme.data != old.theme.data;
}
