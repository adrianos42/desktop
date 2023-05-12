import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

const Duration _kToggleDuration = Duration(milliseconds: 120);
const Duration _kHoverDuration = Duration(milliseconds: 100);
const double _kStrokeWidth = 2.0;
const double _kOuterRadius = 7.0;
const double _kInnerRadius = 4.0;

const double _kContainerHeight = 32.0;
const double _kContainerWidth = 32.0;

///
class Radio extends StatefulWidget {
  ///
  const Radio({
    super.key,
    required this.value,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
    this.theme,
  });

  final bool value;

  final ValueChanged<bool>? onChanged;

  final FocusNode? focusNode;

  final bool autofocus;

  /// The style [RadioThemeData] of the radio.
  final RadioThemeData? theme;

  @override
  State<Radio> createState() => _RadioState();
}

class _RadioState extends State<Radio> with TickerProviderStateMixin {
  bool get enabled => widget.onChanged != null;
  late Map<Type, Action<Intent>> _actionMap;

  late CurvedAnimation _position;
  late CurvedAnimation _hoverPosition;
  late AnimationController _positionController;
  late AnimationController _hoverPositionController;

  @override
  void initState() {
    super.initState();
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction(onInvoke: _actionHandler),
    };

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
    final RadioThemeData theme = RadioTheme.of(context).merge(widget.theme);

    final Color activeColor = theme.activeColor!;
    final Color hoverColor =
        widget.value ? theme.activeHoverColor! : theme.inactiveHoverColor!;
    final Color inactiveColor = theme.inactiveColor!;
    final Color foregroundColor = theme.foreground!;
    // TODO(as): final focusColor = theme.activeHoverColor!;
    final Color disabledColor = theme.disabledColor!;

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
      child: GestureDetector(
        onTap: () => _handleTap(),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: _kContainerWidth,
          height: _kContainerHeight,
          child: Center(
            child: _RadioRenderObjectWidget(
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
            ),
          ),
        ),
      ),
    );
  }
}

class _RadioRenderObjectWidget extends LeafRenderObjectWidget {
  const _RadioRenderObjectWidget({
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
  });

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
  bool hitTestSelf(Offset position) => false;

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
