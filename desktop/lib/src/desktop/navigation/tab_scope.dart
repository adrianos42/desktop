import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef RouteBuilder = Route<dynamic>? Function(BuildContext, RouteSettings);

class TabScope extends InheritedWidget {
  const TabScope({
    Key? key,
    required Widget child,
    required this.axis,
    this.currentIndex,
  })   : super(key: key, child: child);

  final Axis axis;

  final int? currentIndex;

  @override
  bool updateShouldNotify(TabScope old) => true;

  static TabScope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TabScope>();
}
