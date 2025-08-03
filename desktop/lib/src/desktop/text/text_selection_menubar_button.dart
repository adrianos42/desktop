import 'package:flutter/widgets.dart';

import '../component.dart';
import '../theme/dialogs/context_menu.dart';

class TextSelectionMenubarButton extends StatefulWidget {
  const TextSelectionMenubarButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;

  final Widget child;

  bool get enabled => onPressed != null;

  @override
  State<StatefulWidget> createState() => _TextSelectionMenubarButtonState();
}

class _TextSelectionMenubarButtonState extends State<TextSelectionMenubarButton>
    with ComponentStateMixin {
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
    setState(() => pressed = false);
    widget.onPressed?.call();
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

    final Color background = pressed
        ? contextMenuThemeData.highlightColor! // TODO(as): ???
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
            minHeight: contextMenuThemeData.itemHeight!,
          ),
          child: widget.child,
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
