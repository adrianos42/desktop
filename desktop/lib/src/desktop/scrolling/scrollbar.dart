import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../theme/scrollbar.dart';
import '../theme/theme.dart';
import 'scroll_painter.dart';

const double _kMinThumbExtent = 32.0;

const double _kScrollbarThickness = 8.0;

const Duration _kScrollbarTimeToFade = Duration(milliseconds: 1200);
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);

const double _kScrollbarMinOverscrollLength = 8.0;

const Duration _kAnimationDurationIncrement = Duration(milliseconds: 200);
const Curve _kAnimationCurveIncrement = Curves.easeOut;

/// A scrollbar thumb indicates which portion of a [ScrollView] is actually
/// visible.
class Scrollbar extends StatefulWidget {
  /// Creates a desktop [Scrollbar].
  const Scrollbar({
    Key? key,
    required this.child,
    this.controller,
    this.autofocus = false,
    this.focusNode,
    this.minThumbLength = _kMinThumbExtent,
    this.isAlwaysShown = true,
    this.thickness,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  }) : super(key: key);

  /// {@template flutter.widgets.Scrollbar.controller}
  /// The [ScrollController] used to implement Scrollbar dragging.
  final ScrollController? controller;

  /// The thickness of the scrollbar in the cross axis of the scrollable.
  ///
  /// Will default to 6.0 pixels if null.
  final double? thickness;

  /// The widget below this widget in the tree.
  final Widget child;

  /// TODO(as): Focus.
  final bool autofocus;

  /// TODO(as): Focus.
  final FocusNode? focusNode;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  final ScrollNotificationPredicate notificationPredicate;

  /// The preferred smallest size the scrollbar thumb can shrink to when the total
  /// scrollable extent is large, the current visible viewport is small, and the
  /// viewport is not overscrolled.
  final double minThumbLength;

  /// Indicates that the scrollbar should be visible, even when a scroll is not
  /// underway. Defaults to true.
  final bool isAlwaysShown;

  @override
  _ScrollbarState createState() => _ScrollbarState();
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

    _color = ColorTween(
      begin: _color?.end ?? color,
      end: color,
    );
    return _color!;
  }

  ColorTween? _color;

  Color? get _trackColor {
    return null;
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
        instance.onLongPressMoveUpdate = (LongPressMoveUpdateDetails details) =>
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
                      _currentController!.position.context.notificationContext!)
                  ?.widget
                  .incrementCalculator;
          if (scrollIncrementCalculator != null) {
            scrollIncrement = scrollIncrementCalculator(ScrollIncrementDetails(
              type: ScrollIncrementType.page,
              metrics: _currentController!.position,
            ));
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

  DesktopScrollbarPainter _buildScrollbarPainter(BuildContext context) {
    return DesktopScrollbarPainter(
      thumbColor: _thumbColor,
      thumbColorAnimation: _thumbAnimation,
      trackColor: _trackColor,
      thickness: _kScrollbarThickness,
      textDirection: Directionality.of(context),
      minOverscrollLength: _kScrollbarMinOverscrollLength,
      minLength: widget.minThumbLength,
      fadeoutOpacityAnimation: _fadeoutOpacityAnimation,
    );
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
      final double physicsAdjustment = position.physics
          .applyBoundaryConditions(position, scrollOffsetGlobal);
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
    final _position = _currentController!.position;
    _position.moveTo(_position.pixels + value,
        curve: _kAnimationCurveIncrement,
        duration: _kAnimationDurationIncrement);
  }

  bool _shouldUpdatePainter(Axis notificationAxis) {
    final ScrollController? scrollController =
        widget.controller ?? PrimaryScrollController.of(context);
    // Only update the painter of this scrollbar if the notification
    // metrics do not conflict with the information we have from the scroll
    // controller.

    // We do not have a scroll controller dictating axis.
    if (scrollController == null) {
      return true;
    }
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
      ScrollMetricsNotification notification) {
    if (!widget.notificationPredicate(ScrollUpdateNotification(
      metrics: notification.metrics,
      context: notification.context,
      //depth: notification.depth,
    ))) {
      return false;
    }

    if (widget.isAlwaysShown) {
      if (_fadeoutAnimationController.status != AnimationStatus.forward &&
          _fadeoutAnimationController.status != AnimationStatus.completed) {
        //_fadeoutAnimationController.forward();
      }
    }

    final ScrollMetrics metrics = notification.metrics;
    if (_shouldUpdatePainter(metrics.axis)) {
      _painter!.update(metrics, metrics.axisDirection);
    }

    return false;
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) {
      return false;
    }

    final ScrollMetrics metrics = notification.metrics;

    if (metrics.maxScrollExtent <= metrics.minScrollExtent) {
      _fadeoutAnimationController.reverse();
      _painter!.update(metrics, metrics.axisDirection);
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
      if (_dragScrollbarPosition == null) {
        _startFadeoutTimer();
      }
    }

    return false;
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
          widget.controller ?? PrimaryScrollController.of(context)!;
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

    _thumbAnimationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _color = null;

    if (_painter == null) {
      _painter = _buildScrollbarPainter(context);
    } else {
      _painter!
        ..textDirection = Directionality.of(context)
        ..padding = MediaQuery.of(context).padding
        ..thumbColor = _thumbColor;
    }

    final _ = MediaQuery.of(context).size;

    _maybeTriggerScrollbar();
  }

  bool get showScrollbar => widget.isAlwaysShown;

  void _validateInteractions(AnimationStatus status) {
    final ScrollController? scrollController =
        widget.controller ?? PrimaryScrollController.of(context);
    if (status == AnimationStatus.dismissed) {
      assert(_fadeoutOpacityAnimation.value == 0.0);
      // We do not check for a valid scroll position if the scrollbar is not
      // visible, because it cannot be interacted with.
    } else if (scrollController != null) {
      // Interactive scrollbars need to be properly configured. If it is visible
      // for interaction, ensure we are set up properly.
      assert(_debugCheckHasValidScrollPosition());
    }
  }

  bool _debugCheckHasValidScrollPosition() {
    final ScrollController? scrollController =
        widget.controller ?? PrimaryScrollController.of(context);
    final bool tryPrimary = widget.controller == null;
    final String controllerForError =
        tryPrimary ? 'PrimaryScrollController' : 'provided ScrollController';

    String when = '';
    if (showScrollbar) {
      when = 'Scrollbar.isAlwaysShown is true';
    } else {
      when = 'the scrollbar is interactive';
    }

    assert(
      scrollController != null,
      'A ScrollController is required when $when. '
      '${tryPrimary ? 'The Scrollbar was not provided a ScrollController, '
          'and attempted to use the PrimaryScrollController, but none was found.' : ''}',
    );
    assert(() {
      if (!scrollController!.hasClients) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            "The Scrollbar's ScrollController has no ScrollPosition attached.",
          ),
          ErrorDescription(
            'A Scrollbar cannot be painted without a ScrollPosition. ',
          ),
          ErrorHint(
            'The Scrollbar attempted to use the $controllerForError. This '
            'ScrollController should be associated with the ScrollView that '
            'the Scrollbar is being applied to. '
            '${tryPrimary ? 'A ScrollView with an Axis.vertical '
                'ScrollDirection will automatically use the '
                'PrimaryScrollController if the user has not provided a '
                'ScrollController, but a ScrollDirection of Axis.horizontal will '
                'not. To use the PrimaryScrollController explicitly, set ScrollView.primary '
                'to true for the Scrollable widget.' : 'When providing your own ScrollController, ensure both the '
                'Scrollbar and the Scrollable widget use the same one.'}',
          ),
        ]);
      }
      return true;
    }());
    assert(() {
      try {
        scrollController!.position;
      } catch (_) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            'The $controllerForError is currently attached to more than one '
            'ScrollPosition.',
          ),
          ErrorDescription(
            'The Scrollbar requires a single ScrollPosition in order to be painted.',
          ),
          ErrorHint(
            'When $when, the associated Scrollable '
            'widgets must have unique ScrollControllers. '
            '${tryPrimary ? 'The PrimaryScrollController is used by default for '
                'ScrollViews with an Axis.vertical ScrollDirection, '
                'unless the ScrollView has been provided its own '
                'ScrollController. More than one Scrollable may have tried '
                'to use the PrimaryScrollController of the current context.' : 'The provided ScrollController must be unique to a '
                'Scrollable widget.'}',
          ),
        ]);
      }
      return true;
    }());
    return true;
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
    Object? debugOwner,
    required GlobalKey customPaintKey,
  })  : _customPaintKey = customPaintKey,
        super(
          debugOwner: debugOwner,
          duration: Duration.zero,
        );

  final GlobalKey _customPaintKey;

  @override
  bool isPointerAllowed(PointerDownEvent event) {
    if (!_hitTest(_customPaintKey, event.position, event.kind)) {
      return false;
    }
    return super.isPointerAllowed(event);
  }

  bool _hitTest(
      GlobalKey customPaintKey, Offset offset, PointerDeviceKind kind) {
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
  _TapGestureRecognizer({
    Object? debugOwner,
    required GlobalKey customPaintKey,
  })  : _customPaintKey = customPaintKey,
        super(
          debugOwner: debugOwner,
        );

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
      GlobalKey customPaintKey, Offset offset, PointerDeviceKind kind) {
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
