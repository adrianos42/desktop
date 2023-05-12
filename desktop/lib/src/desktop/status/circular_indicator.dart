import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// A circular [ProgressIndicator].
class CircularProgressIndicator extends StatefulWidget {
  /// Creates a [CircularProgressIndicator].
  const CircularProgressIndicator({
    super.key,
    this.theme,
    this.value,
  });

  /// The progress value.
  final double? value;

  /// The theme [CircularProgressIndicatorThemeData] for the [CircularProgressIndicator].
  final CircularProgressIndicatorThemeData? theme;

  @override
  State<CircularProgressIndicator> createState() =>
      _CircularProgressIndicatorState();
}

final Animatable<double> _kStrokeHeadTween = CurveTween(
  curve: const Interval(0.0, 0.4, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

final Animatable<double> _kStrokeTailTween = CurveTween(
  curve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

final Animatable<int> _kStepTween = StepTween(begin: 0, end: 5);

final Animatable<double> _kRotationTween = CurveTween(curve: const SawTooth(5));

class _CircularProgressIndicatorState extends State<CircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Widget _buildIndicator(BuildContext context, double headValue,
      double tailValue, int stepValue, double rotationValue) {
    final CircularProgressIndicatorThemeData
        circularProgressIndicatorThemeData =
        CircularProgressIndicatorTheme.of(context).merge(widget.theme);

    return SizedBox(
      width: circularProgressIndicatorThemeData.size,
      height: circularProgressIndicatorThemeData.size,
      child: CustomPaint(
        painter: _CircularProgressIndicatorPainter(
          valueColor: circularProgressIndicatorThemeData.color!,
          backgroundColor: widget.value != null
              ? circularProgressIndicatorThemeData.backgroundColor!
              : null,
          value: widget.value, // may be null
          headValue:
              headValue, // remaining arguments are ignored if widget.value is not null
          tailValue: tailValue,
          stepValue: stepValue,
          rotationValue: rotationValue,
          strokeWidth:
              (circularProgressIndicatorThemeData.size! / 10.0).roundToDouble(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller.duration = CircularProgressIndicatorTheme.of(context)
        .merge(widget.theme)
        .indeterminateDuration!;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      return _buildIndicator(context, 0.0, 0.0, 0, 0.0);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return _buildIndicator(
          context,
          _kStrokeHeadTween.evaluate(_controller),
          _kStrokeTailTween.evaluate(_controller),
          _kStepTween.evaluate(_controller),
          _kRotationTween.evaluate(_controller),
        );
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
    required this.tailValue,
    required this.stepValue,
    required this.rotationValue,
    required this.strokeWidth,
  })  : arcStart = value != null
            ? _startAngle
            : _startAngle +
                tailValue * 3 / 2 * math.pi +
                rotationValue * math.pi * 1.7 -
                stepValue * 0.8 * math.pi,
        arcSweep = value != null
            ? clampDouble(value, 0.0, 1.0) * _sweep
            : math.max(
                headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi,
                _epsilon);

  final Color? backgroundColor;
  final Color valueColor;
  final double? value;
  final double headValue;
  final double tailValue;
  final int stepValue;
  final double rotationValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, 0, _sweep, false, backgroundPaint);
    }

    if (value == null) {
      paint.strokeCap = StrokeCap.square;
    }

    canvas.drawArc(Offset.zero & size, arcStart, arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(_CircularProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.headValue != headValue ||
        oldPainter.tailValue != tailValue ||
        oldPainter.stepValue != stepValue ||
        oldPainter.rotationValue != rotationValue ||
        oldPainter.strokeWidth != strokeWidth;
  }
}
