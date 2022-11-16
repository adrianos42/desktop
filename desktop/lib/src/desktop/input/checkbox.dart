import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

const Duration _kToggleDuration = Duration(milliseconds: 120);
const Duration _kHoverDuration = Duration(milliseconds: 100);
const double _kCheckboxWidth = 14.0;
const double _kEdgeSize = _kCheckboxWidth;
const double _kStrokeWidth = 2.0;

/// [Checkbox] input.
class Checkbox extends StatefulWidget {
  /// Creates a [Checkbox].
  const Checkbox({
    super.key,
    this.value,
    this.tristate = false,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
    this.themeData,
    this.forceEnabled = false,
  })  : assert(tristate || value != null),
        assert(!forceEnabled || onChanged == null,
            'Cannot have `onChanged` when `forceEnabled` is true');

  /// The value of the input.
  final bool? value;

  /// If the checkbox is enabled without `onChanged` value.
  final bool forceEnabled;

  /// Called when the value changes.
  final ValueChanged<bool?>? onChanged;

  /// If the checkbox has three states.
  final bool tristate;

  /// The [FocusNode] of the checkbox.
  final FocusNode? focusNode;

  /// See [FocusableActionDetector] field [autofocus].
  final bool autofocus;

  final CheckboxThemeData? themeData;

  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> with TickerProviderStateMixin {
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
      ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _actionHandler),
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
  void didUpdateWidget(Checkbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (oldWidget.value != widget.value) {
        switch (_positionController.status) {
          case AnimationStatus.forward:
          case AnimationStatus.completed:
            _positionController.reverse();
            break;
          default:
            _positionController.forward();
        }
      }
    }
  }

  bool get isInteractive => widget.onChanged != null;

  void _actionHandler(ActivateIntent intent) {
    if (isInteractive) {
      switch (widget.value) {
        case false:
          widget.onChanged!(true);
          break;
        case true:
          widget.onChanged!(widget.tristate ? null : false);
          break;
        default:
          widget.onChanged!(false);
          break;
      }
    }

    final RenderObject renderObject = context.findRenderObject()!;
    renderObject.sendSemanticsEvent(const TapSemanticEvent());
  }

  void _handleTap() {
    if (isInteractive) {
      switch (widget.value) {
        case false:
          widget.onChanged!(true);
          break;
        case true:
          widget.onChanged!(widget.tristate ? null : false);
          break;
        default:
          widget.onChanged!(false);
          break;
      }
    }
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

  @override
  Widget build(BuildContext context) {
    final theme = CheckboxTheme.of(context).merge(widget.themeData);

    final activeColor = theme.activeColor!;
    final hoverColor = widget.value != false
        ? theme.activeHoverColor!
        : theme.inactiveHoverColor!;
    final inactiveColor = theme.inactiveColor!;
    final foregroundColor = theme.foreground!;
    // TODO(as): final focusColor = theme.activeHoverColor!;
    final disabledColor = theme.disabledColor!;

    const Size size = Size.square(_kCheckboxWidth);
    final BoxConstraints additionalConstraints = BoxConstraints.tight(size);

    return FocusableActionDetector(
      actions: _actionMap,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: enabled,
      onShowHoverHighlight: _handleHoverChanged,
      onShowFocusHighlight: _handleFocusHighlightChanged,
      mouseCursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: () => _handleTap(),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: theme.containerSize,
          height: theme.containerSize,
          child: Center(
            child: _CheckboxRenderObjectWidget(
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
              forceEnabled: widget.forceEnabled,
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckboxRenderObjectWidget extends LeafRenderObjectWidget {
  const _CheckboxRenderObjectWidget({
    Key? key,
    this.onChanged,
    this.value,
    required this.state,
    required this.activeColor,
    required this.foregroundColor,
    required this.inactiveColor,
    required this.disabledColor,
    required this.hoverColor,
    required this.hovering,
    required this.additionalConstraints,
    required this.forceEnabled,
  }) : super(key: key);

  final bool? value;
  final _CheckboxState state;
  final Color activeColor;
  final Color foregroundColor;
  final Color inactiveColor;
  final Color disabledColor;
  final ValueChanged<bool?>? onChanged;
  final Color hoverColor;
  final bool hovering;
  final BoxConstraints additionalConstraints;
  final bool forceEnabled;

  @override
  _RenderCheckbox createRenderObject(BuildContext context) => _RenderCheckbox(
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
        forceEnabled: forceEnabled,
      );

  @override
  void updateRenderObject(BuildContext context, _RenderCheckbox renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..foregroundColor = foregroundColor
      ..inactiveColor = inactiveColor
      ..disabledColor = disabledColor
      ..onChanged = onChanged
      ..hoverColor = hoverColor
      ..hovering = hovering
      ..forceEnabled = forceEnabled
      ..additionalConstraints = additionalConstraints;
  }
}

class _RenderCheckbox extends RenderConstrainedBox {
  _RenderCheckbox({
    bool? value,
    ValueChanged<bool>? onChanged,
    required bool forceEnabled,
    required _CheckboxState state,
    required Color activeColor,
    required Color foregroundColor,
    required Color inactiveColor,
    required Color disabledColor,
    required Color hoverColor,
    required bool hovering,
    required BoxConstraints additionalConstraints,
  })  : _state = state,
        _value = value,
        _oldValue = value,
        _activeColor = activeColor,
        _disabledColor = disabledColor,
        _foregroundColor = foregroundColor,
        _inactiveColor = inactiveColor,
        _hoverColor = hoverColor,
        _hovering = hovering,
        _onChanged = onChanged,
        _forceEnabled = forceEnabled,
        super(additionalConstraints: additionalConstraints);

  final _CheckboxState _state;

  bool? get value => _value;
  bool? _value;
  bool? _oldValue;
  set value(bool? value) {
    if (value == _value) {
      return;
    }
    _oldValue = _value;
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

  bool _forceEnabled;
  set forceEnabled(bool value) {
    if (value != _forceEnabled) {
      _forceEnabled = value;
      markNeedsPaint();
    }
  }

  bool get isInteractive => onChanged != null;

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

  RRect _outerRectAt(Offset origin) {
    const double size = _kEdgeSize;
    final Rect rect = Rect.fromLTWH(origin.dx, origin.dy, size, size);
    return RRect.fromRectAndRadius(rect, Radius.zero);
  }

  Color _colorAt(double t) {
    if (!isInteractive && !_forceEnabled) {
      return disabledColor;
    }

    final color = Color.lerp(inactiveColor, activeColor, t)!;

    if (hovering || _state._hoverPositionController.isAnimating) {
      return Color.lerp(color, hoverColor, _state._hoverPosition.value)!;
    }

    return color;
  }

  Paint _createStrokePaint() {
    return Paint()
      ..color = _state._hovering ? Color(0xFF000000) : foregroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kStrokeWidth;
  }

  void _drawBorder(Canvas canvas, RRect outer, double t, Paint paint) {
    assert(t >= 0.0 && t <= 0.5);
    final double size = outer.width;
    final RRect inner =
        outer.deflate(math.min(size / 2.0, _kStrokeWidth + size * t));
    canvas.drawDRRect(outer, inner, paint);
  }

  void _drawCheck(Canvas canvas, Offset origin, double t, Paint paint) {
    assert(t >= 0.0 && t <= 1.0);
    // As t goes from 0.0 to 1.0, animate the two check mark strokes from the
    // short side to the long side.
    final Path path = Path();
    const Offset start = Offset(_kEdgeSize * 0.15, _kEdgeSize * 0.45);
    const Offset mid = Offset(_kEdgeSize * 0.4, _kEdgeSize * 0.7);
    const Offset end = Offset(_kEdgeSize * 0.85, _kEdgeSize * 0.25);

    if (t < 0.5) {
      final double strokeT = t * 2.0;
      final Offset drawMid = Offset.lerp(start, mid, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + drawMid.dx, origin.dy + drawMid.dy);
    } else {
      final double strokeT = (t - 0.5) * 2.0;
      final Offset drawEnd = Offset.lerp(mid, end, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
      path.lineTo(origin.dx + drawEnd.dx, origin.dy + drawEnd.dy);
    }

    canvas.drawPath(path, paint);
  }

  void _drawInside(Canvas canvas, Offset origin, double t, Paint paint) {
    const Offset start = Offset(_kEdgeSize * 0.2, _kEdgeSize * 0.5);
    const Offset mid = Offset(_kEdgeSize * 0.5, _kEdgeSize * 0.5);
    const Offset end = Offset(_kEdgeSize * 0.8, _kEdgeSize * 0.5);
    final Offset drawStart = Offset.lerp(start, mid, 1.0 - t)!;
    final Offset drawEnd = Offset.lerp(mid, end, t)!;
    canvas.drawLine(origin + drawStart, origin + drawEnd, paint);
  }

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
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    final Paint strokePaint = _createStrokePaint();

    final Offset origin = (offset & size).topLeft;

    final AnimationStatus status = _state._position.status;
    final double tNormalized =
        status == AnimationStatus.forward || status == AnimationStatus.completed
            ? _state._position.value
            : 1.0 - _state._position.value;

    if (_oldValue == false || value == false) {
      final double t = value == false ? 1.0 - tNormalized : tNormalized;

      final RRect outer = _outerRectAt(origin);

      final Paint paint = Paint()..color = _colorAt(t);

      if (t <= 0.5) {
        _drawBorder(canvas, outer, t, paint);
      } else {
        canvas.drawRRect(outer, paint);

        final double tShrink = (t - 0.5) * 2.0;
        if (_oldValue == null || value == null) {
          _drawInside(canvas, origin, tShrink, strokePaint);
        } else {
          _drawCheck(canvas, origin, tShrink, strokePaint);
        }
      }
    } else {
      // Two cases: null to true, true to null
      final RRect outer = _outerRectAt(origin);
      final Paint paint = Paint()..color = _colorAt(1.0);
      canvas.drawRRect(outer, paint);

      if (tNormalized <= 0.5) {
        final double tShrink = 1.0 - tNormalized * 2.0;
        if (_oldValue == true) {
          _drawCheck(canvas, origin, tShrink, strokePaint);
        } else {
          _drawInside(canvas, origin, tShrink, strokePaint);
        }
      } else {
        final double tExpand = (tNormalized - 0.5) * 2.0;
        if (value == true) {
          _drawCheck(canvas, origin, tExpand, strokePaint);
        } else {
          _drawInside(canvas, origin, tExpand, strokePaint);
        }
      }
    }
  }
}
