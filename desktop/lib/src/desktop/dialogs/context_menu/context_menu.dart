import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../component.dart';
import '../../scrolling/scrollbar.dart';
import '../../theme/theme.dart';
import 'context_menu_layout.dart';

const double _kDividerHeight = 1.0;
const double _kDividerThickness = 1.0;

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
    if (hovered) {
      setState(() => hovered = false);
    }
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) {
      setState(() {
        pressed = true;
      });
    }
  }

  void _handleTapUp(TapUpDetails event) {
    _ContextScope._of<T>(context)._close(widget.value);
  }

  void _handleTapCancel() {
    if (pressed) {
      setState(() {
        pressed = false;
      });
    }
  }

  bool _globalPointerDown = false;

  void _mouseRoute(PointerEvent event) => _globalPointerDown = event.down;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.pointerRouter.addGlobalRoute(_mouseRoute);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.pointerRouter.removeGlobalRoute(_mouseRoute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ContextMenuThemeData contextMenuThemeData =
        ContextMenuTheme.of(context);

    final bool selected = widget.selected(context);

    final Color background = pressed
        ? (selected
            ? contextMenuThemeData.selectedHighlightColor!
            : contextMenuThemeData.highlightColor!) // TODO(as): ???
        : selected
            ? (hovered
                ? contextMenuThemeData.selectedHoverColor!
                : contextMenuThemeData.selectedColor!)
            : hovered
                ? contextMenuThemeData.hoverColor! // TODO(as): ???
                : contextMenuThemeData.background!;

    final Color? foreground =
        hovered ? contextMenuThemeData.selectedForeground : null;

    Widget item = DefaultTextStyle(
      style: contextMenuThemeData.textStyle!.copyWith(color: foreground),
      child: IconTheme(
        data: contextMenuThemeData.iconThemeData!,
        child: Container(
          color: background,
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
      ignoring: !widget.enabled,
      child: MouseRegion(
        cursor: widget.enabled ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: widget.enabled ? (event) => _handleHoverEntered() : null,
        onHover: widget.enabled ? (event) => _handleHoverEntered() : null,
        onExit: widget.enabled ? (event) => _handleHoverExited() : null,
        opaque: false,
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTapDown: widget.enabled ? _handleTapDown : null,
          onTapUp: widget.enabled ? _handleTapUp : null,
          onTapCancel: widget.enabled ? _handleTapCancel : null,
          onVerticalDragStart: (event) => _handleHoverExited(),
          onHorizontalDragStart: (event) => _handleHoverExited(),
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
    final Color background = Theme.of(context).colorScheme.background[0];

    return SizedBox(
      height: _kDividerHeight,
      child: Center(
        child: Container(
          height: _kDividerThickness,
          color: background,
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
  _ContextMenu({
    Key? key,
    this.semanticLabel,
  }) : super(key: key);

  _ContextController<T> controller(BuildContext context) =>
      _ContextScope._of<T>(context);

  final String? semanticLabel;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ContextMenuThemeData contextMenuThemeData =
        ContextMenuTheme.of(context);

    final double menuWidth =
        controller(context).width ?? contextMenuThemeData.minMenuWidth!;

    final children = controller(context).items.map((item) {
      final bool selected;

      if (controller(context).value != null) {
        selected = item.represents(controller(context).value!);
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

    final contextView = SingleChildScrollView(
      controller: scrollController,
      child: ListBody(children: children),
    );

    final Widget child = ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: menuWidth,
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
            thickness: 4.0, // TODO(as): Use in scrollbar theme instead.
            controller: scrollController,
            child: controller(context).width == null
                ? IntrinsicWidth(
                    stepWidth: contextMenuThemeData.menuWidthStep!,
                    child: contextView)
                : contextView,
          ),
        ),
      ),
    );

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: const AlwaysStoppedAnimation(1.0),
        curve: Curves.easeOut,
        reverseCurve: Curves.easeOut.flipped,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: contextMenuThemeData.background!,
        ),
        position: DecorationPosition.background,
        child: child,
      ),
    );
  }
}

class _ContextScope<T> extends InheritedWidget {
  const _ContextScope(
    this.contextController, {
    required Widget child,
  }) : super(child: child);

  final _ContextController<T> contextController;

  static _ContextController<T> _of<T>(BuildContext context) {
    final _ContextController<T> scope = context
        .dependOnInheritedWidgetOfExactType<_ContextScope<T>>()!
        .contextController;
    return scope;
  }

  @override
  bool updateShouldNotify(_ContextScope oldWidget) => false;
}

class _ContextController<T> {
  _ContextController._({
    this.value,
    this.width,
    required this.items,
    required this.position,
    this.contextMenuThemeData,
    String? semanticLabel,
  }) : _completer = Completer<T?>() {
    _overlayEntry = OverlayEntry(
      builder: (context) => _ContextScope<T>(
        this,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _close(null),
          child: CustomSingleChildLayout(
            delegate: ContextMenuLayoutDelegate(position),
            child: SizedBox(
              width: width,
              child: GestureDetector(
                behavior: HitTestBehavior.deferToChild,
                onTap: () {},
                child: contextMenuThemeData != null
                    ? ContextMenuTheme(
                        child: _ContextMenu<T>(semanticLabel: semanticLabel),
                        data: contextMenuThemeData!,
                      )
                    : _ContextMenu<T>(semanticLabel: semanticLabel),
              ),
            ),
          ),
        ),
      ),
    );
  }

  late OverlayEntry _overlayEntry;

  final Completer<T?> _completer;

  final List<ContextMenuEntry<T>> items;

  final Rect position;

  final double? width;

  final T? value;

  final ContextMenuThemeData? contextMenuThemeData;

  void _close(T? completeValue) {
    _overlayEntry.remove();
    _completer.complete(completeValue ?? value);
  }
}

/// Shows a menu given a relative position for the target.
Future<T?> showMenu<T>({
  required BuildContext context,
  required List<ContextMenuEntry<T>> items,
  required Rect position,
  double? width,
  String? semanticLabel,
  String? barrierLabel,
  T? initialValue,
  ContextMenuThemeData? contextMenuThemeData,
}) {
  assert(items.isNotEmpty);

  final controller = _ContextController<T>._(
    value: initialValue,
    width: width,
    items: items,
    position: position,
    semanticLabel: semanticLabel,
    contextMenuThemeData: contextMenuThemeData,
  );

  Overlay.of(context, rootOverlay: true)!.insert(controller._overlayEntry);

  return controller._completer.future;
}

typedef ContextMenuItemSelected<T> = void Function(T value);

typedef ContextMenuCanceled = void Function();

typedef ContextMenuItemBuilder<T> = List<ContextMenuEntry<T>> Function(
    BuildContext context);
