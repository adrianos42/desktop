import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/widgets.dart';

import '../component.dart';
import '../dialogs/tooltip.dart';
import '../theme/theme.dart';

/// The base button which is used to create other kinds of buttons.
class Button extends StatefulWidget {
  /// Creates a [Button].
  const Button({
    Key? key,
    this.body,
    this.trailing,
    this.leading,
    this.tooltip,
    this.themeData,
    this.leadingPadding,
    this.padding,
    this.bodyPadding,
    this.trailingPadding,
    this.active,
    this.focusNode,
    this.canRequestFocus = true,
    this.autofocus = false,
    this.filled = false,
    required this.onPressed,
    this.willChangeState = false,
    this.enableAnimation = true,
  })  : assert(body != null || trailing != null || leading != null),
        super(key: key);

  /// Creates a button with a text.
  factory Button.text(
    String text, {
    double? fontSize,
    String? tooltip,
    ButtonThemeData? style,
    EdgeInsets? padding,
    Key? key,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autofocus = false,
    bool? active,
    bool willChangeState = false,
    required VoidCallback? onPressed,
  }) {
    return Button(
      body: Text(
        text,
        style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
      ),
      padding: padding,
      bodyPadding: padding != null ? EdgeInsets.zero : null,
      tooltip: tooltip,
      onPressed: onPressed,
      key: key,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      autofocus: autofocus,
      active: active,
      willChangeState: willChangeState,
      themeData: style,
      enableAnimation: true,
      filled: false,
    );
  }

  /// Creates a button with a icon.
  factory Button.icon(
    IconData icon, {
    String? tooltip,
    double? size,
    EdgeInsets? padding,
    Key? key,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autofocus = false,
    bool? active,
    bool willChangeState = false,
    required VoidCallback? onPressed,
    ButtonThemeData? style,
  }) {
    return Button(
      body: Icon(icon, size: size),
      padding: padding,
      bodyPadding: padding != null ? EdgeInsets.zero : null,
      tooltip: tooltip,
      onPressed: onPressed,
      key: key,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      autofocus: autofocus,
      active: active,
      willChangeState: willChangeState,
      enableAnimation: true,
      filled: false,
      themeData: style,
    );
  }

  /// Creates a button with a filled background.
  factory Button.filled(
    String text, {
    double? fontSize,
    String? tooltip,
    EdgeInsets? padding,
    Key? key,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autofocus = false,
    bool? active,
    bool enableAnimation = false,
    bool willChangeState = false,
    required VoidCallback? onPressed,
    ButtonThemeData? style,
  }) {
    return Button(
      body: Text(
        text,
        style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
      ),
      padding: padding,
      bodyPadding: padding != null ? EdgeInsets.zero : null,
      themeData: style,
      tooltip: tooltip,
      onPressed: onPressed,
      key: key,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      autofocus: autofocus,
      active: active,
      filled: true,
      willChangeState: willChangeState,
      enableAnimation: enableAnimation,
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

  /// The leading padding.
  final EdgeInsets? leadingPadding;

  /// The trailing padding.
  final EdgeInsets? trailingPadding;

  /// The body padding.
  final EdgeInsets? bodyPadding;

  /// Padding of the button.
  final EdgeInsets? padding;

  /// Forces the button highlight.
  final bool? active;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.canRequestFocus}
  final bool canRequestFocus;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// If the button fills a background.
  final bool filled;

  /// If animations are enabled.
  final bool enableAnimation;

  /// Heuristic to indicate that the active or onPressed will change.
  final bool willChangeState;

  /// The style [ButtonThemeData] of the button.
  final ButtonThemeData? themeData;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button>
    with ComponentStateMixin, SingleTickerProviderStateMixin {
  void _handleHoverEntered() {
    if (!hovered && !_globalPointerDown) {
      hovered = true;
      _updateColor();
    }
  }

  void _handleHoverExited() {
    if (hovered) {
      hovered = false;
      _updateColor();
    }
  }

  void _handleHover() {
    if (!hovered && !pressed && !_globalPointerDown) {
      hovered = true;
      _updateColor();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (pressed && !widget.willChangeState) {
      pressed = false;
      if (widget.active == null) {
        _updateColor();
      }
    }
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) {
      pressed = true;
      _updateColor();
    }
  }

  void _handleTapCancel() {
    pressed = false;
    hovered = false;
    _updateColor();
  }

  bool _globalPointerDown = false;

  void _mouseRoute(PointerEvent event) {
    _globalPointerDown = event.down;
  }

  late AnimationController _controller;

  ColorTween? _color;
  ColorTween? _backgroundColor;

  late final Map<Type, Action<Intent>> _actionMap = <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _invoke),
    ButtonActivateIntent:
        CallbackAction<ButtonActivateIntent>(onInvoke: _invoke),
  };

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ??
        NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return enabled && widget.canRequestFocus;
      case NavigationMode.directional:
        return true;
    }
  }

  bool get _shouldShowFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ??
        NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return enabled && focused;
      case NavigationMode.directional:
        return focused;
    }
  }

  bool get _focusHighlight {
    return FocusManager.instance.highlightMode ==
            FocusHighlightMode.traditional &&
        _shouldShowFocus;
  }

  void _invoke([Intent? intent]) => _handleTap();

  void _handleTap() => widget.onPressed?.call();

  void _handleFocusUpdate(bool hasFocus) {
    focused = hasFocus;
  }

  bool get active => widget.active ?? false;

  bool get enabled => widget.onPressed != null;

  void _updateColor([bool animates = true]) {
    if (mounted) {
      final ButtonThemeData buttonThemeData =
          ButtonTheme.of(context).merge(widget.themeData);

      final Color disabledForeground = buttonThemeData.disabledColor!;

      final Color foregroundColor;
      Color? backgroundColor;

      if (!widget.filled) {
        final Color pressedForeground = buttonThemeData.highlightColor!;

        final Color enabledForeground = buttonThemeData.color!;

        final Color hoveredForeground = buttonThemeData.hoverColor!;

        foregroundColor = enabled
            ? active || pressed
                ? pressedForeground
                : hovered || _focusHighlight
                    ? hoveredForeground
                    : enabledForeground
            : disabledForeground;
      } else {
        final Color pressedBackground = buttonThemeData.highlightBackground!;
        final Color enabledBackground = buttonThemeData.background!;
        final Color hoveredBackground = buttonThemeData.hoverBackground!;
        final Color pressedForeground = buttonThemeData.highlightForeground!;
        final Color enabledForeground = buttonThemeData.foreground!;
        final Color hoveredForeground = buttonThemeData.hoverForeground!;

        foregroundColor = active || pressed
            ? pressedForeground
            : hovered
                ? hoveredForeground
                : enabledForeground;

        backgroundColor = enabled
            ? active || pressed
                ? pressedBackground
                : hovered
                    ? hoveredBackground
                    : enabledBackground
            : Theme.of(context).colorScheme.background[0];
      }

      final bool wasPressed = pressed;
      final bool wasHovered = hovered;

      if (animates && widget.enableAnimation) {
        if (_controller.isAnimating) {
          return;
        }

        _controller.duration = buttonThemeData.animationDuration;

        _color = ColorTween(
          begin: _color?.end ?? foregroundColor,
          end: foregroundColor,
        );

        _backgroundColor = ColorTween(
          begin: _backgroundColor?.end ?? backgroundColor,
          end: backgroundColor,
        );

        _controller.forward(from: 0.0).then((_) {
          if (wasPressed != pressed || wasHovered != hovered) {
            _updateColor();
          }
        });
      } else {
        _color = ColorTween(
          begin: foregroundColor,
          end: foregroundColor,
        );

        _backgroundColor = ColorTween(
          begin: backgroundColor,
          end: backgroundColor,
        );

        _controller.value = 1.0;
      }
    }
  }

  void _statusController(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      value: 1.0,
    )..addStatusListener(_statusController);

    WidgetsBinding.instance.pointerRouter.addGlobalRoute(_mouseRoute);
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_statusController);
    _controller.dispose();
    WidgetsBinding.instance.pointerRouter.removeGlobalRoute(_mouseRoute);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateColor(false);
  }

  @override
  void didUpdateWidget(Button oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.active != widget.active ||
        oldWidget.onPressed != widget.onPressed ||
        oldWidget.filled != widget.filled) {
      pressed = false;
      _updateColor(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonThemeData =
        ButtonTheme.of(context).merge(widget.themeData);

    final itemSpacing = buttonThemeData.itemSpacing!;

    if (_color == null || widget.filled && _backgroundColor == null) {
      _updateColor(false);
    }

    final BoxConstraints constraints;
    final EdgeInsets leadingPadding;
    final EdgeInsets trailingPadding;
    final EdgeInsets bodyPadding;
    final EdgeInsets buttonPadding;

    if (buttonThemeData.axis == Axis.horizontal) {
      constraints = BoxConstraints(minHeight: buttonThemeData.height!);

      leadingPadding = widget.leadingPadding ??
          EdgeInsets.symmetric(horizontal: itemSpacing);
      trailingPadding = widget.trailingPadding ??
          EdgeInsets.symmetric(horizontal: itemSpacing);
      bodyPadding =
          widget.bodyPadding ?? EdgeInsets.symmetric(horizontal: itemSpacing);
      buttonPadding = widget.padding ??
          EdgeInsets.symmetric(
              horizontal: !widget.filled
                  ? itemSpacing
                  : buttonThemeData.filledSpacing!);
    } else {
      constraints = BoxConstraints(minHeight: buttonThemeData.minWidth!);

      leadingPadding =
          widget.leadingPadding ?? EdgeInsets.symmetric(vertical: itemSpacing);
      trailingPadding =
          widget.trailingPadding ?? EdgeInsets.symmetric(vertical: itemSpacing);
      bodyPadding =
          widget.bodyPadding ?? EdgeInsets.symmetric(vertical: itemSpacing);
      buttonPadding = widget.padding ??
          EdgeInsets.symmetric(
              vertical: !widget.filled
                  ? itemSpacing
                  : buttonThemeData.filledSpacing!);
    }

    Widget result = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final Color? foreground =
            _color!.evaluate(AlwaysStoppedAnimation(_controller.value));

        final Color? background = widget.filled
            ? _backgroundColor!
                .evaluate(AlwaysStoppedAnimation(_controller.value))
            : null;

        final TextStyle textStyle = buttonThemeData.textStyle!.copyWith(
          color: foreground,
        );

        final IconThemeData iconThemeData =
            buttonThemeData.iconThemeData!.copyWith(
          color: foreground,
        );

        Widget result = DefaultTextStyle(
          style: textStyle,
          child: IconTheme(
            data: iconThemeData,
            child: Flex(
              direction: buttonThemeData.axis!,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.leading != null)
                  Flexible(
                    child: Padding(
                      padding: leadingPadding,
                      child: widget.leading,
                    ),
                  ),
                // The widget that is always placed in the button.
                Flexible(
                  child: Padding(
                    padding: bodyPadding,
                    child: widget.body,
                  ),
                ),
                if (widget.trailing != null)
                  Flexible(
                    child: Padding(
                      padding: trailingPadding,
                      child: widget.trailing,
                    ),
                  ),
              ],
            ),
          ),
        );

        result = Container(
          padding: buttonPadding,
          constraints: constraints,
          color: background,
          child: result,
        );

        return ButtonScope(
          child: result,
          hovered: enabled && (hovered || _focusHighlight),
          pressed: enabled && pressed,
          active: enabled && active,
          disabled: !enabled,
          color: foreground!,
        );
      },
    );

    result = Actions(
      actions: _actionMap,
      child: Focus(
        focusNode: widget.focusNode,
        canRequestFocus: _canRequestFocus,
        onFocusChange: _handleFocusUpdate,
        autofocus: widget.autofocus,
        child: MouseRegion(
          cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
          onEnter: enabled ? (_) => _handleHoverEntered() : null,
          onExit: (_) => _handleHoverExited(),
          onHover: enabled
              ? (event) {
                  if (event.kind == PointerDeviceKind.mouse) {
                    _handleHover();
                  }
                }
              : null,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: enabled ? _handleTapDown : null,
            onTapUp: enabled ? _handleTapUp : null,
            onTapCancel: _handleTapCancel,
            onTap: enabled ? _handleTap : null,
            child: result,
          ),
        ),
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
      child: result,
    );
  }
}

/// A context with states for a [Button].
class ButtonScope extends InheritedWidget {
  /// Creates a [ButtonScope].
  const ButtonScope({
    Key? key,
    required Widget child,
    required this.hovered,
    required this.pressed,
    required this.active,
    required this.disabled,
    required this.color,
  }) : super(key: key, child: child);

  final bool hovered;

  final bool pressed;

  final bool active;

  final bool disabled;

  final Color color;

  @override
  bool updateShouldNotify(ButtonScope oldWidget) => true;

  static ButtonScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ButtonScope>();
  }
}
