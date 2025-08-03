import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// A linear [ProgressIndicator].
class LinearProgressIndicator extends StatefulWidget {
  /// Creates a [LinearProgressIndicator].
  const LinearProgressIndicator({
    super.key,
    this.value,
    this.backgroundColor,
    this.color,
    this.height,
    this.indeterminateDuration,
    this.padding,
  });

  final double? value;

  // The indicator's height.
  // Defaults to [LinearProgressIndicatorThemeData.height].
  final double? height;

  // The progress indicator's color.
  // Defaults to [LinearProgressIndicatorThemeData.color].
  final Color? color;

  // The progress indicator's backgroundColor.
  // Defaults to [LinearProgressIndicatorThemeData.backgroundColor].
  final Color? backgroundColor;

  // The progress indicator's indeterminateDuration.
  // Defaults to [LinearProgressIndicatorThemeData.indeterminateDuration].
  final Duration? indeterminateDuration;

  // The progress indicator's padding.
  // Defaults to [LinearProgressIndicatorThemeData.padding].
  final EdgeInsets? padding;

  @override
  State<LinearProgressIndicator> createState() =>
      _LinearProgressIndicatorState();
}

class _LinearProgressIndicatorState extends State<LinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double currentWidth = 0.0;

  Widget _buildIndicator(BuildContext context, double animationValue) {
    final LinearProgressIndicatorThemeData themeData =
        LinearProgressIndicatorTheme.of(context);

    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: widget.height ?? themeData.height!,
        maxHeight: widget.height ?? themeData.height!,
      ),
      margin: widget.padding ?? themeData.padding!,
      child: CustomPaint(
        painter: _LinearProgressIndicatorPainter(
          backgroundColor: widget.value != null
              ? widget.backgroundColor ?? themeData.backgroundColor
              : null,
          valueColor: widget.color ?? themeData.color!,
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

    _controller.duration =
        widget.indeterminateDuration ??
        LinearProgressIndicatorTheme.of(context).indeterminateDuration!;

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

    if (widget.indeterminateDuration != oldWidget.indeterminateDuration) {
      _controller.duration =
          widget.indeterminateDuration ??
          LinearProgressIndicatorTheme.of(context).indeterminateDuration!;
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

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _controller.view,
          builder: (BuildContext context, Widget? child) {
            return _buildIndicator(context, _controller.value);
          },
        );
      },
    );
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

  static const Curve line1Head = Interval(
    0.0,
    0.4,
    curve: Curves.fastOutSlowIn,
  );

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

    void drawBar(double x, double width) {
      if (width <= 0.0) {
        return;
      }

      final double left = x;

      canvas.drawRect(Offset(left, 0.0) & Size(width, size.height), paint);
    }

    if (value != null) {
      paint.color = valueColor;
      drawBar(0.0, clampDouble(value!, 0.0, 1.0) * size.width); // TODO(as): ???
    } else {
      final double x1 = size.width * line1Tail.transform(animationValue);
      final double width1 =
          size.width * line1Head.transform(animationValue) - x1;

      paint.shader = ui.Gradient.linear(
        Offset(x1, 0.0),
        Offset(x1 + width1, size.height),
        [Colors.black, valueColor],
        [0.0, 0.5],
      );

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
