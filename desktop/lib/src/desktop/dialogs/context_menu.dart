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

const double _kDividerHeight = 1.0;
const double _kDividerThickness = 1.0;
const Duration _kMenuDuration = Duration(milliseconds: 100);

abstract class ContextMenuEntry<T> extends StatefulWidget {
  const ContextMenuEntry({Key? key}) : super(key: key);

  /// If the item represents the same given value.
  bool represents(T value);

  /// If the item is selected.
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
    this.height,
    required this.child,
  }) : super(key: key);

  final T value;

  final bool enabled;

  final double? height;

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

  void _handleHoverEntered() {
    if (!hovered && (pressed || !_globalPointerDown)) {
      setState(() => hovered = true);
    }
  }

  void _handleHoverExited() {
    if (hovered && !_globalPointerDown) {
      setState(() => hovered = false);
    }
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) {
      setState(() {
        pressed = true;
      } );
    }
  }

  void _handleTapUp(TapUpDetails event) {
    Navigator.pop<T>(context, widget.value);
  }

  void _handleTapCancel() {
    if (pressed) {
      setState(() {
        pressed = false;
      } );
    }
  }

  bool _globalPointerDown = false;

  void _mouseRoute(PointerEvent event) => _globalPointerDown = event.down;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.pointerRouter.addGlobalRoute(_mouseRoute);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.pointerRouter.removeGlobalRoute(_mouseRoute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ContextMenuThemeData contextMenuThemeData =
        ContextMenuTheme.of(context);

    final bool selected = widget.selected(context);

    final HSLColor? background = pressed
        ? (selected
            ? contextMenuThemeData.selectedHighlightColor!
            : contextMenuThemeData.highlightColor!) // TODO(as): ???
        : selected
            ? (hovered
                ? contextMenuThemeData.selectedHoverColor!
                : contextMenuThemeData.selectedColor!)
            : hovered
                ? contextMenuThemeData.hoverColor! // TODO(as): ???
                : null;

    Widget item = DefaultTextStyle(
      style: contextMenuThemeData.textStyle!,
      child: IconTheme(
        data: contextMenuThemeData.iconThemeData!,
        child: Container(
          color: background?.toColor(),
          padding: EdgeInsets.symmetric(
            horizontal: contextMenuThemeData.menuHorizontalPadding!,
          ),
          alignment: AlignmentDirectional.centerStart,
          constraints: BoxConstraints(
            minHeight: widget.height ?? contextMenuThemeData.itemHeight!,
            maxHeight: widget.height ?? contextMenuThemeData.itemHeight!,
          ),
          child: buildChild(),
        ),
      ),
    );

    item = IgnorePointer(
      ignoring: !widget.enabled, //|| selected == null,
      child: MouseRegion(
        cursor: widget.enabled ?  SystemMouseCursors.click : MouseCursor.defer,
        onEnter: widget.enabled ? (event) => _handleHoverEntered() : null,
        onExit: widget.enabled ? (event) => _handleHoverExited() : null,
        onHover: widget.enabled ? (event) => _handleHoverEntered() : null,
        opaque: false,
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTapDown: widget.enabled ? _handleTapDown : null,
          onTapUp: widget.enabled ? _handleTapUp : null,
          onTapCancel: widget.enabled ? _handleTapCancel : null,
          child: item,
        ),
      ),
    );

    return item;
  }
}

/// A divider used in context menu.
class ContextMenuDivider extends ContextMenuEntry {
  /// Creates a [ContextMenuDivider].
  const ContextMenuDivider({Key? key}) : super(key: key);

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
      height: _kDividerHeight,
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
    final ContextMenuThemeData contextMenuThemeData =
        ContextMenuTheme.of(context);

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
        minWidth: route.width ?? contextMenuThemeData.minMenuWidth!,
        maxWidth: route.width ?? contextMenuThemeData.maxMenuWidth!,
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
              stepWidth: route.width == null
                  ? contextMenuThemeData.menuWidthStep!
                  : null,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: ListBody(children: children),
              ),
            ),
          ),
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: contextMenuThemeData.background!.toColor(),
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

  //@override
  //Color? get barrierColor => const HSLColor.fromAHSL(0.1, 0.0, 0.0, 1.0).toColor();

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
          curve: Curves.easeOut,
          reverseCurve: Curves.easeOut.flipped,
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
