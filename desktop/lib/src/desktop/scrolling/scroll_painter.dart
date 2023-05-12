import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

const double _kMinInteractiveSize = 48.0;

/// Scroll painter for desktop.
class DesktopScrollbarPainter extends ChangeNotifier implements CustomPainter {
  /// Creates a [DesktopScrollbarPainter].
  DesktopScrollbarPainter({
    required ColorTween thumbColor,
    required TextDirection textDirection,
    required double thickness,
    required this.fadeoutOpacityAnimation,
    required this.thumbColorAnimation,
    EdgeInsets padding = EdgeInsets.zero,
    this.mainAxisMargin = 0.0,
    this.crossAxisMargin = 0.0,
    required double minLength,
    double? minOverscrollLength,
    Color? trackColor,
  })  : assert(minLength >= 0),
        assert(minOverscrollLength == null || minOverscrollLength <= minLength),
        assert(minOverscrollLength == null || minOverscrollLength >= 0),
        assert(padding.isNonNegative),
        _thumbColor = thumbColor,
        _trackColor = trackColor,
        _thickness = thickness,
        _textDirection = textDirection,
        _padding = padding,
        _minLength = minLength,
        _minOverscrollLength = minOverscrollLength ?? minLength {
    fadeoutOpacityAnimation.addListener(notifyListeners);
    thumbColorAnimation.addListener(notifyListeners);
  }

  late double _thumbOffset;

  /// Thumb offset.
  double get thumbOffset => _thumbOffset;

  /// [Color] of the thumb.
  ColorTween get thumbColor => _thumbColor;
  ColorTween _thumbColor;
  set thumbColor(ColorTween value) {
    if (thumbColor == value) {
      return;
    }

    _thumbColor = value;
    notifyListeners();
  }

  Color? get trackColor => _trackColor;
  Color? _trackColor;
  set trackColor(Color? value) {
    if (trackColor == value) {
      return;
    }

    _trackColor = value;
    notifyListeners();
  }

  /// [TextDirection] of the [BuildContext] which dictates the side of the
  /// screen the scrollbar appears in (the trailing side).
  TextDirection get textDirection => _textDirection;
  late TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (textDirection == value) {
      return;
    }

    _textDirection = value;
    notifyListeners();
  }

  /// Thickness of the scrollbar in its cross-axis in logical pixels.
  double get thickness => _thickness;
  double _thickness;
  set thickness(double value) {
    if (thickness == value) {
      return;
    }

    _thickness = value;
    notifyListeners();
  }

  /// An [Animation] that dictates the opacity of the thumb.
  final Animation<double> fadeoutOpacityAnimation;

  /// A [Animation] that dictates the color of the thumb.
  final Animation<double> thumbColorAnimation;

  /// Distance from the scrollbar's start and end to the edge of the viewport
  /// in logical pixels. It affects the amount of available paint area.
  final double mainAxisMargin;

  /// Distance from the scrollbar's side to the nearest edge in logical pixels.
  final double crossAxisMargin;

  /// The amount of space by which to inset the scrollbar's start and end, as
  /// well as its side to the nearest edge, in logical pixels.
  ///
  /// This is typically set to the current [MediaQueryData.padding] to avoid
  /// partial obstructions such as display notches. If you only want additional
  /// margins around the scrollbar, see [mainAxisMargin].
  ///
  /// Defaults to [EdgeInsets.zero]. Must not be null and offsets from all four
  /// directions must be greater than or equal to zero.
  EdgeInsets get padding => _padding;
  EdgeInsets _padding;
  set padding(EdgeInsets value) {
    if (padding == value) {
      return;
    }

    _padding = value;
    notifyListeners();
  }

  /// The preferred smallest size the scrollbar can shrink to when the total
  /// scrollable extent is large, the current visible viewport is small, and the
  /// viewport is not over scrolled.
  ///
  /// The size of the scrollbar may shrink to a smaller size than [minLength]
  /// to fit in the available paint area. E.g., when [minLength] is
  /// `double.infinity`, it will not be respected if [viewportDimension] and
  /// [mainAxisMargin] are finite.
  double get minLength => _minLength;
  double _minLength;
  set minLength(double value) {
    if (minLength == value) {
      return;
    }

    _minLength = value;
    notifyListeners();
  }

  /// The preferred smallest size the scrollbar can shrink to when viewport is
  /// over scrolled.
  ///
  /// When over scrolling, the size of the scrollbar may shrink to a smaller size
  /// than [minOverscrollLength] to fit in the available paint area. E.g., when
  /// [minOverscrollLength] is `double.infinity`, it will not be respected if
  /// the [viewportDimension] and [mainAxisMargin] are finite.
  double get minOverscrollLength => _minOverscrollLength;
  double _minOverscrollLength;
  set minOverscrollLength(double value) {
    if (minOverscrollLength == value) {
      return;
    }

    _minOverscrollLength = value;
    notifyListeners();
  }

  ScrollMetrics? _lastMetrics;
  AxisDirection? _lastAxisDirection;
  Rect? _thumbRect;
  Rect? _trackRect;

  /// Update with new [ScrollMetrics]. The scrollbar will show and redraw itself
  /// based on these new metrics.
  ///
  /// The scrollbar will remain on screen.
  void update(
    ScrollMetrics metrics,
    AxisDirection axisDirection,
  ) {
    _lastMetrics = metrics;
    _lastAxisDirection = axisDirection;
    notifyListeners();
  }

  /// Update and redraw with new scrollbar thickness.
  void updateThickness(double nextThickness) {
    thickness = nextThickness;
    notifyListeners();
  }

  Paint get _paint {
    final color = thumbColor.evaluate(thumbColorAnimation)!;
    return Paint()
      ..color =
          color.withOpacity(color.opacity * fadeoutOpacityAnimation.value);
  }

  Paint get _trackPaint {
    return Paint()..color = trackColor!;
  }

  void _paintThumbCrossAxis(Canvas canvas, Size size, double thumbOffset,
      double thumbExtent, AxisDirection direction) {
    final double x, y;
    final Size thumbSize, trackSize;
    final Offset trackOffset;

    switch (direction) {
      case AxisDirection.down:
        thumbSize = Size(thickness, thumbExtent);
        x = textDirection == TextDirection.rtl
            ? crossAxisMargin + padding.left
            : size.width - thickness - crossAxisMargin - padding.right;
        y = thumbOffset;

        trackSize = Size(thickness + 2 * crossAxisMargin, _trackExtent);
        trackOffset = Offset(x - crossAxisMargin, 0.0);
        break;
      case AxisDirection.up:
        thumbSize = Size(thickness, thumbExtent);
        x = textDirection == TextDirection.rtl
            ? crossAxisMargin + padding.left
            : size.width - thickness - crossAxisMargin - padding.right;
        y = thumbOffset;

        trackSize = Size(thickness + 2 * crossAxisMargin, _trackExtent);
        trackOffset = Offset(x - crossAxisMargin, 0.0);
        break;
      case AxisDirection.left:
        thumbSize = Size(thumbExtent, thickness);
        x = thumbOffset;
        y = size.height - thickness - crossAxisMargin - padding.bottom;

        trackSize = Size(_trackExtent, thickness + 2 * crossAxisMargin);
        trackOffset = Offset(0.0, y - crossAxisMargin);
        break;
      case AxisDirection.right:
        thumbSize = Size(thumbExtent, thickness);
        x = thumbOffset;
        y = size.height - thickness - crossAxisMargin - padding.bottom;

        trackSize = Size(_trackExtent, thickness + 2 * crossAxisMargin);
        trackOffset = Offset(0.0, y - crossAxisMargin);
        break;
    }

    _trackRect = trackOffset & trackSize;

    if (trackColor != null) {
      canvas.drawRect(_trackRect!, _trackPaint);
    }

    _thumbRect = Offset(x, y) & thumbSize;
    canvas.drawRect(_thumbRect!, _paint);
  }

  double _thumbExtent() {
    // Thumb extent reflects fraction of content visible, as long as this
    // isn't less than the absolute minimum size.
    // _totalContentExtent >= viewportDimension, so (_totalContentExtent - _mainAxisPadding) > 0
    final double fractionVisible = clampDouble(
        (_lastMetrics!.extentInside - _mainAxisPadding) /
            (_totalContentExtent - _mainAxisPadding),
        0.0,
        1.0);

    final double thumbExtent = math.max(
      math.min(_trackExtent, minOverscrollLength),
      _trackExtent * fractionVisible,
    );

    final double fractionOverscrolled =
        1.0 - _lastMetrics!.extentInside / _lastMetrics!.viewportDimension;
    final double safeMinLength = math.min(minLength, _trackExtent);
    final double newMinLength = (_beforeExtent > 0 && _afterExtent > 0)
        // Thumb extent is no smaller than minLength if scrolling normally.
        ? safeMinLength
        // User is over scrolling. Thumb extent can be less than minLength
        // but no smaller than minOverscrollLength. We can't use the
        // fractionVisible to produce intermediate values between minLength and
        // minOverscrollLength when the user is transitioning from regular
        // scrolling to over scrolling, so we instead use the percentage of the
        // content that is still in the viewport to determine the size of the
        // thumb. iOS behavior appears to have the thumb reach its minimum size
        // with ~20% of over scroll. We map the percentage of minLength from
        // [0.8, 1.0] to [0.0, 1.0], so 0% to 20% of over scroll will produce
        // values for the thumb that range between minLength and the smallest
        // possible value, minOverscrollLength.
        : safeMinLength *
            (1.0 - clampDouble(fractionOverscrolled, 0.0, 0.2) / 0.2);

    // The `thumbExtent` should be no greater than `trackSize`, otherwise
    // the scrollbar may scroll towards the wrong direction.
    return clampDouble(thumbExtent, newMinLength, _trackExtent);
  }

  @override
  void dispose() {
    fadeoutOpacityAnimation.removeListener(notifyListeners);
    thumbColorAnimation.removeListener(notifyListeners);
    super.dispose();
  }

  bool get _isVertical =>
      _lastAxisDirection! == AxisDirection.down ||
      _lastAxisDirection! == AxisDirection.up;
  bool get _isReversed =>
      _lastAxisDirection! == AxisDirection.up ||
      _lastAxisDirection! == AxisDirection.left;
  // The amount of scroll distance before and after the current position.
  double get _beforeExtent =>
      _isReversed ? _lastMetrics!.extentAfter : _lastMetrics!.extentBefore;
  double get _afterExtent =>
      _isReversed ? _lastMetrics!.extentBefore : _lastMetrics!.extentAfter;
  // Padding of the thumb track.
  double get _mainAxisPadding =>
      _isVertical ? padding.vertical : padding.horizontal;
  // The size of the thumb track.
  double get _trackExtent =>
      _lastMetrics!.viewportDimension - 2 * mainAxisMargin - _mainAxisPadding;

  // The total size of the scrollable content.
  double get _totalContentExtent {
    return _lastMetrics!.maxScrollExtent -
        _lastMetrics!.minScrollExtent +
        _lastMetrics!.viewportDimension;
  }

  /// Convert between a thumb track position and the corresponding scroll
  /// position.
  ///
  /// thumbOffsetLocal is a position in the thumb track. Cannot be null.
  double getTrackToScroll(double thumbOffsetLocal) {
    final double scrollableExtent =
        _lastMetrics!.maxScrollExtent - _lastMetrics!.minScrollExtent;
    final double thumbMovableExtent = _trackExtent - _thumbExtent();

    return scrollableExtent * thumbOffsetLocal / thumbMovableExtent;
  }

  // Converts between a scroll position and the corresponding position in the
  // thumb track.
  double _getScrollToTrack(ScrollMetrics metrics, double thumbExtent) {
    final double scrollableExtent =
        metrics.maxScrollExtent - metrics.minScrollExtent;

    final double fractionPast = (scrollableExtent > 0)
        ? clampDouble(
            (metrics.pixels - metrics.minScrollExtent) / scrollableExtent,
            0.0,
            1.0)
        : 0;

    return (_isReversed ? 1 - fractionPast : fractionPast) *
        (_trackExtent - thumbExtent);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_lastAxisDirection == null || _lastMetrics == null) {
      return;
    }

    // Skip painting if there's not enough space.
    if (_lastMetrics!.viewportDimension <= _mainAxisPadding ||
        _trackExtent <= 0) {
      return;
    }

    final double beforePadding = _isVertical ? padding.top : padding.left;
    final double thumbExtent = _thumbExtent();
    final double thumbOffsetLocal =
        _getScrollToTrack(_lastMetrics!, thumbExtent);
    _thumbOffset = thumbOffsetLocal + mainAxisMargin + beforePadding;

    if (_lastMetrics!.maxScrollExtent.isInfinite) {
      return;
    }

    return _paintThumbCrossAxis(
        canvas, size, _thumbOffset, thumbExtent, _lastAxisDirection!);
  }

  /// Same as hitTest, but includes some padding when the [PointerEvent] is
  /// caused by [PointerDeviceKind.touch] to make sure that the region
  /// isn't too small to be interacted with by the user.
  bool hitTestInteractive(Offset position, PointerDeviceKind kind) {
    if (_thumbRect == null) {
      return false;
    }
    // The scrollbar is not able to be hit when transparent.
    if (fadeoutOpacityAnimation.value == 0.0) {
      return false;
    }

    final Rect interactiveRect = _trackRect ?? _thumbRect!;
    switch (kind) {
      case PointerDeviceKind.touch:
        final Rect touchScrollbarRect = interactiveRect.expandToInclude(
          Rect.fromCircle(
              center: _thumbRect!.center, radius: _kMinInteractiveSize / 2),
        );
        return touchScrollbarRect.contains(position);
      case PointerDeviceKind.mouse:
      case PointerDeviceKind.stylus:
      case PointerDeviceKind.invertedStylus:
      case PointerDeviceKind.unknown:
      default:
        return interactiveRect.contains(position);
    }
  }

  /// Same as hitTestInteractive, but excludes the track portion of the scrollbar.
  /// Used to evaluate interactions with only the scrollbar thumb.
  bool hitTestOnlyThumbInteractive(Offset position, PointerDeviceKind kind) {
    if (_thumbRect == null) {
      return false;
    }
    // The thumb is not able to be hit when transparent.
    if (fadeoutOpacityAnimation.value == 0.0) {
      return false;
    }

    switch (kind) {
      case PointerDeviceKind.touch:
        final Rect touchThumbRect = _thumbRect!.expandToInclude(
          Rect.fromCircle(
              center: _thumbRect!.center, radius: _kMinInteractiveSize / 2),
        );
        return touchThumbRect.contains(position);
      case PointerDeviceKind.mouse:
      case PointerDeviceKind.stylus:
      case PointerDeviceKind.invertedStylus:
      case PointerDeviceKind.unknown:
      default:
        return _thumbRect!.contains(position);
    }
  }

  @override
  bool hitTest(Offset position) {
    if (_thumbRect == null) {
      return false;
    }
    if (fadeoutOpacityAnimation.value == 0.0) {
      return false;
    }
    return _thumbRect!.contains(position);
  }

  /// The thumb [Rect].
  Rect? get thumbRect {
    return _thumbRect;
  }

  @override
  bool shouldRepaint(DesktopScrollbarPainter old) {
    final should = thumbColor != old.thumbColor ||
        textDirection != old.textDirection ||
        thickness != old.thickness ||
        fadeoutOpacityAnimation != old.fadeoutOpacityAnimation ||
        mainAxisMargin != old.mainAxisMargin ||
        crossAxisMargin != old.crossAxisMargin ||
        minLength != old.minLength ||
        minOverscrollLength != old.minOverscrollLength ||
        padding != old.padding;

    return should;
  }

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;
}
