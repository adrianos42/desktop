import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// A linear [ProgressIndicator].
class LinearProgressIndicator extends StatefulWidget {
  /// Creates a [LinearProgressIndicator].
  const LinearProgressIndicator({
    super.key,
    this.value,
    this.theme,
  });

  final double? value;

  /// The theme [LinearProgressIndicatorThemeData] for the [LinearProgressIndicator].
  final LinearProgressIndicatorThemeData? theme;

  @override
  State<LinearProgressIndicator> createState() =>
      _LinearProgressIndicatorState();
}

class _LinearProgressIndicatorState extends State<LinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double currentWidth = 0.0;

  Widget _buildIndicator(BuildContext context, double animationValue) {
    final LinearProgressIndicatorThemeData linearProgressIndicatorThemeData =
        LinearProgressIndicatorTheme.of(context).merge(widget.theme);

    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: linearProgressIndicatorThemeData.height!,
        maxHeight: linearProgressIndicatorThemeData.height!,
      ),
      child: CustomPaint(
        painter: _LinearProgressIndicatorPainter(
          backgroundColor: widget.value != null
              ? linearProgressIndicatorThemeData.backgroundColor
              : null,
          valueColor: linearProgressIndicatorThemeData.color!,
          value: widget.value,
          animationValue: animationValue,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller.duration = LinearProgressIndicatorTheme.of(context)
        .merge(widget.theme)
        .indeterminateDuration!;

    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(LinearProgressIndicator oldWidget) {
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
      return _buildIndicator(context, _controller.value);
    }

    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
        animation: _controller.view,
        builder: (BuildContext context, Widget? child) {
          return _buildIndicator(context, _controller.value);
        },
      );
    });
  }
}

class _LinearProgressIndicatorPainter extends CustomPainter {
  const _LinearProgressIndicatorPainter({
    required this.valueColor,
    this.value,
    required this.animationValue,
    this.backgroundColor,
  });

  final Color? backgroundColor;
  final Color valueColor;
  final double? value;
  final double animationValue;

  static const Curve line1Head =
      Interval(0.0, 0.4, curve: Curves.fastOutSlowIn);

  static const Curve line1Tail = Interval(
    0.4,
    1.0,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    if (backgroundColor != null) {
      paint.color = backgroundColor!;
      canvas.drawRect(Offset.zero & size, paint);
    }

    paint.color = valueColor;

    void drawBar(double x, double width) {
      if (width <= 0.0) {
        return;
      }

      final double left = x;

      canvas.drawRect(Offset(left, 0.0) & Size(width, size.height), paint);
    }

    if (value != null) {
      drawBar(0.0, clampDouble(value!, 0.0, 1.0) * size.width); // TODO(as): ???
    } else {
      final double x1 = size.width * line1Tail.transform(animationValue);
      final double width1 =
          size.width * line1Head.transform(animationValue) - x1;

      drawBar(x1, width1);
    }
  }

  @override
  bool shouldRepaint(_LinearProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.animationValue != animationValue;
  }
}
