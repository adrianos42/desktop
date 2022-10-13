import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import '../dialogs/tooltip.dart';
import '../theme/theme.dart';

const double _kThumbRadius = 6.0;
const double _kSliderWidth = 180.0;
const double _kSliderHeight = 2.0 * _kThumbRadius;
const Duration _kDuration = Duration(milliseconds: 100);

class Slider extends StatefulWidget {
  const Slider({
    Key? key,
    required this.value,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.focusNode,
    this.autofocus = false,
    this.enableTooltip = false,
  })  : assert(value >= min && value <= max),
        super(key: key);

  final double value;

  final ValueChanged<double>? onChanged;

  final ValueChanged<double>? onChangeStart;

  final ValueChanged<double>? onChangeEnd;

  final double min;

  final double max;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool enableTooltip;

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> with TickerProviderStateMixin {
  late CurvedAnimation _position;
  late CurvedAnimation _hoverPosition;
  late AnimationController _positionController;
  late AnimationController _hoverPositionController;

  late TapGestureRecognizer _tap;
  late HorizontalDragGestureRecognizer _drag;

  @override
  void initState() {
    super.initState();

    final GestureArenaTeam team = GestureArenaTeam();

    _drag = HorizontalDragGestureRecognizer();
    _drag.team = team;

    _tap = TapGestureRecognizer();
    _tap.team = team;

    _hoverPositionController = AnimationController(
      duration: _kDuration,
      value: 0.0,
      vsync: this,
    );

    _hoverPosition = CurvedAnimation(
      parent: _hoverPositionController,
      curve: Curves.linear,
    );

    _positionController = AnimationController(
      duration: _kDuration,
      value: 0.0,
      vsync: this,
    );

    _position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _drag.dispose();
    _tap.dispose();
    _positionController.dispose();
    _hoverPositionController.dispose();
    super.dispose();
  }

  void _handleChanged(double value) {
    final double? lerpValue = lerpDouble(widget.min, widget.max, value);
    if (lerpValue != widget.value) {
      widget.onChanged!(lerpValue!);
    }
  }

  bool _dragging = false;
  void _handleDragChanged(bool dragging) {
    if (dragging != _dragging) {
      if (dragging) {
        _positionController.forward();
      } else {
        _positionController.reverse();
      }
      setState(() => _dragging = dragging);
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
    final active = widget.onChanged != null;
    final theme = SliderTheme.of(context);

    final Color activeColor = theme.activeColor!;
    final hoverColor = theme.activeHoverColor!;
    final disabledColor = theme.disabledColor!;

    final Color trackColor = theme.trackColor!;
    final Color hightlightColor = theme.hightlightColor!;

    final Widget result = FocusableActionDetector(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: active,
      onShowHoverHighlight: _handleHoverChanged,
      onShowFocusHighlight: _handleFocusHighlightChanged,
      mouseCursor: active ? SystemMouseCursors.click : MouseCursor.defer,
      child: Builder(
        builder: (BuildContext context) {
          return _SliderRenderObjectWidget(
            state: this,
            value: (widget.value - widget.min) / (widget.max - widget.min),
            activeColor: activeColor,
            hightlightColor: hightlightColor,
            trackColor: trackColor,
            disabledColor: disabledColor,
            hoverColor: hoverColor,
            hovering: _hovering || _focused,
            onChanged: active ? _handleChanged : null,
            onChangeStart: (value) {
              if (active) {
                _handleDragChanged(true);
                widget.onChangeStart?.call(
                  lerpDouble(
                    widget.min,
                    widget.max,
                    value,
                  )!,
                );
              }
            },
            onChangeEnd: (value) {
              if (active) {
                _handleDragChanged(false);
                widget.onChangeEnd?.call(lerpDouble(
                  widget.min,
                  widget.max,
                  value,
                )!);
              }
            },
          );
        },
      ),
    );

    if (widget.enableTooltip) {
      return Tooltip(
        message: (widget.value * 100).round().toString(),
        child: result,
        height: 14.0,
        preferBelow: false,
      );
    } else {
      return result;
    }
  }
}

class _SliderRenderObjectWidget extends LeafRenderObjectWidget {
  const _SliderRenderObjectWidget({
    Key? key,
    required this.value,
    required this.state,
    required this.activeColor,
    required this.trackColor,
    required this.disabledColor,
    required this.hoverColor,
    required this.hovering,
    required this.hightlightColor,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
  }) : super(key: key);

  final double value;
  final Color activeColor;
  final Color trackColor;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final Color disabledColor;
  final Color hoverColor;
  final Color hightlightColor;
  final bool hovering;
  final _SliderState state;

  @override
  _RenderSlider createRenderObject(BuildContext context) {
    return _RenderSlider(
      value: value,
      state: state,
      activeColor: activeColor,
      trackColor: trackColor,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      disabledColor: disabledColor,
      hoverColor: hoverColor,
      hovering: hovering,
      hightlightColor: hightlightColor,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSlider renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..trackColor = trackColor
      ..onChanged = onChanged
      ..onChangeStart = onChangeStart
      ..onChangeEnd = onChangeEnd
      ..disabledColor = disabledColor
      ..hoverColor = hoverColor
      ..hovering = hovering
      ..hightlightColor = hightlightColor
      ..textDirection = Directionality.of(context);
  }
}

class _RenderSlider extends RenderConstrainedBox {
  _RenderSlider({
    this.onChangeStart,
    this.onChangeEnd,
    ValueChanged<double>? onChanged,
    required _SliderState state,
    required double value,
    required Color activeColor,
    required Color disabledColor,
    required Color hoverColor,
    required bool hovering,
    required Color trackColor,
    required Color hightlightColor,
    required TextDirection textDirection,
  })  : assert(value >= 0.0 && value <= 1.0),
        _disabledColor = disabledColor,
        _hoverColor = hoverColor,
        _hovering = hovering,
        _state = state,
        _value = value,
        _activeColor = activeColor,
        _trackColor = trackColor,
        _onChanged = onChanged,
        _textDirection = textDirection,
        _hightlightColor = hightlightColor,
        super(
            additionalConstraints: const BoxConstraints.tightFor(
                width: _kSliderWidth, height: _kSliderHeight)) {
    state._drag.onStart = _handleDragStart;
    state._drag.onUpdate = _handleDragUpdate;
    state._drag.onCancel = _endInteraction;
    state._drag.onEnd = _handleDragEnd;

    state._tap.onTapDown = _handleTapDown;
    state._tap.onTapUp = _handleTapUp;
    state._tap.onTapCancel = _endInteraction;
  }

  final _SliderState _state;

  double? _currentDragValue;
  double _currentStartDragValue = 0.0;

  bool _dragging = false;

  bool get isDiscrete => false;

  double _value;
  double get value => _value;
  set value(double value) {
    assert(value >= 0.0 && value <= 1.0);
    if (value == _value) {
      return;
    }
    _value = value;

    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  Color _activeColor;
  Color get activeColor => _activeColor;
  set activeColor(Color value) {
    if (value == _activeColor) {
      return;
    }
    _activeColor = value;
    markNeedsPaint();
  }

  Color _hightlightColor;
  Color get hightlightColor => _hightlightColor;
  set hightlightColor(Color value) {
    if (value == _hightlightColor) {
      return;
    }
    _hightlightColor = value;
    markNeedsPaint();
  }

  Color _trackColor;
  Color get trackColor => _trackColor;
  set trackColor(Color value) {
    if (value == _trackColor) {
      return;
    }
    _trackColor = value;
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

  ValueChanged<double>? _onChanged;
  ValueChanged<double>? get onChanged => _onChanged;
  set onChanged(ValueChanged<double>? value) {
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

  ValueChanged<double>? onChangeStart;
  ValueChanged<double>? onChangeEnd;

  TextDirection _textDirection;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsPaint();
  }

  double get _discretizedCurrentDragValue {
    final double dragValue =
        clampDouble(_currentDragValue ?? _currentStartDragValue, 0.0, 1.0);
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

  void _handleDragStart(DragStartDetails details) {
    _startInteraction(details.globalPosition);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      _currentDragValue ??= _currentStartDragValue;

      final double valueDelta = details.primaryDelta! / _trackExtent;

      switch (textDirection) {
        case TextDirection.rtl:
          _currentDragValue = _currentDragValue! - valueDelta;
          break;
        case TextDirection.ltr:
          _currentDragValue = _currentDragValue! + valueDelta;
          break;
      }

      onChanged!(_discretizedCurrentDragValue);
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
      _dragging = true;

      _currentStartDragValue = _getValueFromGlobalPosition(globalPosition);

      onChangeStart?.call(_discretizedCurrentDragValue);
    }
  }

  void _endInteraction() {
    onChangeEnd?.call(_discretizedCurrentDragValue);

    _dragging = false;

    _currentDragValue = null;
    _currentStartDragValue = 0.0;

    markNeedsPaint();
  }

  void _handleTapDown(TapDownDetails details) {
    _startInteraction(details.globalPosition);
  }

  void _handleTapUp(TapUpDetails details) => _endInteraction();

  Paint get _thumbPaintColor {
    Color color;

    if (!isInteractive) {
      color = disabledColor;
    } else {
      color = activeColor;

      if (hovering || _state._hoverPositionController.isAnimating) {
        color = Color.lerp(color, hoverColor, _state._hoverPosition.value)!;
      }

      if (_dragging || _state._positionController.isAnimating) {
        color = Color.lerp(color, hightlightColor, _state._position.value)!;
      }
    }

    return Paint()..color = color;
  }

  Paint get _activeTrackPaintColor {
    Color color;

    if (!isInteractive) {
      color = disabledColor;
    } else {
      color = activeColor;

      if (hovering || _state._hoverPositionController.isAnimating) {
        //color = Color.lerp(color, hoverColor, _state._hoverPosition.value)!;
      }

      if (_dragging || _state._positionController.isAnimating) {
        //color = Color.lerp(color, activeColor, _state._position.value)!;
      }
    }

    return Paint()..color = color;
  }

  Paint get _trackPaintColor {
    if (!isInteractive) {
      return Paint()..color = disabledColor;
    } else {
      return Paint()..color = trackColor;
    }
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
  bool hitTestSelf(Offset offset) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && isInteractive) {
      _state._drag.addPointer(event);
      _state._tap.addPointer(event);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double visualPosition;
    final Paint leftPaintColor;
    final Paint rightPaintColor;

    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - value;
        leftPaintColor = _trackPaintColor;
        rightPaintColor = _activeTrackPaintColor;
        break;
      case TextDirection.ltr:
        visualPosition = value;
        leftPaintColor = _activeTrackPaintColor;
        rightPaintColor = _trackPaintColor;
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
      final Paint paint = leftPaintColor;
      canvas.drawRect(
          Rect.fromLTRB(trackLeft, trackTop, trackActive, trackBottom), paint);
    }

    if (visualPosition < 1.0) {
      final Paint paint = rightPaintColor;
      canvas.drawRect(
          Rect.fromLTRB(trackActive, trackTop, trackRight, trackBottom), paint);
    }

    final Paint tPaint = _thumbPaintColor;
    canvas.drawCircle(Offset(trackActive, trackCenter), _kThumbRadius, tPaint);
  }
}
