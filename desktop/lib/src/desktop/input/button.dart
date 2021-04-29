import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../dialogs/tooltip.dart';
import '../theme/theme.dart';

// Generic button used for other kinds
class Button extends StatefulWidget {
  const Button({
    Key? key,
    this.body,
    this.trailing,
    this.leading,
    this.tooltip,
    this.color,
    this.onPressed,
    this.leadingPadding,
    this.padding,
    this.bodyPadding,
    this.trailingPadding,
    this.axis = Axis.horizontal,
  })  : assert(body != null || trailing != null || leading != null),
        super(key: key);

  final String? tooltip;

  final Widget? body;

  /// Widget to place at the end of the button.
  final Widget? trailing;

  final Widget? leading;

  final VoidCallback? onPressed;

  final HSLColor? color;

  final Axis axis;

  final EdgeInsets? leadingPadding;

  final EdgeInsets? trailingPadding;

  final EdgeInsets? bodyPadding;

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
      _controller.reset();
      _controller.forward();
      setState(() => pressed = false);
    }
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) {
      _controller.reset();
      _controller.forward();
      setState(() => pressed = true);
    }
  }

  void _handleTapCancel() {
    if (pressed) {
      _controller.reset();
      _controller.forward();
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
      duration: const Duration(milliseconds: 50),
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
    final HSLColor pressedForeground = buttonThemeData.highlightColor!;
    final HSLColor hoveredForeground = buttonThemeData.hoverColor!;
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
    double? height;
    double? width;

    if (widget.axis == Axis.horizontal) {
      constraints = BoxConstraints(
        maxHeight: buttonThemeData.height!,
        minHeight: buttonThemeData.height!,
        minWidth: buttonThemeData.minWidth!,
      );
      height = buttonThemeData.height;
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
        maxWidth: buttonThemeData.height!,
        minWidth: buttonThemeData.height!,
        minHeight: buttonThemeData.minWidth!,
      );
      width = buttonThemeData.height;
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

    result = SizedBox(
      child: result,
      height: height,
      width: width,
      //alignment: widget.alignment,
    );

    result = MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: enabled ? (_) => _handleHoverEntered() : null,
      onExit: (_) => _handleHoverExited(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
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
