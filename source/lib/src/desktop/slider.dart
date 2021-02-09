import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';
import 'theme_color.dart';
import 'theme_text.dart';

class Slider extends StatefulWidget {
  const Slider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.activeColor,
    this.thumbColor,
  })  : assert(value >= min && value <= max),
        super(key: key);

  final double value;

  final ValueChanged<double> onChanged;

  final ValueChanged<double>? onChangeStart;

  final ValueChanged<double>? onChangeEnd;

  final double min;

  final double max;

  final HSLColor? activeColor;

  final HSLColor? thumbColor;

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> with TickerProviderStateMixin {
  void _handleChanged(double value) {
    final double? lerpValue = lerpDouble(widget.min, widget.max, value);
    if (lerpValue != widget.value) {
      widget.onChanged(lerpValue!);
    }
  }

  void _handleDragStart(double value) {
    widget.onChangeStart!(lerpDouble(widget.min, widget.max, value)!);
  }

  void _handleDragEnd(double value) {
    widget.onChangeEnd!(lerpDouble(widget.min, widget.max, value)!);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    
    final HSLColor activeColor = widget.activeColor ?? colorScheme.primary2;
    final HSLColor thumbColor = colorScheme.primary2;

    Widget result = _SliderRenderObjectWidget(
      value: (widget.value - widget.min) / (widget.max - widget.min),
      activeColor: activeColor.toColor(),
      thumbColor: thumbColor.toColor(),
      onChanged: _handleChanged,
      onChangeStart: _handleDragStart,
      onChangeEnd: _handleDragEnd,
      vsync: this,
    );

    // return Tooltip(
    //   message: (widget.value * 100).round().toString(),
    //   child: result,
    //   preferBelow: false,
    // );

    return result;
  }
}

class _SliderRenderObjectWidget extends LeafRenderObjectWidget {
  const _SliderRenderObjectWidget({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.vsync,
    required this.activeColor,
    required this.thumbColor,
    this.onChangeStart,
    this.onChangeEnd,
  }) : super(key: key);

  final double value;
  final Color activeColor;
  final Color thumbColor;
  final ValueChanged<double> onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final TickerProvider vsync;

  @override
  _RenderSlider createRenderObject(BuildContext context) {
    return _RenderSlider(
      value: value,
      activeColor: activeColor,
      thumbColor: thumbColor,
      trackColor: Theme.of(context).colorScheme.overlay6.toColor(),
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      textDirection: Directionality.of(context),
      vsync: vsync,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSlider renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..thumbColor = thumbColor
      ..trackColor = Theme.of(context).colorScheme.overlay6.toColor()
      ..onChanged = onChanged
      ..onChangeStart = onChangeStart
      ..onChangeEnd = onChangeEnd
      ..textDirection = Directionality.of(context);
  }
}

const double _kThumbRadius = 6.0;
const double _kSliderWidth = 180.0;
const double _kSliderHeight = 2.0 * _kThumbRadius;
const Duration _kDiscreteTransitionDuration = Duration(milliseconds: 500);
//const double _kThumbWidth = 24.0;
//const Radius _kThumbRadius = const Radius.circular(8.0);

class _RenderSlider extends RenderConstrainedBox {
  _RenderSlider({
    required double value,
    required Color activeColor,
    required Color thumbColor,
    required Color trackColor,
    required ValueChanged<double> onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    required TickerProvider vsync,
    required TextDirection textDirection,
  })  : assert(value >= 0.0 && value <= 1.0),
        _value = value,
        _activeColor = activeColor,
        _thumbColor = thumbColor,
        _trackColor = trackColor,
        _onChanged = onChanged,
        _textDirection = textDirection,
        super(
            additionalConstraints: const BoxConstraints.tightFor(
                width: _kSliderWidth, height: _kSliderHeight)) {
    final GestureArenaTeam team = GestureArenaTeam();

    _drag = HorizontalDragGestureRecognizer()
      ..team = team
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onCancel = _endInteraction
      ..onEnd = _handleDragEnd;

    _tap = TapGestureRecognizer()
      ..team = team
      ..onTapDown = _handleTapDown
      ..onTapUp = _handleTapUp
      ..onTapCancel = _endInteraction;

    _position = AnimationController(
      value: value,
      duration: _kDiscreteTransitionDuration,
      vsync: vsync,
    )..addListener(markNeedsPaint);
  }

  late AnimationController _position;

  late TapGestureRecognizer _tap;
  late HorizontalDragGestureRecognizer _drag;
  double _currentDragValue = 0.0;
  bool _active = false;

  bool get isDiscrete => false;

  double _value;
  double get value => _value;
  set value(double newValue) {
    assert(newValue >= 0.0 && newValue <= 1.0);
    if (newValue == _value) return;
    _value = newValue;
    _position.value = newValue;
    markNeedsSemanticsUpdate();
  }

  Color _activeColor;
  Color get activeColor => _activeColor;
  set activeColor(Color value) {
    if (value == _activeColor) return;
    _activeColor = value;
    markNeedsPaint();
  }

  Color _thumbColor;
  Color get thumbColor => _thumbColor;
  set thumbColor(Color value) {
    if (value == _thumbColor) return;
    _thumbColor = value;
    markNeedsPaint();
  }

  Color _trackColor;
  Color get trackColor => _trackColor;
  set trackColor(Color value) {
    if (value == _trackColor) return;
    _trackColor = value;
    markNeedsPaint();
  }

  ValueChanged<double> _onChanged;
  ValueChanged<double> get onChanged => _onChanged;
  set onChanged(ValueChanged<double> value) {
    if (value == _onChanged) return;
    final bool wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) markNeedsSemanticsUpdate();
  }

  bool get isInteractive => onChanged != null;

  ValueChanged<double>? onChangeStart;
  ValueChanged<double>? onChangeEnd;

  TextDirection _textDirection;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsPaint();
  }

  double get _discretizedCurrentDragValue {
    double dragValue = _currentDragValue.clamp(0.0, 1.0);
    return dragValue;
  }

  double get _trackExtent => math.max(0.0, size.width - 2.0 * _kThumbRadius);

  double get _trackLeft => 0.0;
  double get _trackRight => size.width;
  double get _thumbCenter {
    double visualPosition;
    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - _value;
        break;
      case TextDirection.ltr:
        visualPosition = _value;
        break;
    }

    return lerpDouble(_trackLeft + _kThumbRadius, _trackRight - _kThumbRadius,
        visualPosition)!;
  }

  Paint get _thumbPaintColor { 
     final paint = Paint()..color = _active ? _thumbColor : _activeColor;
     return paint;
    }

  void _handleDragStart(DragStartDetails details) =>
      _startInteraction(details.globalPosition);

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      final double valueDelta = details.primaryDelta! / _trackExtent;

      switch (textDirection) {
        case TextDirection.rtl:
          _currentDragValue -= valueDelta;
          break;
        case TextDirection.ltr:
          _currentDragValue += valueDelta;
          break;
      }

      onChanged(_discretizedCurrentDragValue);
    }
  }

  void _handleDragEnd(DragEndDetails details) => _endInteraction();

  double _getValueFromVisualPosition(double visualPosition) {
    switch (textDirection) {
      case TextDirection.rtl:
        return 1.0 - visualPosition;
      case TextDirection.ltr:
        return visualPosition;
    }
  }

  double _getValueFromGlobalPosition(Offset globalPosition) {
    final double visualPosition =
        (globalToLocal(globalPosition).dx - (_trackLeft + _kThumbRadius)) /
            _trackExtent;
    return _getValueFromVisualPosition(visualPosition);
  }

  void _startInteraction(Offset globalPosition) {
    if (isInteractive) {
      _active = true;
      if (onChangeStart != null) {
        onChangeStart!(_discretizedCurrentDragValue); // FIXME 
      }
      _currentDragValue = _getValueFromGlobalPosition(globalPosition);
      onChanged(_discretizedCurrentDragValue);
    }
  }

  void _endInteraction() {
    if (onChangeEnd != null) {
      onChangeEnd!(_discretizedCurrentDragValue);  // FIXME 
    }

    _active = false;

    _currentDragValue = 0.0;

    markNeedsPaint();
  }

  void _handleTapDown(TapDownDetails details) {
    _startInteraction(details.globalPosition);
  }

  void _handleTapUp(TapUpDetails details) => _endInteraction();

  @override
  bool hitTestSelf(Offset offset) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && isInteractive) {
      _drag.addPointer(event);
      _tap.addPointer(event);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double visualPosition;
    Color leftColor;
    Color rightColor;

    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - _position.value;
        leftColor = _activeColor;
        rightColor = trackColor;
        break;
      case TextDirection.ltr:
        visualPosition = _position.value;
        leftColor = trackColor;
        rightColor = _activeColor;
        break;
    }

    final Canvas canvas = context.canvas;

    final double trackCenter = offset.dy + size.height / 2.0;
    final double trackLeft = offset.dx + _trackLeft;
    final double trackRight = offset.dx + _trackRight;
    final double trackTop = trackCenter - 1.0;
    final double trackBottom = trackCenter + 1.0;
    final double trackActive = offset.dx + _thumbCenter;

    if (visualPosition > 0.0) {
      final Paint paint = Paint()..color = rightColor;
      canvas.drawRect(
          Rect.fromLTRB(trackLeft, trackTop, trackActive, trackBottom), paint);
    }

    if (visualPosition < 1.0) {
      final Paint paint = Paint()..color = leftColor;
      canvas.drawRect(
          Rect.fromLTRB(trackActive, trackTop, trackRight, trackBottom), paint);
    }

    final Paint tPaint = _thumbPaintColor;
    canvas.drawCircle(Offset(trackActive, trackCenter), _kThumbRadius, tPaint);
  }
}
