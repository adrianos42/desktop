import 'dart:async';
import 'dart:math' as math;

import 'scroll_painter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

import '../theme/theme.dart';
import '../theme/scrollbar.dart';
import '../component.dart';

const double _kScrollbarThickness = 8.0;
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 1800);
const Duration _kScrollbarTimeToShow = Duration(milliseconds: 400);
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 250);
const double _kScrollTapIncrement = 0.05;
const double _kScrollbarMinOverscrollLength = 8.0;
const Duration _kAnimationDuration = Duration(milliseconds: 200);
const Curve _kAnimationCurve = Curves.linear;
const Duration _kAnimationDurationIncrement = Duration(milliseconds: 160);
const Curve _kAnimationCurveIncrement = Curves.easeOutQuad;

const double _kMinThumbExtent = 32.0;
const double _kScrollbarMinLength = _kMinThumbExtent;

// class PageUpAction extends Action {
//   PageUpAction() : super(key);

//   static const LocalKey key = ValueKey<Type>(PageUpAction);

//   @override
//   void invoke(FocusNode node, Intent intent) => {};
// }

// class PageDownAction extends Action {
//   PageDownAction() : super(key);

//   static const LocalKey key = ValueKey<Type>(PageDownAction);

//   @override
//   void invoke(FocusNode node, Intent intent) => {};
// }

class Scrollbar extends StatefulWidget {
  const Scrollbar({
    Key? key,
    required this.child,
    this.controller,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
  }) : super(key: key);

  final ScrollController? controller;

  final Widget child;

  final bool autofocus;

  final bool enabled;

  final FocusNode? focusNode;

  @override
  _ScrollbarState createState() => _ScrollbarState();
}

class _ScrollbarState extends State<Scrollbar>
    with TickerProviderStateMixin, WidgetsBindingObserver, ComponentStateMixin {
  final GlobalKey _customPaintKey = GlobalKey();
  DesktopScrollbarPainter? _painter;
  Timer? _fadeoutTimer;
  Timer? _showTimer;

  late Map<Type, Action<Intent>> _actionMap;

  // static final Map<LogicalKeySet, Intent> _shortcuts = <LogicalKeySet, Intent>{
  //   LogicalKeySet(LogicalKeyboardKey.pageUp): const Intent(PageUpAction.key),
  //   LogicalKeySet(LogicalKeyboardKey.pageDown):
  //       const Intent(PageDownAction.key),
  // };

  HSLColor get _trackColor {
    final theme = ScrollbarTheme.of(context);
    return pressed
        ? theme.highlightColor!
        : hovered
            ? theme.hoverColor!
            : theme.color!;
  }

  late AnimationController _fadeoutAnimationController;
  late Animation<double> _fadeoutOpacityAnimation;
  double? _dragScrollbarPositionY;
  Drag? _drag;

  final bool _hideScroll = false;

  ScrollController? _currentController;
  ScrollController get _controller =>
      widget.controller ?? (_currentController ??= ScrollController());

  ScrollPosition get _position => _controller.position;

  Map<Type, GestureRecognizerFactory> get _gestures {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{};

    gestures[_ThumbVerticalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<
            _ThumbVerticalDragGestureRecognizer>(
      () => _ThumbVerticalDragGestureRecognizer(
        debugOwner: this,
        customPaintKey: _customPaintKey,
      ),
      (_ThumbVerticalDragGestureRecognizer instance) {
        instance
          ..onStart = _handleDragStart
          ..onDown = _handleDragDown
          ..onUpdate = _handleDragUpdate
          ..onCancel = _handleDragCancel
          ..onEnd = _handleDragEnd;
      },
    );

    //_ThumbDragGestureRecognizer

    gestures[_TapGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<_TapGestureRecognizer>(
      () => _TapGestureRecognizer(
        debugOwner: this,
        customPaintKey: _customPaintKey,
      ),
      (_TapGestureRecognizer instance) {
        instance
          ..onTap = () {
            if (instance.region == _TapRegion.down) {
              _handleIncrement(_kScrollTapIncrement);
            } else if (instance.region == _TapRegion.up) {
              _handleIncrement(-_kScrollTapIncrement);
            }
          };
      },
    );

    return gestures;
  }

  void _updateTrackColor() {
    _painter?.color = _trackColor.toColor();
  }

  void _handleHoverChanged(bool value) {
    if (hovered != value) {
      hovered = value;
      _updateTrackColor();
    }
  }

  void _handlePressedChanged(bool value) {
    if (pressed != value) {
      pressed = value;
      _updateTrackColor();
    }
  }

  void _handleMouseEnter(PointerEnterEvent event) {
    _handleHoverChanged(_hitTest(_customPaintKey, event.position));
  }

  void _handleMouseHover(PointerHoverEvent event) {
    _handleHoverChanged(_hitTest(_customPaintKey, event.position));
  }

  void _handleMouseExit(PointerExitEvent event) {
    _handleHoverChanged(_hitTest(_customPaintKey, event.position));
  }

  DesktopScrollbarPainter _buildScrollbarPainter(BuildContext context) {
    return DesktopScrollbarPainter(
      color: _trackColor.toColor(),
      thickness: _kScrollbarThickness,
      textDirection: Directionality.of(context),
      minOverscrollLength: _kScrollbarMinOverscrollLength,
      minLength: _kScrollbarMinLength,
      fadeoutOpacityAnimation: _fadeoutOpacityAnimation,
    );
  }

  void _startFadeoutTimer() {
    _fadeoutTimer?.cancel();

    if (_hideScroll) {
      _fadeoutTimer = Timer(_kScrollbarTimeToFade, () {
        _fadeoutAnimationController.reverse();
        _fadeoutTimer = null;
      });
    }
  }

  void _startShowTimer() {
    _showTimer?.cancel();

    _showTimer = Timer(_kScrollbarTimeToShow, () {
      if (_position.maxScrollExtent <= _position.minScrollExtent) {
        return;
      }

      _fadeoutAnimationController.forward();

      _painter!.update(_position, _position.axisDirection);
    });
  }

  void _dragScrollbar(double primaryDelta) {
    if (_position.maxScrollExtent <= 0.0) {
      return;
    }

    final double scrollOffsetLocal =
        _painter!.getTrackToScroll(primaryDelta).roundToDouble();
    final double scrollOffsetGlobal = scrollOffsetLocal + _position.pixels;

    if (_drag == null) {
      _drag = _position.drag(
        DragStartDetails(
          globalPosition: Offset(0.0, scrollOffsetGlobal),
        ),
        () {},
      );
    } else {
      _drag!.update(DragUpdateDetails(
        globalPosition: Offset(0.0, scrollOffsetGlobal),
        delta: Offset(0.0, -scrollOffsetLocal),
        primaryDelta: -scrollOffsetLocal,
      ));
    }
  }

  void _handleDragStart(DragStartDetails details) {
    _drag = null;

    _fadeoutTimer?.cancel();
    _fadeoutAnimationController.forward();
    _dragScrollbar(details.localPosition.dy);
    _dragScrollbarPositionY = details.localPosition.dy;

    _handlePressedChanged(true);
    _fadeoutTimer?.cancel();
  }

  void _handleDragDown(DragDownDetails details) {}

  void _handleDragUpdate(DragUpdateDetails details) {
    assert(_dragScrollbarPositionY != null);

    _dragScrollbar(details.localPosition.dy - _dragScrollbarPositionY!);
    _dragScrollbarPositionY = details.localPosition.dy;
  }

  void _handleDragEnd(DragEndDetails details) {
    final double scrollVelocityY =
        _painter!.getTrackToScroll(details.velocity.pixelsPerSecond.dy);

    // _drag?.end(DragEndDetails(
    //   primaryVelocity: -scrollVelocityY,
    //   velocity: Velocity(pixelsPerSecond: Offset(0.0, -scrollVelocityY)),
    // ));

    _drag?.end(DragEndDetails(
      primaryVelocity: -0,
      velocity: Velocity(pixelsPerSecond: Offset(0.0, -0)),
    ));

    _handleDragScrollEnd();

    _handlePressedChanged(false);
  }

  void _handleDragCancel() {
    _drag?.cancel();
    _handleDragScrollEnd();
  }

  void _handleDragScrollEnd() {
    _startFadeoutTimer();
    _dragScrollbarPositionY = null;

    _drag = null;

    _handlePressedChanged(false);
  }

  void _receivedPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      _targetScrollOffsetForPointerScroll(event);
    }
  }

  double _scrollInitialPosition = 0.0;

  void _handleIncrement(double value) {
    double totalContentExtent = _position.maxScrollExtent -
        _position.minScrollExtent +
        _position.viewportDimension;

    _position.moveTo(_position.pixels + (totalContentExtent) * value,
        curve: _kAnimationCurveIncrement,
        duration: _kAnimationDurationIncrement);
  }

  Timer? _scrollTimer;

  void _targetScrollOffsetForPointerScroll(PointerScrollEvent event) {
    double delta = _position.axis == Axis.horizontal
        ? event.scrollDelta.dx
        : event.scrollDelta.dy;

    _scrollTimer?.cancel();

    if (_scrollTimer != null) {
      if (_scrollInitialPosition.isNegative != delta.isNegative) {
        _scrollInitialPosition = _position.pixels;
      }

      _scrollInitialPosition += delta;

      _position.moveTo(_scrollInitialPosition);

      // _position.animateTo(_scrollInitialPosition,
      //     duration: Duration(milliseconds: 400), curve: Curves.ease);
    } else {
      _scrollInitialPosition = _position.pixels;
    }

    _scrollTimer = Timer(Duration(milliseconds: 1000), () {
      _scrollTimer = null;
    });

    // if (_drag == null) {
    //   _targetScrollOffset = delta;
    // } else {
    //   if (delta.isFinite != _targetScrollOffset.isFinite) {
    //     _handleDragCancel();
    //   }

    //   _targetScrollOffset += delta;
    // }
  }

  void _scrollScrollbar(double primaryDelta) {
    if (_position.maxScrollExtent <= 0.0) {
      return;
    }

    final double scrollOffsetLocal = primaryDelta;
    final double scrollOffsetGlobal =
        scrollOffsetLocal + _scrollInitialPosition;

    if (_drag == null) {
      _drag = _position.drag(
        DragStartDetails(
          globalPosition: Offset(0.0, scrollOffsetGlobal),
        ),
        () {},
      );
    } else {
      _drag!.update(DragUpdateDetails(
        globalPosition: Offset(0.0, scrollOffsetGlobal),
        delta: Offset(0.0, -scrollOffsetLocal),
        primaryDelta: -scrollOffsetLocal,
      ));
    }
  }

  void _handlePositionStateChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {}
  }

  double _previousValue = 0.0;
  double _positionCompleted = 0.0;

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;

    if (metrics.maxScrollExtent <= metrics.minScrollExtent) {
      return false;
    }

    if (notification is ScrollUpdateNotification ||
        notification is OverscrollNotification) {
      if (_fadeoutAnimationController.status != AnimationStatus.forward) {
        _fadeoutAnimationController.forward();
      }

      _fadeoutTimer?.cancel();
      _painter!.update(metrics, metrics.axisDirection);
    } else if (notification is ScrollEndNotification) {
      if (_dragScrollbarPositionY == null) {
        _startFadeoutTimer();
      }
    }

    return false;
  }

  late AnimationController _positionController;
  late CurvedAnimation _positionAnimation;

  @override
  void initState() {
    super.initState();

    _positionController = AnimationController(
      vsync: this,
      duration: _kAnimationDuration,
    );

    _positionAnimation =
        CurvedAnimation(parent: _positionController, curve: _kAnimationCurve)
          // ..addListener(_updateScroll)
          ..addStatusListener(_handlePositionStateChanged);

    _actionMap = <Type, Action<Intent>>{
      ScrollIntent: CallbackAction<ScrollIntent>(onInvoke: (action) {
        switch (action.direction) {
          case AxisDirection.down:
            _scrollScrollbar(120.0);
            break;
          case AxisDirection.up:
            _scrollScrollbar(-120.0);
            break;
          default:
        }
      }),
    };

    // _actionMap = <LocalKey, ActionFactory>{
    //   PageDownAction.key: () => CallbackAction(
    //         PageDownAction.key,
    //         onInvoke: (node, tag) => _addScrollOffsetDelta(120.0),
    //       ),
    //   PageUpAction.key: () => CallbackAction(
    //         PageUpAction.key,
    //         onInvoke: (node, tag) => _addScrollOffsetDelta(-120.0),
    //       ),
    // };

    WidgetsBinding.instance!.addObserver(this);

    _fadeoutAnimationController = AnimationController(
      vsync: this,
      duration: _kScrollbarFadeDuration,
    );

    _fadeoutOpacityAnimation = CurvedAnimation(
      parent: _fadeoutAnimationController,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void didChangeMetrics() {
    if (mounted) {
      setState(() {
        _painter!
          ..textDirection = Directionality.of(context)
          ..padding = EdgeInsets.zero
          ..color = _trackColor.toColor();
      });

      if (_position.maxScrollExtent <= _position.minScrollExtent) {
        _fadeoutAnimationController.reverse();
      } else if (!_hideScroll) {
        _fadeoutAnimationController.forward();

        _painter!.update(_position, _position.axisDirection);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_painter == null) {
      _painter = _buildScrollbarPainter(context);
    } else {
      _painter!
        ..textDirection = Directionality.of(context)
        //..padding = MediaQuery.of(context).padding
        ..color = _trackColor.toColor();
    }

    WidgetsBinding.instance!.addPostFrameCallback((Duration duration) {
      if (!_hideScroll) {
        assert(widget.controller != null); // TODO
        widget.controller!.position.didUpdateScrollPositionBy(0);
      }
    });
  }

  @override
  void didUpdateWidget(Scrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _fadeoutTimer?.cancel();
    _fadeoutAnimationController.dispose();
    _showTimer?.cancel();
    _painter?.dispose();
    _positionAnimation
      //..removeListener(_updateScroll)
      ..removeStatusListener(_handlePositionStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Listener(
              child: Container(
                // margin: EdgeInsets.only(right: _kScrollbarThickness),
                child: widget.child,
              ),
              behavior: HitTestBehavior.deferToChild,
              onPointerSignal: _receivedPointerSignal,
            ),
          ),
          RepaintBoundary(
            child: RawGestureDetector(
              gestures: _gestures,
              behavior: HitTestBehavior.deferToChild,
              child: MouseRegion(
                opaque: true,
                onEnter: _handleMouseEnter,
                onExit: _handleMouseExit,
                onHover: _handleMouseHover,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
                  //padding: EdgeInsets.zero,
                  child: CustomPaint(
                    key: _customPaintKey,
                    foregroundPainter: widget.enabled ? _painter : null,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: _kScrollbarThickness,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    result = FocusableActionDetector(
      child: result,
      actions: _actionMap,
      // shortcuts: _shortcuts,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onShowFocusHighlight: (value) {},
      onShowHoverHighlight: (_) {},
      onFocusChange: (value) {},
    );

    return result;
  }
}

class _ThumbVerticalDragGestureRecognizer
    extends VerticalDragGestureRecognizer {
  _ThumbVerticalDragGestureRecognizer({
    PointerDeviceKind? kind,
    Object? debugOwner,
    required GlobalKey customPaintKey,
  })   : _customPaintKey = customPaintKey,
        super(
          kind: kind,
          debugOwner: debugOwner,
        );

  final GlobalKey _customPaintKey;

  @override
  bool isPointerAllowed(PointerEvent event) {
    if (!_hitTest(_customPaintKey, event.position)) {
      return false;
    }
    return super.isPointerAllowed(event);
  }
}

enum _TapRegion {
  up,
  down,
}

class _TapGestureRecognizer extends TapGestureRecognizer {
  _TapGestureRecognizer({
    Object? debugOwner,
    required GlobalKey customPaintKey,
  })   : _customPaintKey = customPaintKey,
        super(
          debugOwner: debugOwner,
        );

  final GlobalKey _customPaintKey;
  GlobalKey get customPaintKey => _customPaintKey;

  RenderBox get renderBox =>
      _customPaintKey.currentContext!.findRenderObject() as RenderBox;

  CustomPaint get customPaint =>
      _customPaintKey.currentContext!.widget as CustomPaint;

  DesktopScrollbarPainter get painter =>
      customPaint.foregroundPainter as DesktopScrollbarPainter;

  Offset localOffset(Offset value) => renderBox.globalToLocal(value);

  _TapRegion? _region;
  _TapRegion? get region => _region;

  @override
  bool isPointerAllowed(PointerDownEvent event) {
    if (_customPaintKey.currentContext == null) {
      return false;
    }

    if (painter.thumbRect!.top >= localOffset(event.position).dy &&
        painter.thumbRect!.left <= localOffset(event.position).dx &&
        painter.thumbRect!.right >= localOffset(event.position).dx) {
      _region = _TapRegion.up;
    } else if (painter.thumbRect!.bottom <= localOffset(event.position).dy &&
        painter.thumbRect!.left <= localOffset(event.position).dx &&
        painter.thumbRect!.right >= localOffset(event.position).dx) {
      _region = _TapRegion.down;
    } else {
      return false;
    }

    return super.isPointerAllowed(event);
  }
}

bool _hitTest(GlobalKey customPaintKey, Offset offset) {
  if (customPaintKey.currentContext == null) {
    return false;
  }
  final CustomPaint customPaint =
      customPaintKey.currentContext!.widget as CustomPaint;
  final DesktopScrollbarPainter painter =
      customPaint.foregroundPainter as DesktopScrollbarPainter;
  final RenderBox renderBox =
      customPaintKey.currentContext!.findRenderObject() as RenderBox;

  final Offset localOffset = renderBox.globalToLocal(offset);
  return painter.hitTest(localOffset);
}
