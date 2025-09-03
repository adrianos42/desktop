import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../theme/scrolling/scrollbar.dart';
import '../theme/theme.dart';
import 'scroll_painter.dart';

const double _kMinThumbExtent = 32.0;

const double _kScrollbarThickness = 8.0;

const Duration _kScrollbarTimeToFade = Duration(milliseconds: 2000);
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);

const double _kScrollbarMinOverscrollLength = 8.0;

const Duration _kAnimationDurationIncrement = Duration(milliseconds: 200);
const Curve _kAnimationCurveIncrement = Curves.easeOut;

/// A scrollbar thumb indicates which portion of a [ScrollView] is actually
/// visible.
class Scrollbar extends StatefulWidget {
  /// Creates a desktop [Scrollbar].
  const Scrollbar({
    super.key,
    required this.child,
    this.controller,
    this.autofocus = false,
    this.focusNode,
    this.minThumbLength = _kMinThumbExtent,
    this.isAlwaysShown = true,
    this.thickness,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  });

  /// The [ScrollController] used to implement Scrollbar dragging.
  final ScrollController? controller;

  /// The thickness of the scrollbar in the cross axis of the scrollable.
  ///
  /// Will default to 8.0 pixels if null.
  final double? thickness;

  /// The widget below this widget in the tree.
  final Widget child;

  // TODO(as): Focus.
  final bool autofocus;

  // TODO(as): Focus.
  final FocusNode? focusNode;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  final ScrollNotificationPredicate notificationPredicate;

  /// The preferred smallest size the scrollbar thumb can shrink to when the total
  /// scrollable extent is large, the current visible viewport is small, and the
  /// viewport is not over scrolled.
  final double minThumbLength;

  /// Indicates that the scrollbar should be visible, even when a scroll is not
  /// underway. Defaults to true.
  final bool isAlwaysShown;

  @override
  State<Scrollbar> createState() => _ScrollbarState();
}

class _ScrollbarState extends State<Scrollbar>
    with TickerProviderStateMixin, ComponentStateMixin {
  final GlobalKey _customPaintKey = GlobalKey();
  DesktopScrollbarPainter? _painter;
  Timer? _fadeoutTimer;

  late AnimationController _fadeoutAnimationController;
  late Animation<double> _fadeoutOpacityAnimation;
  late AnimationController _thumbAnimationController;
  late Animation<double> _thumbAnimation;

  double? _dragScrollbarPosition;

  ScrollController? get _currentController =>
      widget.controller ?? PrimaryScrollController.of(context);

  ColorTween get _thumbColor {
    final theme = ScrollbarTheme.of(context);

    final Color color = pressed
        ? theme.highlightColor!
        : hovered
        ? theme.hoverColor!
        : theme.color!;

    _color = ColorTween(begin: _color?.end ?? color, end: color);
    return _color!;
  }

  ColorTween? _color;

  Color? get _trackColor {
    if (!_hideScroll) {
      final theme = ScrollbarTheme.of(context);
      return theme.trackColor!;
    }

    return null;
  }

  bool get _hideScroll => !widget.isAlwaysShown;

  Map<Type, GestureRecognizerFactory> get _gestures {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{};

    if (_currentController == null) {
      return gestures;
    }

    gestures[_ThumbPressGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<_ThumbPressGestureRecognizer>(
          () => _ThumbPressGestureRecognizer(
            debugOwner: this,
            customPaintKey: _customPaintKey,
          ),
          (_ThumbPressGestureRecognizer instance) {
            instance.onLongPress = _handleThumbPress;
            instance.onLongPressEnd = (LongPressEndDetails details) =>
                _handleThumbPressEnd(details.localPosition, details.velocity);
            instance.onLongPressMoveUpdate =
                (LongPressMoveUpdateDetails details) =>
                    _handleThumbPressUpdate(details.localPosition);
            instance.onLongPressStart = (LongPressStartDetails details) =>
                _handleThumbPressStart(details.localPosition);
          },
        );

    gestures[_TapGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<_TapGestureRecognizer>(
          () => _TapGestureRecognizer(
            debugOwner: this,
            customPaintKey: _customPaintKey,
          ),
          (_TapGestureRecognizer instance) {
            instance.onTapDown = (details) {
              double scrollIncrement;
              final ScrollIncrementCalculator? scrollIncrementCalculator =
                  Scrollable.of(
                    _currentController!.position.context.notificationContext!,
                  ).widget.incrementCalculator;
              if (scrollIncrementCalculator != null) {
                scrollIncrement = scrollIncrementCalculator(
                  ScrollIncrementDetails(
                    type: ScrollIncrementType.page,
                    metrics: _currentController!.position,
                  ),
                );
              } else {
                scrollIncrement =
                    0.8 * _currentController!.position.viewportDimension;
              }

              switch (_currentController!.position.axisDirection) {
                case AxisDirection.up:
                  if (details.localPosition.dy > _painter!.thumbOffset) {
                    scrollIncrement = -scrollIncrement;
                  }
                  break;
                case AxisDirection.right:
                  if (details.localPosition.dx < _painter!.thumbOffset) {
                    scrollIncrement = -scrollIncrement;
                  }
                  break;
                case AxisDirection.down:
                  if (details.localPosition.dy < _painter!.thumbOffset) {
                    scrollIncrement = -scrollIncrement;
                  }
                  break;
                case AxisDirection.left:
                  if (details.localPosition.dx > _painter!.thumbOffset) {
                    scrollIncrement = -scrollIncrement;
                  }
                  break;
              }

              _handleIncrement(scrollIncrement);
            };
          },
        );

    return gestures;
  }

  void _handleHoverChanged(bool value) {
    if (hovered != value) {
      if (value) {
        _fadeoutTimer?.cancel();
        _fadeoutAnimationController.forward();
      } else {
        _startFadeoutTimer();
      }
      hovered = value;

      _painter!.thumbColor = _thumbColor;
      _thumbAnimationController.forward(from: 0.0);
    }
  }

  void _handlePressedChanged(bool value) {
    if (pressed != value) {
      pressed = value;

      _painter!.thumbColor = _thumbColor;
      _thumbAnimationController.forward(from: 0.5);
    }
  }

  void _handleMouseEnter(PointerEnterEvent event) {
    _handleHoverChanged(_hitTest(event.position, event.kind));
  }

  void _handleMouseHover(PointerHoverEvent event) {
    _handleHoverChanged(_hitTest(event.position, event.kind));
  }

  void _handleMouseExit(PointerExitEvent event) {
    _handleHoverChanged(_hitTest(event.position, event.kind));
  }

  bool _hitTest(Offset offset, PointerDeviceKind kind) {
    final RenderBox renderBox =
        _customPaintKey.currentContext!.findRenderObject()! as RenderBox;

    final Offset localOffset = renderBox.globalToLocal(offset);
    return _painter!.hitTestOnlyThumbInteractive(localOffset, kind);
  }

  void _startFadeoutTimer() {
    if (_hideScroll) {
      _fadeoutTimer?.cancel();
      _fadeoutTimer = Timer(_kScrollbarTimeToFade, () {
        _fadeoutAnimationController.reverse();
        _fadeoutTimer = null;
      });
    }
  }

  Axis? get _scrollbarDirection {
    assert(_currentController != null);

    if (_currentController!.hasClients) {
      return _currentController!.position.axis;
    }

    return null;
  }

  void _updateScrollPosition(double primaryDelta) {
    assert(_currentController != null);
    final ScrollPosition position = _currentController!.position;

    final double scrollOffsetLocal = _painter!.getTrackToScroll(primaryDelta);
    final double scrollOffsetGlobal = scrollOffsetLocal + position.pixels;
    if (scrollOffsetGlobal != position.pixels) {
      final double physicsAdjustment = position.physics.applyBoundaryConditions(
        position,
        scrollOffsetGlobal,
      );
      position.jumpTo(scrollOffsetGlobal - physicsAdjustment);
    }
  }

  void _handleThumbPress() {
    if (_scrollbarDirection == null) {
      return;
    }
    _fadeoutTimer?.cancel();
  }

  void _handleThumbPressStart(Offset localPosition) {
    final Axis? direction = _scrollbarDirection;
    if (direction == null) {
      return;
    }

    _fadeoutTimer?.cancel();
    _fadeoutAnimationController.forward();

    switch (direction) {
      case Axis.vertical:
        _dragScrollbarPosition = localPosition.dy;
        break;
      case Axis.horizontal:
        _dragScrollbarPosition = localPosition.dx;
        break;
    }

    _handlePressedChanged(true);
  }

  void _handleThumbPressUpdate(Offset localPosition) {
    final Axis? direction = _scrollbarDirection;

    if (direction == null) {
      return;
    }

    switch (direction) {
      case Axis.vertical:
        _updateScrollPosition(localPosition.dy - _dragScrollbarPosition!);
        _dragScrollbarPosition = localPosition.dy;
        break;
      case Axis.horizontal:
        _updateScrollPosition(localPosition.dx - _dragScrollbarPosition!);
        _dragScrollbarPosition = localPosition.dx;
        break;
    }
  }

  void _handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    final Axis? direction = _scrollbarDirection;

    if (direction == null) {
      return;
    }

    _startFadeoutTimer();
    _dragScrollbarPosition = null;
    _handlePressedChanged(false);
  }

  void _handleIncrement(double value) {
    final position = _currentController!.position;
    position.moveTo(
      position.pixels + value,
      curve: _kAnimationCurveIncrement,
      duration: _kAnimationDurationIncrement,
    );
  }

  bool _shouldUpdatePainter(Axis notificationAxis) {
    final ScrollController scrollController =
        widget.controller ?? PrimaryScrollController.of(context);
    // Only update the painter of this scrollbar if the notification
    // metrics do not conflict with the information we have from the scroll
    // controller.

    // Has more than one attached positions.
    if (scrollController.positions.length > 1) {
      return false;
    }

    return
    // The scroll controller is not attached to a position.
    !scrollController.hasClients
        // The notification matches the scroll controller's axis.
        ||
        scrollController.position.axis == notificationAxis;
  }

  bool _handleScrollMetricsNotification(
    ScrollMetricsNotification notification,
  ) {
    if (!widget.notificationPredicate(
      ScrollUpdateNotification(
        metrics: notification.metrics,
        context: notification.context,
        depth: notification.depth,
      ),
    )) {
      return false;
    }

    if (!_hideScroll) {
      if (_fadeoutAnimationController.status != AnimationStatus.forward &&
          _fadeoutAnimationController.status != AnimationStatus.completed) {
        _fadeoutAnimationController.forward();
      }
    }

    final ScrollMetrics metrics = notification.metrics;

    if (metrics.maxScrollExtent <= metrics.minScrollExtent) {
      _fadeoutAnimationController.reverse();
      _painter!.update(metrics, metrics.axisDirection);
      return true;
    }

    if (_shouldUpdatePainter(metrics.axis)) {
      _painter!.update(metrics, metrics.axisDirection);
      return true;
    }

    return false;
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) {
      return false;
    }

    final ScrollMetrics metrics = notification.metrics;

    if (notification is ScrollUpdateNotification ||
        notification is OverscrollNotification) {
      if (_fadeoutAnimationController.status != AnimationStatus.forward) {
        _fadeoutAnimationController.forward();
      }

      _fadeoutTimer?.cancel();
      _painter!.update(metrics, metrics.axisDirection);
    } else if (notification is ScrollEndNotification) {
      if (_dragScrollbarPosition == null) {
        _startFadeoutTimer();
      }
    } else {
      return false;
    }

    return true;
  }

  void _updateScrollbarPainter() {
    _painter!
      ..thumbColor = _thumbColor
      ..trackColor = _trackColor
      ..textDirection = Directionality.of(context)
      ..thickness = widget.thickness ?? _kScrollbarThickness
      ..padding = MediaQuery.of(context).padding;
  }

  void _maybeTriggerScrollbar() {
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      final ScrollController scrollController =
          widget.controller ?? PrimaryScrollController.of(context);
      scrollController.position.didUpdateScrollPositionBy(0);

      if (!_hideScroll) {
        _fadeoutTimer?.cancel();
      } else {
        _startFadeoutTimer();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // _actionMap = <Type, Action<Intent>>{
    //   ScrollIntent: CallbackAction<ScrollIntent>(onInvoke: (action) {
    //     switch (action.direction) {
    //       case AxisDirection.down:
    //         break;
    //       case AxisDirection.up:
    //         break;
    //       default:
    //     }
    //   }),
    // };

    _fadeoutAnimationController = AnimationController(
      vsync: this,
      duration: _kScrollbarFadeDuration,
    )..addStatusListener(_validateInteractions);

    _fadeoutOpacityAnimation = CurvedAnimation(
      parent: _fadeoutAnimationController,
      curve: Curves.easeIn,
    );

    _thumbAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _thumbAnimation = CurvedAnimation(
      parent: _thumbAnimationController,
      curve: Curves.linear,
    );

    _painter = DesktopScrollbarPainter(
      thumbColor: ColorTween(),
      thumbColorAnimation: _thumbAnimation,
      trackColor: null,
      thickness: _kScrollbarThickness,
      textDirection: TextDirection.ltr,
      minOverscrollLength: _kScrollbarMinOverscrollLength,
      minLength: widget.minThumbLength,
      fadeoutOpacityAnimation: _fadeoutOpacityAnimation,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool get showScrollbar => widget.isAlwaysShown;

  void _validateInteractions(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      assert(_fadeoutOpacityAnimation.value == 0.0);
      // We do not check for a valid scroll position if the scrollbar is not
      // visible, because it cannot be interacted with.
    }
  }

  @override
  void didUpdateWidget(Scrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAlwaysShown != oldWidget.isAlwaysShown) {
      if (widget.isAlwaysShown) {
        _maybeTriggerScrollbar();
        _fadeoutAnimationController.forward();
      } else {
        _fadeoutAnimationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _fadeoutTimer?.cancel();
    _fadeoutAnimationController.dispose();
    _thumbAnimationController.dispose();
    _painter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateScrollbarPainter();

    final Widget result = MouseRegion(
      opaque: true,
      onEnter: _handleMouseEnter,
      onExit: _handleMouseExit,
      onHover: _handleMouseHover,
      child: RawGestureDetector(
        gestures: _gestures,
        behavior: HitTestBehavior.opaque,
        child: CustomPaint(
          key: _customPaintKey,
          foregroundPainter: _painter,
          child: RepaintBoundary(child: widget.child),
        ),
      ),
    );

    return NotificationListener<ScrollMetricsNotification>(
      onNotification: _handleScrollMetricsNotification,
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: RepaintBoundary(child: result),
      ),
    );
  }
}

class _ThumbPressGestureRecognizer extends LongPressGestureRecognizer {
  _ThumbPressGestureRecognizer({
    super.debugOwner,
    required GlobalKey customPaintKey,
  }) : _customPaintKey = customPaintKey,
       super(duration: Duration.zero);

  final GlobalKey _customPaintKey;

  @override
  bool isPointerAllowed(PointerDownEvent event) {
    if (!_hitTest(_customPaintKey, event.position, event.kind)) {
      return false;
    }
    return super.isPointerAllowed(event);
  }

  bool _hitTest(
    GlobalKey customPaintKey,
    Offset offset,
    PointerDeviceKind kind,
  ) {
    if (customPaintKey.currentContext == null) {
      return false;
    }
    final CustomPaint customPaint =
        customPaintKey.currentContext!.widget as CustomPaint;
    final DesktopScrollbarPainter painter =
        customPaint.foregroundPainter! as DesktopScrollbarPainter;
    final RenderBox renderBox =
        customPaintKey.currentContext!.findRenderObject()! as RenderBox;

    final Offset localOffset = renderBox.globalToLocal(offset);
    return painter.hitTestOnlyThumbInteractive(localOffset, kind);
  }
}

class _TapGestureRecognizer extends TapGestureRecognizer {
  _TapGestureRecognizer({super.debugOwner, required GlobalKey customPaintKey})
    : _customPaintKey = customPaintKey;

  final GlobalKey _customPaintKey;
  GlobalKey get customPaintKey => _customPaintKey;

  RenderBox get renderBox =>
      _customPaintKey.currentContext!.findRenderObject()! as RenderBox;

  CustomPaint get customPaint =>
      _customPaintKey.currentContext!.widget as CustomPaint;

  DesktopScrollbarPainter get painter =>
      customPaint.foregroundPainter! as DesktopScrollbarPainter;

  Offset localOffset(Offset value) => renderBox.globalToLocal(value);

  @override
  bool isPointerAllowed(PointerDownEvent event) {
    if (!_hitTest(_customPaintKey, event.position, event.kind)) {
      return false;
    }
    return super.isPointerAllowed(event);
  }

  bool _hitTest(
    GlobalKey customPaintKey,
    Offset offset,
    PointerDeviceKind kind,
  ) {
    if (customPaintKey.currentContext == null) {
      return false;
    }
    final CustomPaint customPaint =
        customPaintKey.currentContext!.widget as CustomPaint;
    final DesktopScrollbarPainter painter =
        customPaint.foregroundPainter! as DesktopScrollbarPainter;
    final RenderBox renderBox =
        customPaintKey.currentContext!.findRenderObject()! as RenderBox;

    final Offset localOffset = renderBox.globalToLocal(offset);
    return painter.hitTestInteractive(localOffset, kind) &&
        !painter.hitTestOnlyThumbInteractive(localOffset, kind);
  }
}
