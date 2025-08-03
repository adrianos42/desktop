import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// A circular [ProgressIndicator].
class CircularProgressIndicator extends StatefulWidget {
  /// Creates a [CircularProgressIndicator].
  const CircularProgressIndicator({
    super.key,
    this.backgroundColor,
    this.color,
    this.indeterminateDuration,
    this.size,
    this.strokeWidth,
    this.value,
  });

  /// The progress value.
  final double? value;

  // The progress indicator's size.
  // Defaults to [CircularProgressIndicatorThemeData.size].
  final double? size;

  // The progress indicator's color.
  // Defaults to [CircularProgressIndicatorThemeData.color].
  final Color? color;

  // The progress indicator's background color.
  // Defaults to [CircularProgressIndicatorThemeData.backgroundColor].
  final Color? backgroundColor;

  // The progress indicator's indeterminateDuration.
  // Defaults to [CircularProgressIndicatorThemeData.indeterminateDuration].
  final Duration? indeterminateDuration;

  // The progress indicator's stroke width.
  // Defaults to [CircularProgressIndicatorThemeData.strokeWidth].
  final double? strokeWidth;

  @override
  State<CircularProgressIndicator> createState() =>
      _CircularProgressIndicatorState();
}

class _CircularProgressIndicatorState extends State<CircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  Widget _buildIndicator(BuildContext context, double headValue) {
    final CircularProgressIndicatorThemeData themeData =
        CircularProgressIndicatorTheme.of(context);

    return SizedBox(
      width: widget.size ?? themeData.size,
      height: widget.size ?? themeData.size,
      child: CustomPaint(
        painter: _CircularProgressIndicatorPainter(
          valueColor: widget.color ?? themeData.color!,
          backgroundColor: widget.value != null
              ? widget.backgroundColor ?? themeData.backgroundColor!
              : null,
          value: widget.value, // may be null
          headValue:
              headValue, // remaining arguments are ignored if widget.value is not null
          strokeWidth: widget.strokeWidth ?? themeData.strokeWidth!,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _animation = CurvedAnimation(
      curve: const Interval(0.0, 1.0, curve: Curves.linear),
      parent: _controller,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller.duration =
        widget.indeterminateDuration ??
        CircularProgressIndicatorTheme.of(context).indeterminateDuration!;

    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(CircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }

    if (widget.indeterminateDuration != oldWidget.indeterminateDuration) {
      _controller.duration =
          widget.indeterminateDuration ??
          CircularProgressIndicatorTheme.of(context).indeterminateDuration!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      return _buildIndicator(context, 0.0);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return _buildIndicator(context, _animation.value);
      },
    );
  }
}

class _CircularProgressIndicatorPainter extends CustomPainter {
  _CircularProgressIndicatorPainter({
    this.backgroundColor,
    required this.valueColor,
    this.value,
    required this.headValue,
    required this.strokeWidth,
  }) : arcStart = _startAngle,
       arcSweep = value != null
           ? clampDouble(value, 0.0, 1.0) * _sweep
           : _twoPi;

  final Color? backgroundColor;
  final Color valueColor;
  final double? value;
  final double headValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;

  static const double _twoPi = math.pi * 2.0;
  static const double _sweep = _twoPi;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, 0, _sweep, false, backgroundPaint);
    }

    if (value == null) {
      paint.shader = ui.Gradient.sweep(
        Offset(size.width / 2.0, size.height / 2.0),
        [Colors.black, valueColor],
        [0.0, 1.0],
        TileMode.repeated,
        headValue * _sweep,
        _twoPi + headValue * _sweep,
      );
    }

    canvas.drawArc(Offset.zero & size, arcStart, arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(_CircularProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.headValue != headValue ||
        oldPainter.strokeWidth != strokeWidth;
  }
}
