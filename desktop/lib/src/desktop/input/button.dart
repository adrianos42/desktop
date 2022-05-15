import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../component.dart';
import '../dialogs/tooltip.dart';
import '../theme/theme.dart';

const Duration _kDefaultButtonDuration = Duration(milliseconds: 100);

/// The base button which is used to create other kinds of buttons.
class Button extends StatefulWidget {
  /// Creates a [Button].
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
    this.active,
    this.axis = Axis.horizontal,
    this.focusNode,
    this.canRequestFocus = true,
    this.autofocus = false,
  })  : assert(body != null || trailing != null || leading != null),
        super(key: key);

  /// Creates a button with a text.
  factory Button.text(
    String text, {
    double? fontSize,
    String? tooltip,
    Color? color,
    Color? highlightColor,
    Color? hoverColor,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Key? key,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autofocus = false,
    bool? active,
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
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      autofocus: autofocus,
      active: active,
    );
  }

  /// Creates a button with a icon.
  factory Button.icon(
    IconData icon, {
    String? tooltip,
    double? size,
    Color? color,
    Color? highlightColor,
    Color? hoverColor,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Key? key,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autofocus = false,
    bool? active,
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
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      autofocus: autofocus,
      active: active,
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
  final Color? color;

  /// The color of the button when the is hovering it.
  final Color? hoverColor;

  /// The color of the button when it's been pressed.
  final Color? highlightColor;

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

  /// Forces the button highlight.
  final bool? active;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.canRequestFocus}
  final bool canRequestFocus;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button>
    with ComponentStateMixin, SingleTickerProviderStateMixin {
  void _handleHoverEntered() {
    if (!hovered && (pressed || !_globalPointerDown)) {
      _colorUpdate.clear();
      setState(() => hovered = true);
      _updateColor();
    }
  }

  void _handleHoverExited() {
    if (hovered) {
      setState(() => hovered = false);
      _updateColor();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (pressed) {
      setState(() => pressed = false);
      if (widget.active == null) {
        _updateColor();
      }
    }
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) {
      setState(() => pressed = true);
      _colorUpdate.clear();
      _updateColor();
    }
  }

  void _handleTapCancel() {
    if (pressed) {
      setState(() => pressed = false);
      pressed = false;
      _updateColor();
    }
  }

  bool _globalPointerDown = false;

  void _mouseRoute(PointerEvent event) => _globalPointerDown = event.down;

  late AnimationController _controller;

  ColorTween? _color;
  final Queue<Color> _colorUpdate = Queue<Color>();

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
    switch (FocusManager.instance.highlightMode) {
      case FocusHighlightMode.touch:
        return false;
      case FocusHighlightMode.traditional:
        return _shouldShowFocus;
    }
  }

  void _invoke([Intent? intent]) => _handleTap();

  void _handleTap() => widget.onPressed?.call();

  void _handleFocusUpdate(bool hasFocus) {
    focused = hasFocus;
  }

  bool get active => waiting || (widget.active ?? false);

  bool get enabled => widget.onPressed != null;

  void _updateColor([bool animates = true]) {
    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);

    final Color pressedForeground =
        widget.highlightColor ?? buttonThemeData.highlightColor!;

    final Color enabledForeground = widget.color ?? buttonThemeData.color!;

    final Color hoveredForeground =
        widget.hoverColor ?? buttonThemeData.hoverColor!;

    final Color disabledForeground = buttonThemeData.disabledColor!;

    final Color foregroundColor = enabled
        ? active || pressed
            ? pressedForeground
            : hovered || _focusHighlight
                ? hoveredForeground
                : enabledForeground
        : disabledForeground;

    _colorUpdate.addLast(foregroundColor);

    if (animates) {
      if (!_controller.isAnimating) {
        if (_colorUpdate.length == 1) {
          final color = _colorUpdate.removeFirst();
          _color = ColorTween(begin: _color?.end ?? color, end: color);
          _controller.forward(from: 0.0);
        }
      }
    } else {
      final color = _colorUpdate.removeFirst();
      _colorUpdate.clear();
      _controller.value = 1.0;
      _color = ColorTween(begin: _color?.end ?? color, end: color);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _kDefaultButtonDuration,
      value: 1.0,
    )..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.dismissed:
            break;
          case AnimationStatus.forward:
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.completed:
            if (_colorUpdate.isNotEmpty) {
              final color = _colorUpdate.removeFirst();
              _color = ColorTween(begin: _color?.end ?? color, end: color);
              _controller.forward(from: 0.0);
            }
            break;
        }
      });

    WidgetsBinding.instance.pointerRouter.addGlobalRoute(_mouseRoute);
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.pointerRouter.removeGlobalRoute(_mouseRoute);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _colorUpdate.clear();
    _updateColor();
  }

  @override
  void didUpdateWidget(Button oldWidget) {
    super.didUpdateWidget(oldWidget);

    _colorUpdate.clear();
    _updateColor(false);
  }

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);

    final itemSpacing = buttonThemeData.itemSpacing!;

    if (_color == null) {
      _updateColor();

      final color = _colorUpdate.removeFirst();
      _color ??= ColorTween(begin: _color?.end ?? color, end: color);
    }

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

    result = ButtonScope(
      child: result,
      hovered: enabled && (hovered || _focusHighlight),
      pressed: enabled && pressed,
      active: enabled && active,
      disabled: !enabled,
    );

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
  }) : super(key: key, child: child);

  final bool hovered;

  final bool pressed;

  final bool active;

  final bool disabled;

  @override
  bool updateShouldNotify(ButtonScope oldWidget) => true;

  static ButtonScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ButtonScope>();
  }
}
