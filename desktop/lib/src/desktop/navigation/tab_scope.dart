import 'package:flutter/widgets.dart';

class TabScope extends InheritedWidget {
  const TabScope({
    super.key,
    required super.child,
    required this.axis,
    this.currentIndex,
  });

  final Axis axis;

  final int? currentIndex;

  @override
  bool updateShouldNotify(TabScope oldWidget) =>
      oldWidget.axis != axis || oldWidget.currentIndex != currentIndex;

  static TabScope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TabScope>();
}
