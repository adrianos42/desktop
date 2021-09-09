import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../dialogs/tooltip.dart';
import '../theme/theme.dart';

/// Base button used to create other kinds of buttons.
class Button extends StatefulWidget {
  ///
  const Button({
    Key? key,
    this.body,
    this.trailing,
    this.leading,
    this.tooltip,
    this.color,
    this.hoverColor,
    this.highlightColor,
    this.onPressed,
    this.leadingPadding,
    this.padding,
    this.bodyPadding,
    this.trailingPadding,
    this.axis = Axis.horizontal,
  })  : assert(body != null || trailing != null || leading != null),
        super(key: key);

  /// Creates a button with a text.
  factory Button.text(
    String text, {
    double? fontSize,
    String? tooltip,
    HSLColor? color,
    HSLColor? highlightColor,
    HSLColor? hoverColor,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Key? key,
  }) {
    return Button(
      body: Text(
        text,
        style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
      ),
      padding: padding,
      bodyPadding: padding != null ? EdgeInsets.zero : null,
      color: color,
      highlightColor: highlightColor,
      hoverColor: hoverColor,
      tooltip: tooltip,
      onPressed: onPressed,
      key: key,
    );
  }

  /// Creates a button with a icon.
  factory Button.icon(
    IconData icon, {
    String? tooltip,
    double? size,
    HSLColor? color,
    HSLColor? highlightColor,
    HSLColor? hoverColor,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Key? key,
  }) {
    return Button(
      body: Icon(icon, size: size),
      padding: padding,
      bodyPadding: padding != null ? EdgeInsets.zero : null,
      color: color,
      highlightColor: highlightColor,
      hoverColor: hoverColor,
      tooltip: tooltip,
      onPressed: onPressed,
      key: key,
    );
  }

  /// The button tooltip.
  final String? tooltip;

  /// The main widget placed in the button.
  final Widget? body;

  /// Widget to place at the end of the button.
  final Widget? trailing;

  /// Widget to place at the beginning of the button.
  final Widget? leading;

  /// Called when button is pressed.
  final VoidCallback? onPressed;

  /// The color of the button.
  final HSLColor? color;

  /// The color of the button when the is hovering it.
  final HSLColor? hoverColor;

  /// The color of the button when it's been pressed.
  final HSLColor? highlightColor;

  /// The button axis.
  final Axis axis;

  /// The leading padding.
  final EdgeInsets? leadingPadding;

  /// The trailing padding.
  final EdgeInsets? trailingPadding;

  /// The body padding.
  final EdgeInsets? bodyPadding;

  /// Padding of the button.
  final EdgeInsets? padding;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button>
    with ComponentStateMixin, SingleTickerProviderStateMixin {
  void _handleHoverEntered() {
    if (!hovered && (pressed || !_globalPointerDown)) {
      _controller.reset();
      _controller.forward();
      setState(() => hovered = true);
    }
  }

  void _handleHoverExited() {
    if (hovered) {
      _controller.reset();
      _controller.forward();
      setState(() => hovered = false);
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (pressed) {
      _controller.forward(from: 0.5);
      setState(() => pressed = false);
    }
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) {
      _controller.forward(from: 0.5);
      setState(() => pressed = true);
    }
  }

  void _handleTapCancel() {
    if (pressed) {
      _controller.forward(from: 0.5);
      setState(() => pressed = false);
    }
  }

  bool _globalPointerDown = false;

  void _mouseRoute(PointerEvent event) => _globalPointerDown = event.down;

  late AnimationController _controller;

  ColorTween? _color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _controller.forward();

    WidgetsBinding.instance!.pointerRouter.addGlobalRoute(_mouseRoute);
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance!.pointerRouter.removeGlobalRoute(_mouseRoute);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _color = null;
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.onPressed != null;
    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);

    final HSLColor enabledForeground = widget.color ?? buttonThemeData.color!;
    final HSLColor pressedForeground =
        widget.highlightColor ?? buttonThemeData.highlightColor!;
    final HSLColor hoveredForeground =
        widget.hoverColor ?? buttonThemeData.hoverColor!;

    final HSLColor disabledForeground = buttonThemeData.disabledColor!;

    final HSLColor foregroundColor = enabled
        ? waiting || pressed
            ? pressedForeground
            : hovered
                ? hoveredForeground
                : enabledForeground
        : disabledForeground;

    _color = ColorTween(
        begin: _color?.end ?? foregroundColor.toColor(),
        end: foregroundColor.toColor());

    final itemSpacing = buttonThemeData.itemSpacing!;

    final BoxConstraints constraints;
    final EdgeInsets leadingPadding;
    final EdgeInsets trailingPadding;
    final EdgeInsets bodyPadding;
    final EdgeInsets buttonPadding;

    if (widget.axis == Axis.horizontal) {
      constraints = BoxConstraints(
        minHeight: buttonThemeData.height!,
       // minWidth: buttonThemeData.minWidth!,
      );

      leadingPadding = widget.leadingPadding ??
          EdgeInsets.symmetric(horizontal: itemSpacing);
      trailingPadding = widget.trailingPadding ??
          EdgeInsets.symmetric(horizontal: itemSpacing);
      bodyPadding =
          widget.bodyPadding ?? EdgeInsets.symmetric(horizontal: itemSpacing);
      buttonPadding =
          widget.padding ?? EdgeInsets.symmetric(horizontal: itemSpacing);
    } else {
      constraints = BoxConstraints(
       // maxWidth: buttonThemeData.height!,
       // minWidth: buttonThemeData.height!,
        minHeight: buttonThemeData.minWidth!,
      );

      leadingPadding =
          widget.leadingPadding ?? EdgeInsets.symmetric(vertical: itemSpacing);
      trailingPadding =
          widget.trailingPadding ?? EdgeInsets.symmetric(vertical: itemSpacing);
      bodyPadding =
          widget.bodyPadding ?? EdgeInsets.symmetric(vertical: itemSpacing);
      buttonPadding =
          widget.padding ?? EdgeInsets.symmetric(vertical: itemSpacing);
    }

    Widget result = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final foreground =
            _color!.evaluate(AlwaysStoppedAnimation(_controller.value));

        final TextStyle textStyle = buttonThemeData.textStyle!.copyWith(
          color: foreground,
        );

        final IconThemeData iconThemeData =
            buttonThemeData.iconThemeData!.copyWith(
          color: foreground,
        );

        return DefaultTextStyle(
          style: textStyle,
          child: IconTheme(
            data: iconThemeData,
            child: Flex(
              direction: widget.axis,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.leading != null)
                  Padding(
                    padding: leadingPadding,
                    child: widget.leading,
                  ),
                // The widget that is always placed in the button.
                Padding(
                  padding: bodyPadding,
                  child: widget.body,
                ),
                if (widget.trailing != null)
                  Padding(
                    padding: trailingPadding,
                    child: widget.trailing,
                  ),
              ],
            ),
          ),
        );
      },
    );

    result = MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: enabled ? (_) => _handleHoverEntered() : null,
      onExit: (_) => _handleHoverExited(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: enabled ? _handleTapDown : null,
        onTapUp: enabled ? _handleTapUp : null,
        onTapCancel: _handleTapCancel,
        onTap: enabled
            ? () async {
                if (waiting) {
                  return;
                }
                setState(() => waiting = true);

                final dynamic result =
                    widget.onPressed!() as dynamic; // TODO(as): fix dynamic

                if (result is Future<void>) {
                  await result;
                }

                setState(() => waiting = false);
              }
            : null,
        child: result,
      ),
    );

    if (widget.tooltip != null) {
      result = Tooltip(
        message: widget.tooltip!,
        child: result,
      );
    }

    return Semantics(
      button: true,
      child: Container(
        padding: buttonPadding,
        constraints: constraints,
        child: result,
      ),
    );
  }
}
