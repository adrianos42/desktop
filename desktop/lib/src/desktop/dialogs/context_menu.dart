import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../localizations.dart';
import '../navigation/route.dart';
import '../theme/theme.dart';
import '../scrolling/scrollbar.dart';

const Duration _kMenuDuration = Duration(microseconds: 200);
const double _kDividerThickness = 1.0;
const double _kMenuWidthStep = 120.0;
const double _kDividerHeight = 1.0;

const double kMenuHorizontalPadding = 16.0;
const double kMinMenuWidth = 2.0 * _kMenuWidthStep;
const double kMaxMenuWidth = 6.0 * _kMenuWidthStep;
const double kDefaultItemHeight = 34.0;
const double kMinMenuHeight = kDefaultItemHeight;
const double kMaxMenuHeight = kDefaultItemHeight;

abstract class ContextMenuEntry<T> extends StatefulWidget {
  const ContextMenuEntry({Key? key}) : super(key: key);

  double get height;

  bool represents(T value);

  bool selected(BuildContext context) =>
      _MenuItemSelected.itemSelected(context) ?? false;
}

class _MenuItem extends SingleChildRenderObjectWidget {
  const _MenuItem({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderMenuItem();
}

class _RenderMenuItem extends RenderShiftedBox {
  _RenderMenuItem([RenderBox? child]) : super(child);

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child == null) {
      return Size.zero;
    }
    return child!.getDryLayout(constraints);
  }

  @override
  void performLayout() {
    if (child == null) {
      size = Size.zero;
    } else {
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child!.size);
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Offset.zero;
    }
  }
}

class ContextMenuItem<T> extends ContextMenuEntry<T> {
  const ContextMenuItem({
    Key? key,
    required this.value,
    this.enabled = true,
    this.height = kDefaultItemHeight,
    required this.child,
  }) : super(key: key);

  final T value;

  final bool enabled;

  @override
  final double height;

  final Widget child;

  @override
  bool represents(T value) => value == this.value;

  @override
  ContextMenuItemState<T, ContextMenuItem<T>> createState() =>
      ContextMenuItemState<T, ContextMenuItem<T>>();
}

class ContextMenuItemState<T, W extends ContextMenuItem<T>> extends State<W>
    with ComponentStateMixin {
  @protected
  Widget buildChild() => widget.child;

  @protected
  void handleTap() {
    Navigator.pop<T>(context, widget.value);
  }

  void _handleHoverChanged(bool value) {
    if (hovered != value) {
      setState(() => hovered = value);
    }
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) {
      setState(() => pressed = true);
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (pressed) {
      setState(() => pressed = false);
    }
  }

  void _handleTapCancel() {
    if (pressed) {
      setState(() => pressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    final bool selected = widget.selected(context);

    final HSLColor? background = pressed
        ? (selected
            ? colorScheme.primary[60]
            : colorScheme.background[4]) // TODO(as): ???
        : selected
            ? (hovered ? colorScheme.primary[40] : colorScheme.primary[30])
            : hovered
                ? colorScheme.background[16] // TODO(as): ???
                : null;

    final foreground = textTheme.textHigh;

    final TextStyle textStyle = textTheme.body1.copyWith(
      fontSize: 14.0,
      color: foreground.toColor(),
    );

    Widget item = DefaultTextStyle(
      style: textStyle,
      child: IconTheme(
        data: IconThemeData(
          color: foreground.toColor(),
          size: 18.0,
        ),
        child: Container(
          color: background?.toColor(),
          padding:
              const EdgeInsets.symmetric(horizontal: kMenuHorizontalPadding),
          alignment: AlignmentDirectional.centerStart,
          constraints: BoxConstraints(
            minHeight: widget.height,
            maxHeight: widget.height,
          ),
          child: buildChild(),
        ),
      ),
    );

    item = IgnorePointer(
      ignoring: !widget.enabled, //|| selected == null,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => _handleHoverChanged(true),
        onExit: (event) => _handleHoverChanged(false),
        opaque: false,
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: widget.enabled ? handleTap : null,
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: item,
        ),
      ),
    );

    return item;
  }
}

class ContextMenuDivider extends ContextMenuEntry {
  const ContextMenuDivider({Key? key}) : super(key: key);

  @override
  double get height => _kDividerHeight;

  @override
  bool represents(void value) => false;

  @override
  _ContextMenuDividerState createState() => _ContextMenuDividerState();
}

class _ContextMenuDividerState extends State<ContextMenuDivider> {
  @override
  Widget build(BuildContext context) {
    final HSLColor background = Theme.of(context).colorScheme.background;

    return SizedBox(
      height: widget.height,
      child: Center(
        child: Container(
          height: _kDividerThickness,
          color: background.toColor(),
        ),
      ),
    );
  }
}

class _MenuItemSelected extends InheritedWidget {
  const _MenuItemSelected({
    Key? key,
    required Widget child,
    required this.selected,
  }) : super(key: key, child: child);

  final bool selected;

  static bool? itemSelected(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_MenuItemSelected>()
        ?.selected;
  }

  @override
  bool updateShouldNotify(_MenuItemSelected old) => selected != old.selected;
}

class _ContextMenu<T> extends StatelessWidget {
  const _ContextMenu({
    Key? key,
    required this.route,
    this.semanticLabel,
  }) : super(key: key);

  final _ContextMenuRoute<T> route;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final children = route.items.map((item) {
      final bool selected;

      if (route.value != null) {
        selected = item.represents(route.value!);
      } else {
        selected = false;
      }

      return _MenuItem(
        child: _MenuItemSelected(
          child: item,
          selected: selected,
        ),
      );
    }).toList();

    final Widget child = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: route.width ?? kMinMenuWidth,
        maxWidth: route.width ?? kMaxMenuWidth,
      ),
      child: Semantics(
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        label: semanticLabel,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Scrollbar(
            isAlwaysShown: false,
            child: IntrinsicWidth(
              stepWidth: route.width == null ? _kMenuWidthStep : null,
              child: SingleChildScrollView(
                child: ListBody(children: children),
              ),
            ),
          ),
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.background[4].toColor(),
        //border: Border.all(width: 1.0, color: colorScheme.background[20].toColor()),
      ),
      position: DecorationPosition.background,
      child: child,
    );
  }
}

class _ContextMenuRoute<T> extends ContextRoute<T> {
  _ContextMenuRoute({
    required this.items,
    this.value,
    this.barrierLabel,
    this.semanticLabel,
    this.width,
    required this.rootNavigator,
    required this.position,
    required RouteSettings settings,
  }) : super(settings: settings);

  final List<ContextMenuEntry<T>> items;
  final T? value;
  final String? semanticLabel;
  final Rect position;
  final double? width;
  final bool rootNavigator;

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  Color? get barrierColor => null;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    int? selectedItemIndex;

    if (value != null) {
      for (int index = 0;
          selectedItemIndex == null && index < items.length;
          index += 1) {
        if (items[index].represents(value!)) {
          selectedItemIndex = index;
        }
      }
    }

    final Widget menu = _ContextMenu<T>(
      route: this,
      semanticLabel: semanticLabel,
    );

    return CustomSingleChildLayout(
      delegate: _ContextMenuRouteLayout(position, rootNavigator),
      child: menu,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        ),
        child: child);
  } // Some default transition
}

class _ContextMenuRouteLayout extends SingleChildLayoutDelegate {
  _ContextMenuRouteLayout(
    this.position,
    this.rootNavigator,
  );

  final Rect position;
  final bool rootNavigator;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxHeight = constraints.maxHeight;
    final double maxWidth = constraints.maxWidth;
    final Size size = Size(
      max(position.left, maxWidth - position.right),
      max(position.top, maxHeight - position.bottom),
    );
    return BoxConstraints.loose(size);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double y;
    if (size.height - position.bottom >= childSize.height) {
      y = position.bottom;
    } else if (childSize.height <= position.top) {
      y = position.top - childSize.height;
    } else {
      y = 0;
      throw Exception('Could not fit height for menu');
    }

    double x;
    if (size.width - position.left >= childSize.width) {
      x = position.left;
    } else if (childSize.width <= position.right) {
      x = position.right - childSize.width;
    } else {
      x = 0;
      throw Exception('Could not fit width for menu');
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_ContextMenuRouteLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}

/// Shows a menu given a relative position for the target.
Future<T?> showMenu<T>({
  required BuildContext context,
  required List<ContextMenuEntry<T>> items,
  required Rect position,
  required RouteSettings settings,
  double? width,
  String? semanticLabel,
  String? barrierLabel,
  T? initialValue,
  bool rootNavigator = true,
}) {
  assert(items.isNotEmpty);

  final String? label = semanticLabel;

  return Navigator.of(context, rootNavigator: rootNavigator).push(
    _ContextMenuRoute<T>(
      items: items,
      value: initialValue,
      semanticLabel: label,
      position: position,
      width: width,
      settings: settings,
      rootNavigator: rootNavigator,
      barrierLabel: barrierLabel ??
          DesktopLocalizations.of(context).modalBarrierDismissLabel,
    ),
  );
}

typedef ContextMenuItemSelected<T> = void Function(T value);

typedef ContextMenuCanceled = void Function();

typedef ContextMenuItemBuilder<T> = List<ContextMenuEntry<T>> Function(
    BuildContext context);
