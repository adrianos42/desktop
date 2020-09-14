import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'desktop.dart';
import 'tooltip.dart';
import 'theme_button.dart';

// Generic button used for other kinds
class Button extends StatefulWidget {
  const Button({
    Key key,
    this.body,
    this.trailing,
    this.leading,
    this.tooltip,
    this.color,
    @required this.onPressed,
  })  : assert(body != null || trailing != null || leading != null),
        super(key: key);

  final String tooltip;

  final Widget body;

  /// {@template desktop.Button.trailing}
  /// Widget to place at the end of the button.
  /// {@endtemplate}
  final Widget trailing;

  final Widget leading;

  final VoidCallback onPressed;

  final Color color;

  bool get enabled => onPressed != null;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with ComponentStateMixin {
  void _handleHoverEntered() {
    if (!hovered && (pressed || !_globalPointerDown))
      setState(() => hovered = true);
  }

  void _handleHoverExited() {
    if (hovered) setState(() => hovered = false);
  }

  void _handleTapUp(TapUpDetails event) {
    if (pressed) setState(() => pressed = false);
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) setState(() => pressed = true);
  }

  void _handleTapCancel() {
    if (pressed) setState(() => pressed = false);
  }

  bool _globalPointerDown = false;

  void _mouseRoute(event) => _globalPointerDown = event.down;

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
    final bool enabled = widget.enabled;

    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);

    final Color enabledForeground = widget.color ?? buttonThemeData.color;
    final Color pressedForeground = buttonThemeData.highlightColor;
    final Color hoveredForeground = buttonThemeData.hoverColor;
    final Color disabledForeground = buttonThemeData.disabledColor;

    final Color foregroundColor = enabled
        ? waiting || pressed
            ? pressedForeground
            : hovered ? hoveredForeground : enabledForeground
        : disabledForeground;

    final TextStyle textStyle = buttonThemeData.textStyle.copyWith(
      color: foregroundColor,
    );

    final IconThemeData iconThemeData = buttonThemeData.iconThemeData.copyWith(
      color: foregroundColor,
    );

    Widget result;

    result = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.leading != null)
          Padding(
            padding: buttonThemeData.leadingPadding,
            child: widget.leading,
          ),
        // The widget that is always placed in the button.
        Padding(
          padding: buttonThemeData.bodyPadding,
          child: widget.body,
        ),
        if (widget.trailing != null)
          Padding(
            padding: buttonThemeData.trailingPadding,
            child: widget.trailing,
          ),
      ],
    );

    result = Container(
      child: result,
      height: buttonThemeData.height,
    );

    result = DefaultTextStyle(
      style: textStyle,
      child: IconTheme(
        data: iconThemeData,
        child: result,
      ),
    );

    if (enabled) {
      result = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => _handleHoverEntered(),
        onExit: (_) => _handleHoverExited(),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: () {
            if (waiting) return;
            waiting = true;
            dynamic result = widget.onPressed() as dynamic;

            if (result is Future) {
              setState(() => waiting = true);
              result.then((_) => setState(() => waiting = false));
            } else {
              waiting = false;
            }
          },
          child: result,
        ),
      );

      if (widget.tooltip != null) {
        result = Tooltip(
          message: widget.tooltip,
          child: result,
        );
      }
    }

    return Semantics(
      button: true,
      child: Container(
        padding: buttonThemeData.buttonPadding,
        //alignment: Alignment.center,
        constraints: BoxConstraints(
          maxHeight: buttonThemeData.height,
          minHeight: buttonThemeData.height,
          minWidth: buttonThemeData.minWidth,
        ),
        child: result,
      ),
    );
  }
}
