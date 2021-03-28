import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import '../navigation/route.dart';
import '../component.dart';

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
  void performLayout() {
    if (child == null) {
      size = Size.zero;
    } else {
      //// FIXME
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child!.size);

      // FIXME
      final BoxParentData childParentData = child!.parentData as BoxParentData;
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
    if (hovered != value) setState(() => hovered = value);
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) setState(() => pressed = true);
  }

  void _handleTapUp(TapUpDetails event) {
    if (pressed) setState(() => pressed = false);
  }

  void _handleTapCancel() {
    if (pressed) setState(() => pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final colorScheme = Theme.of(context).colorScheme;

    final bool selected = widget.selected(context);

    final HSLColor? background = pressed
        ? (selected ? colorScheme.primary : colorScheme.background3) // FIXME
        : selected
            ? (hovered ? colorScheme.primary1 : colorScheme.primary2)
            : hovered
                ? colorScheme.background2 // FIXME
                : null;

    final foreground = selected
        ? TextTheme(colorScheme.withBrightness(Brightness.dark))
            .textHigh // FIXME ???
        : textTheme.textHigh;

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
          constraints: BoxConstraints(minHeight: widget.height),
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

class ContextMenuDivider extends ContextMenuEntry<Null> {
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
    HSLColor background = Theme.of(context).colorScheme.background;

    return SizedBox(
        height: widget.height,
        child: Center(
          child: Container(
            height: _kDividerThickness,
            color: background.toColor(),
          ),
        ));
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
      final selected;

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
      child: IntrinsicWidth(
        //stepWidth: kMenuWidthStep,
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: semanticLabel,
          child: SingleChildScrollView(
            child: ListBody(
              children: children,
            ),
          ),
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.background1.toColor(),
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
    required this.position,
    required RouteSettings settings,
  }) : super(settings: settings);

  final List<ContextMenuEntry<T>> items;
  final T? value;
  final String? semanticLabel;
  final Rect position;
  final double? width;

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
        if (items[index].represents(value!)) selectedItemIndex = index;
      }
    }

    Widget menu = _ContextMenu<T>(
      route: this,
      semanticLabel: semanticLabel,
    );

    return CustomSingleChildLayout(
      delegate: _ContextMenuRouteLayout(position),
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
  );

  final Rect position;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.smallest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double? y;
    if (size.height - position.bottom >= childSize.height) {
      y = position.bottom;
    } else if (childSize.height <= position.top) {
      y = position.top - childSize.height;
    }

    assert(y != null, 'could not fit height');

    double? x;
    if (size.width - position.left >= childSize.width) {
      x = position.left;
    } else if (childSize.width <= position.right) {
      x = position.right - childSize.width;
    }

    assert(x != null, 'could not fit width');

    return Offset(x!, y!); // FIXME
  }

  @override
  bool shouldRelayout(_ContextMenuRouteLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}

Future<T?> showMenu<T>({
  required BuildContext context,
  required List<ContextMenuEntry<T>> items,
  required Rect position,
  required RouteSettings settings,
  double? width,
  String? semanticLabel,
  T? initialValue,
}) {
  assert(items.isNotEmpty);

  String? label = semanticLabel;

  return Navigator.of(context, rootNavigator: false).push(
    _ContextMenuRoute<T>(
      items: items,
      value: initialValue,
      semanticLabel: label,
      position: position,
      width: width,
      settings: settings,
    ),
  );
}

typedef ContextMenuItemSelected<T> = void Function(T value);

typedef ContextMenuCanceled = void Function();

typedef ContextMenuItemBuilder<T> = List<ContextMenuEntry<T>> Function(
    BuildContext context);
