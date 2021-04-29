import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

import 'dart:math' as math;

import '../theme/theme.dart';

import 'internal/toggleable.dart';

const double _kCheckboxWidth = 16.0;
const double _kEdgeSize = _kCheckboxWidth;
const double _kStrokeWidth = 2.0;

class Checkbox extends StatefulWidget {
  const Checkbox({
    Key? key,
    this.value,
    this.tristate = false,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
  })  : assert(tristate || value != null),
        super(key: key);

  final bool? value;

  final ValueChanged<bool?>? onChanged;

  final bool tristate;

  final FocusNode? focusNode;

  final bool autofocus;

  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> with TickerProviderStateMixin {
  bool get enabled => widget.onChanged != null;
  late Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _actionHandler),
    };
  }

  void _actionHandler(ActivateIntent intent) {
    if (widget.onChanged != null) {
      switch (widget.value) {
        case false:
          widget.onChanged!(true);
          break;
        case true:
          widget.onChanged!(widget.tristate ? null : false);
          break;
        default: // case null:
          widget.onChanged!(false);
          break;
      }
    }

    final RenderObject renderObject = context.findRenderObject()!;
    renderObject.sendSemanticsEvent(const TapSemanticEvent());
  }

  bool _hovering = false;
  void _handleHoverChanged(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }

  bool _focused = false;
  void _handleFocusHighlightChanged(bool focused) {
    if (focused != _focused) {
      setState(() {
        _focused = focused;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = CheckboxTheme.of(context);

    final activeColor =
        _hovering || _focused ? theme.activeHoverColor! : theme.activeColor!;
    final inactiveColor = _hovering || _focused
        ? theme.inactiveHoverColor!
        : theme.inactiveColor!;
    final foregroundColor = theme.foreground!;
    final focusColor = theme.activeHoverColor!; // TODO(as): ???
    final disabledColor = theme.disabledColor!; // TODO(as): ???

    const Size size = Size.square(_kCheckboxWidth + 2);
    final BoxConstraints additionalConstraints = BoxConstraints.tight(size);

    return FocusableActionDetector(
      actions: _actionMap,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: enabled,
      onShowHoverHighlight: _handleHoverChanged,
      onShowFocusHighlight: _handleFocusHighlightChanged,
      child: Builder(
        builder: (BuildContext context) {
          return _CheckboxRenderObjectWidget(
            value: widget.value,
            tristate: widget.tristate,
            activeColor: activeColor.toColor(),
            inactiveColor: inactiveColor.toColor(),
            onChanged: widget.onChanged,
            foregroundColor: foregroundColor.toColor(),
            focusColor: focusColor.toColor(),
            disabledColor: disabledColor.toColor(),
            vsync: this,
            hasFocus: false,
            additionalConstraints: additionalConstraints,
          );
        },
      ),
    );
  }
}

class _CheckboxRenderObjectWidget extends LeafRenderObjectWidget {
  const _CheckboxRenderObjectWidget({
    Key? key,
    this.onChanged,
    required this.value,
    required this.tristate,
    required this.activeColor,
    required this.foregroundColor,
    required this.inactiveColor,
    required this.focusColor,
    required this.vsync,
    required this.hasFocus,
    required this.disabledColor,
    required this.additionalConstraints,
  })   : assert(tristate || value != null),
        super(key: key);

  final bool? value;
  final bool tristate;
  final bool hasFocus;
  final Color activeColor;
  final Color focusColor;
  final Color foregroundColor;
  final Color inactiveColor;
  final ValueChanged<bool?>? onChanged;
  final TickerProvider vsync;
  final Color disabledColor;
  final BoxConstraints additionalConstraints;

  @override
  _RenderCheckbox createRenderObject(BuildContext context) => _RenderCheckbox(
        value: value,
        tristate: tristate,
        hasFocus: hasFocus,
        activeColor: activeColor,
        foregroundColor: foregroundColor,
        inactiveColor: inactiveColor,
        focusColor: focusColor,
        onChanged: onChanged,
        disabledColor: disabledColor,
        vsync: vsync,
        additionalConstraints: additionalConstraints,
      );

  @override
  void updateRenderObject(BuildContext context, _RenderCheckbox renderObject) {
    renderObject
      ..value = value
      ..tristate = tristate
      ..activeColor = activeColor
      ..foregroundColor = foregroundColor
      ..inactiveColor = inactiveColor
      ..hasFocus = hasFocus
      ..focusColor = focusColor
      ..disabledColor = disabledColor
      ..onChanged = onChanged
      ..additionalConstraints = additionalConstraints
      ..vsync = vsync;
  }
}

class _RenderCheckbox extends RenderToggleable {
  _RenderCheckbox({
    bool? value,
    required bool tristate,
    required Color activeColor,
    required this.foregroundColor,
    required Color inactiveColor,
    required Color focusColor,
    required Color disabledColor,
    ValueChanged<bool?>? onChanged,
    required bool hasFocus,
    required TickerProvider vsync,
    required BoxConstraints additionalConstraints,
  })   : _oldValue = value,
        super(
          value: value,
          tristate: tristate,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          focusColor: focusColor,
          onChanged: onChanged,
          hasFocus: hasFocus,
          disabledColor: disabledColor,
          vsync: vsync,
          additionalConstraints: additionalConstraints,
        );

  bool? _oldValue;
  Color foregroundColor;

  @override
  set value(bool? newValue) {
    if (newValue == value) return;
    _oldValue = value;
    super.value = newValue;
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isChecked = value == true;
  }

  RRect _outerRectAt(Offset origin) {
    const double size = _kEdgeSize;
    final Rect rect = Rect.fromLTWH(origin.dx, origin.dy, size, size);
    return RRect.fromRectAndRadius(rect, Radius.zero);
  }

  Color _colorAt(double t) {
    return onChanged == null
        ? disabledColor
        : (t >= 0.25
            ? activeColor
            : Color.lerp(inactiveColor, activeColor, t * 4.0))!;
  }

  Paint _createStrokePaint() {
    return Paint()
      ..color = foregroundColor
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
    assert(t >= 0.0 && t <= 1.0);
    // As t goes from 0.0 to 1.0, animate the horizontal line from the
    // mid point outwards.
    const Offset start = Offset(_kEdgeSize * 0.2, _kEdgeSize * 0.5);
    const Offset mid = Offset(_kEdgeSize * 0.5, _kEdgeSize * 0.5);
    const Offset end = Offset(_kEdgeSize * 0.8, _kEdgeSize * 0.5);
    final Offset drawStart = Offset.lerp(start, mid, 1.0 - t)!;
    final Offset drawEnd = Offset.lerp(mid, end, t)!;
    canvas.drawLine(origin + drawStart, origin + drawEnd, paint);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    final Paint strokePaint = _createStrokePaint();

    final Offset origin = (offset & size).topLeft;

    final AnimationStatus status = position.status;
    final double tNormalized =
        status == AnimationStatus.forward || status == AnimationStatus.completed
            ? position.value
            : 1.0 - position.value;

    // Four cases: false to null, false to true, null to false, true to false
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
