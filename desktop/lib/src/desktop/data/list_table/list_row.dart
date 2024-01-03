import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// The row in a [ListTable].
class ListRow extends MultiChildRenderObjectWidget {
  /// Creates a [ListRow].
  const ListRow({
    super.key,
    super.children,
    this.decoration,
    this.backgroundColor,
    required this.bottomBorder,
    required this.itemExtent,
    required this.colSizes,
  });

  /// Border rendered at the bottom when the table border has `horizontalInside` border.
  final BorderSide bottomBorder;

  /// Column widths.
  final List<double> colSizes;

  /// The height of the item.
  final double? itemExtent;

  /// The row [Decoration].
  final Decoration? decoration;

  /// Background color.
  final Color? backgroundColor;

  @override
  ListRowRender createRenderObject(BuildContext context) {
    return ListRowRender(
      columnWidths: colSizes,
      columns: children.length,
      itemExtent: itemExtent,
      bottomBorder: bottomBorder,
      decoration: decoration,
      configuration: createLocalImageConfiguration(context),
      backgroundColor: backgroundColor,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant ListRowRender renderObject) {
    renderObject
      ..columnWidths = colSizes
      ..itemExtent = itemExtent
      ..bottomBorder = bottomBorder
      ..decoration = decoration
      ..configuration = createLocalImageConfiguration(context)
      ..backgroundColor = backgroundColor;
  }
}

class _ListRowParentData extends ContainerBoxParentData<RenderBox> {}

///
class ListRowRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ListRowParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ListRowParentData> {
  ///
  ListRowRender({
    int? columns,
    required List<double> columnWidths,
    required BorderSide bottomBorder,
    Color? backgroundColor,
    Decoration? decoration,
    ImageConfiguration configuration = ImageConfiguration.empty,
    List<RenderBox>? children,
    required double? itemExtent,
  })  : assert(columns == null || columns >= 0),
        _itemExtent = itemExtent,
        _columnWidths = columnWidths,
        _bottomBorder = bottomBorder,
        _configuration = configuration,
        _decoration = decoration,
        _backgroundColor = backgroundColor {
    addAll(children);
  }

  List<double> get columnWidths => List<double>.unmodifiable(_columnWidths);
  List<double> _columnWidths;
  set columnWidths(List<double> value) {
    if (_columnWidths != value && _columnWidths.isNotEmpty) {
      _columnWidths = value;
      markNeedsLayout();
    }
  }

  ///
  Color? get backgroundColor => _backgroundColor;
  Color? _backgroundColor;
  set backgroundColor(Color? value) {
    if (_backgroundColor != value) {
      _backgroundColor = value;
      markNeedsPaint();
    }
  }

  ///
  double? get itemExtent => _itemExtent;
  double? _itemExtent;
  set itemExtent(double? value) {
    if (_itemExtent != value) {
      _itemExtent = value;
      markNeedsLayout();
    }
  }

  BorderSide get bottomBorder => _bottomBorder;
  BorderSide _bottomBorder;
  set bottomBorder(BorderSide value) {
    if (bottomBorder != value) {
      _bottomBorder = value;
      markNeedsPaint();
    }
  }

  Decoration? get decoration => _decoration;
  Decoration? _decoration;
  BoxPainter? _rowDecorationPainter;
  set decoration(Decoration? value) {
    if (_decoration != value) {
      _decoration = value;
      _rowDecorationPainter?.dispose();
      _rowDecorationPainter = null;
      markNeedsPaint();
    }
  }

  ImageConfiguration get configuration => _configuration;
  ImageConfiguration _configuration;
  set configuration(ImageConfiguration value) {
    if (value != _configuration) {
      _configuration = value;
      markNeedsPaint();
    }
  }

  late double _tableWidth;

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _ListRowParentData) {
      child.parentData = _ListRowParentData();
    }
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      // _dragGesture.addPointer(event);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (_columnWidths.isEmpty) {
      return constraints.constrain(Size.zero);
    }
    final List<double> widths = _columnWidths;
    final double tableWidth = widths.fold(0.0, (double a, double b) => a + b);

    double height = _itemExtent ?? 0.0;

    int x = 0;

    if (_itemExtent == null) {
      RenderBox? child = firstChild;

      while (child != null) {
        height = math.max(
          height,
          child
              .getDryLayout(
                BoxConstraints.tightFor(
                  width: _columnWidths[x],
                ),
              )
              .height,
        );

        child = childAfter(child);
      }

      x += 1;
    }

    return constraints.constrain(Size(tableWidth, height));
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    RenderBox? child = firstChild;

    double height = _itemExtent ?? 0.0;

    if (_columnWidths.isEmpty) {
      _tableWidth = 0.0;
      size = constraints.constrain(Size.zero);
      return;
    }

    final List<double> positions =
        List<double>.filled(_columnWidths.length, 0.0);

    positions[0] = 0.0;
    for (int x = 1; x < _columnWidths.length; x += 1) {
      positions[x] = positions[x - 1] + _columnWidths[x - 1];
    }

    _tableWidth = positions.last + _columnWidths.last;

    int x = 0;

    while (child != null) {
      child.layout(
        BoxConstraints.tightFor(
          width: _columnWidths[x],
          height: _itemExtent,
        ),
        parentUsesSize: true,
      );

      if (_itemExtent == null) {
        height = math.max(height, child.size.height);
      }

      (child.parentData! as _ListRowParentData).offset =
          Offset(positions[x], 0.0);

      child = childAfter(child);
      x += 1;
    }

    size = constraints.constrain(Size(_tableWidth, height));
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _columnWidths.fold(0.0, (double a, double b) => a + b);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _columnWidths.fold(0.0, (double a, double b) => a + b);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    RenderBox? child = firstChild;

    double height = _itemExtent ?? 0.0;

    int x = 0;

    while (child != null) {
      height = math.max(height, child.getMaxIntrinsicHeight(_columnWidths[x]));

      child = childAfter(child);
      x += 1;
    }

    return height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMinIntrinsicHeight(width);
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToFirstActualBaseline(baseline);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (backgroundColor != null) {
      final paint = Paint()..color = backgroundColor!;
      context.canvas.drawRect(
          Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height), paint);
    }

    if (_decoration != null) {
      _rowDecorationPainter ??= _decoration!.createBoxPainter(markNeedsPaint);
      _rowDecorationPainter!.paint(
        context.canvas,
        Offset(offset.dx, offset.dy),
        configuration.copyWith(size: Size(size.width, size.height)),
      );
    }

    RenderBox? child = firstChild;
    
    while (child != null) {
      final _ListRowParentData childParentData =
          child.parentData! as _ListRowParentData;
      context.paintChild(child, childParentData.offset + offset);
      
      child = childAfter(child);
    }

    if (bottomBorder.style == BorderStyle.solid) {
      final Paint paint = Paint()
        ..strokeWidth = 0.0
        ..isAntiAlias = bottomBorder.width == 0.0;
      final Path path = Path();
      final rect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);

      paint.color = bottomBorder.color;
      path.reset();
      path.moveTo(rect.right, rect.bottom);
      path.lineTo(rect.left, rect.bottom);

      if (bottomBorder.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;

        path.lineTo(
          rect.left,
          rect.bottom - bottomBorder.width,
        );
        path.lineTo(
          rect.right,
          rect.bottom - bottomBorder.width,
        );
      }
      
      context.canvas.drawPath(path, paint);
    }
  }
}
