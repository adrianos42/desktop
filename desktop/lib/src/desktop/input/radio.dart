import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

import '../theme/theme.dart';

const Duration _kToggleDuration = Duration(milliseconds: 120);
const Duration _kHoverDuration = Duration(milliseconds: 100);
const double _kStrokeWidth = 2.0;
const double _kOuterRadius = 7.0;
const double _kInnerRadius = 4.0;

// thicc radio button, maybe add option for mobile usage
// outerRadius = 8.0;
// innerRadius = outerRadius - (strokeWidth * 2.0);

class Radio extends StatefulWidget {
  const Radio({
    Key? key,
    required this.value,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  final bool value;

  final ValueChanged<bool>? onChanged;

  final FocusNode? focusNode;

  final bool autofocus;

  @override
  _RadioState createState() => _RadioState();
}

class _RadioState extends State<Radio> with TickerProviderStateMixin {
  bool get enabled => widget.onChanged != null;
  late Map<Type, Action<Intent>> _actionMap;

  late CurvedAnimation _position;
  late CurvedAnimation _hoverPosition;
  late AnimationController _positionController;
  late AnimationController _hoverPositionController;

  late TapGestureRecognizer _tap;

  @override
  void initState() {
    super.initState();
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction(onInvoke: _actionHandler),
    };

    _tap = TapGestureRecognizer()..onTap = _handleTap;

    _hoverPositionController = AnimationController(
      duration: _kHoverDuration,
      value: 0.0,
      vsync: this,
    );

    _hoverPosition = CurvedAnimation(
      parent: _hoverPositionController,
      curve: Curves.linear,
    );

    _positionController = AnimationController(
      duration: _kToggleDuration,
      value: widget.value == false ? 0.0 : 1.0,
      vsync: this,
    );

    _position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _tap.dispose();

    _positionController.dispose();
    _hoverPositionController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Radio oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _positionController.forward();
      } else {
        _positionController.reverse();
      }
    }
  }

  bool get isInteractive => widget.onChanged != null;

  void _actionHandler(Intent intent) {
    if (isInteractive) {
      widget.onChanged!(!widget.value);
    }

    final RenderObject renderObject = context.findRenderObject()!;
    renderObject.sendSemanticsEvent(const TapSemanticEvent());
  }

  bool _hovering = false;
  void _handleHoverChanged(bool hovering) {
    if (hovering != _hovering) {
      if (hovering || _focused) {
        _hoverPositionController.forward();
      } else {
        _hoverPositionController.reverse();
      }
      setState(() => _hovering = hovering);
    }
  }

  bool _focused = false;
  void _handleFocusHighlightChanged(bool focused) {
    if (focused != _focused) {
      if (focused || _hovering) {
        _hoverPositionController.forward();
      } else {
        _hoverPositionController.reverse();
      }
      setState(() => _focused = focused);
    }
  }

  void _handleTap() {
    if (isInteractive) {
      widget.onChanged!(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = RadioButtonTheme.of(context);

    final activeColor = theme.activeColor!;
    final hoverColor =
        widget.value ? theme.activeHoverColor! : theme.inactiveHoverColor!;
    final inactiveColor = theme.inactiveColor!;
    final foregroundColor = theme.foreground!;
    // TODO(as): final focusColor = theme.activeHoverColor!;
    final disabledColor = theme.disabledColor!;

    const Size size = Size.square(_kOuterRadius * 2.0);

    final BoxConstraints additionalConstraints = BoxConstraints.tight(size);

    return FocusableActionDetector(
      actions: _actionMap,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: enabled,
      onShowHoverHighlight: _handleHoverChanged,
      onShowFocusHighlight: _handleFocusHighlightChanged,
      mouseCursor: !widget.value && enabled
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: Builder(
        builder: (BuildContext context) {
          return _RadioRenderObjectWidget(
            value: widget.value,
            state: this,
            activeColor: activeColor,
            hoverColor: hoverColor,
            hovering: _hovering || _focused,
            inactiveColor: inactiveColor,
            disabledColor: disabledColor,
            onChanged: enabled ? (value) => widget.onChanged!(value!) : null,
            foregroundColor: foregroundColor,
            additionalConstraints: additionalConstraints,
          );
        },
      ),
    );
  }
}

class _RadioRenderObjectWidget extends LeafRenderObjectWidget {
  const _RadioRenderObjectWidget({
    Key? key,
    this.onChanged,
    required this.value,
    required this.state,
    required this.activeColor,
    required this.foregroundColor,
    required this.inactiveColor,
    required this.disabledColor,
    required this.hoverColor,
    required this.hovering,
    required this.additionalConstraints,
  }) : super(key: key);

  final bool value;
  final _RadioState state;
  final Color activeColor;
  final Color foregroundColor;
  final Color inactiveColor;
  final Color disabledColor;
  final ValueChanged<bool?>? onChanged;
  final Color hoverColor;
  final bool hovering;
  final BoxConstraints additionalConstraints;

  @override
  _RenderRadio createRenderObject(BuildContext context) => _RenderRadio(
        value: value,
        state: state,
        activeColor: activeColor,
        foregroundColor: foregroundColor,
        inactiveColor: inactiveColor,
        disabledColor: disabledColor,
        onChanged: onChanged,
        hoverColor: hoverColor,
        hovering: hovering,
        additionalConstraints: additionalConstraints,
      );

  @override
  void updateRenderObject(BuildContext context, _RenderRadio renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..foregroundColor = foregroundColor
      ..inactiveColor = inactiveColor
      ..disabledColor = disabledColor
      ..onChanged = onChanged
      ..hoverColor = hoverColor
      ..hovering = hovering
      ..additionalConstraints = additionalConstraints;
  }
}

class _RenderRadio extends RenderConstrainedBox {
  _RenderRadio({
    required bool value,
    required _RadioState state,
    required Color activeColor,
    required Color foregroundColor,
    required Color inactiveColor,
    required Color disabledColor,
    required Color hoverColor,
    required bool hovering,
    required BoxConstraints additionalConstraints,
    ValueChanged<bool>? onChanged,
  })  : _state = state,
        _value = value,
        _activeColor = activeColor,
        _disabledColor = disabledColor,
        _foregroundColor = foregroundColor,
        _inactiveColor = inactiveColor,
        _hoverColor = hoverColor,
        _hovering = hovering,
        _onChanged = onChanged,
        super(additionalConstraints: additionalConstraints);

  final _RadioState _state;

  bool get value => _value;
  bool _value;
  set value(bool value) {
    if (value == _value) {
      return;
    }
    _value = value;
    markNeedsSemanticsUpdate();
  }

  Color get activeColor => _activeColor;
  Color _activeColor;
  set activeColor(Color value) {
    if (value == _activeColor) {
      return;
    }
    _activeColor = value;
    markNeedsPaint();
  }

  Color get foregroundColor => _foregroundColor;
  Color _foregroundColor;
  set foregroundColor(Color value) {
    if (value == _foregroundColor) {
      return;
    }
    _foregroundColor = value;
    markNeedsPaint();
  }

  Color get inactiveColor => _inactiveColor;
  Color _inactiveColor;
  set inactiveColor(Color value) {
    if (value == _inactiveColor) {
      return;
    }
    _inactiveColor = value;
    markNeedsPaint();
  }

  Color get disabledColor => _disabledColor;
  Color _disabledColor;
  set disabledColor(Color value) {
    if (value == _disabledColor) {
      return;
    }
    _disabledColor = value;
    markNeedsPaint();
  }

  Color get hoverColor => _hoverColor;
  Color _hoverColor;
  set hoverColor(Color value) {
    if (value == _hoverColor) {
      return;
    }
    _hoverColor = value;
    markNeedsPaint();
  }

  // Color get focusColor => _focusColor;
  // Color _focusColor;
  // set focusColor(Color value) {
  //   if (value == _focusColor) {
  //     return;
  //   }
  //   _focusColor = value;
  //   markNeedsPaint();
  // }

  bool get hovering => _hovering;
  bool _hovering;
  set hovering(bool value) {
    if (value == _hovering) {
      return;
    }
    _hovering = value;
    markNeedsPaint();
  }

  ValueChanged<bool>? get onChanged => _onChanged;
  ValueChanged<bool>? _onChanged;
  set onChanged(ValueChanged<bool>? value) {
    if (value == _onChanged) {
      return;
    }
    final bool wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) {
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  bool get isInteractive => onChanged != null;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _state._hoverPositionController.addListener(markNeedsPaint);
    _state._positionController.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _state._hoverPositionController.removeListener(markNeedsPaint);
    _state._positionController.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && isInteractive) {
      _state._tap.addPointer(event);
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    if (isInteractive) {
      config.onTap = _state._handleTap;
    }

    config.isChecked = value == true;
    config.isEnabled = isInteractive;
  }

  Color _colorAt(double t) {
    if (!isInteractive) {
      return disabledColor;
    }

    final color = Color.lerp(inactiveColor, activeColor, t)!;

    if (hovering || _state._hoverPositionController.isAnimating) {
      return Color.lerp(color, hoverColor, _state._hoverPosition.value)!;
    }

    return color;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    final Offset center = (offset & size).center;

    final Paint borderPaint = Paint()
      ..color = _colorAt(_state._position.value)
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kStrokeWidth;

    final Paint strokePaint = Paint()
      ..color = onChanged == null ? disabledColor : foregroundColor;

    canvas.drawCircle(center, _kOuterRadius, borderPaint);

    if (!_state._position.isDismissed) {
      canvas.drawCircle(center, _kInnerRadius, strokePaint);
    }
  }
}
