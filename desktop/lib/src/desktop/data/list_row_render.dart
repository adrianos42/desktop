import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

class ListRowParentData extends ContainerBoxParentData<RenderBox> {}

///
class ListRowRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ListRowParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, ListRowParentData> {
  ///
  ListRowRender({
    int? columns,
    required List<double> columnWidths,
    TableBorder? border,
    Decoration? rowDecoration,
    ImageConfiguration configuration = ImageConfiguration.empty,
    List<RenderBox>? children,
    required double itemExtend,
  })  : assert(columns == null || columns >= 0),
        _itemExtend = itemExtend,
        _columnWidths = columnWidths,
        _border = border,
        _configuration = configuration,
        _rowDecoration = rowDecoration {
    addAll(children);
  }

  /// How the horizontal extents of the _columns of this table should be determined.
  ///
  /// If the [Map] has a null entry for a given column, the table uses the
  /// [defaultColumnWidth] instead.
  ///
  /// The layout performance of the table depends critically on which column
  /// sizing algorithms are used here. In particular, [IntrinsicColumnWidth] is
  /// quite expensive because it needs to measure each cell in the column to
  /// determine the intrinsic size of the column.
  ///
  /// This property can never return null. If it is set to null, and the existing
  /// map is not empty, then the value is replaced by an empty map. (If it is set
  /// to null while the current value is an empty map, the value is not changed.)
  List<double> get columnWidths => List<double>.unmodifiable(_columnWidths);
  List<double> _columnWidths;
  set columnWidths(List<double> value) {
    if (_columnWidths == value) {
      return;
    }
    if (_columnWidths.isEmpty) {
      return;
    }
    _columnWidths = value;
    markNeedsLayout();
  }

  ///
  double get itemExtend => _itemExtend;
  double _itemExtend;
  set itemExtend(double value) {
    if (_itemExtend == value) {
      return;
    }
    _itemExtend = value;
    markNeedsLayout();
  }

  TableBorder? get border => _border;
  TableBorder? _border;
  set border(TableBorder? value) {
    if (border == value) {
      return;
    }
    _border = value;
    markNeedsPaint();
  }

  Decoration? get rowDecoration => _rowDecoration;
  Decoration? _rowDecoration;
  BoxPainter? _rowDecorationPainter;
  set rowDecoration(Decoration? value) {
    if (_rowDecoration == value) {
      return;
    }
    _rowDecoration = value;
    _rowDecorationPainter?.dispose();
    _rowDecorationPainter = null;
  }

  /// The settings to pass to the [rowDecoration] when painting, so that they
  /// can resolve images appropriately. See [ImageProvider.resolve] and
  /// [BoxPainter.paint].
  ImageConfiguration get configuration => _configuration;
  ImageConfiguration _configuration;
  set configuration(ImageConfiguration value) {
    if (value == _configuration) {
      return;
    }
    _configuration = value;
    markNeedsPaint();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! ListRowParentData) {
      child.parentData = ListRowParentData();
    }
  }

  @override
  bool hitTestSelf(Offset position) => true;

  // @override
  // double computeMinIntrinsicWidth(double height) {
  //   assert(_children.length == _columns);
  //   double totalMinWidth = 0.0;
  //   for (int x = 0; x < _columns; x += 1) {
  //     final TableColumnWidth columnWidth = _columnWidths[x]!;
  //     final Iterable<RenderBox> columnCells = column(x);
  //     totalMinWidth +=
  //         columnWidth.minIntrinsicWidth(columnCells, double.infinity);
  //   }
  //   return totalMinWidth;
  // }

  // @override
  // double computeMaxIntrinsicWidth(double height) {
  //   assert(_children.length == _columns);
  //   double totalMaxWidth = 0.0;
  //   for (int x = 0; x < _columns; x += 1) {
  //     final TableColumnWidth columnWidth = _columnWidths[x]!;
  //     final Iterable<RenderBox> columnCells = column(x);
  //     totalMaxWidth +=
  //         columnWidth.maxIntrinsicWidth(columnCells, double.infinity);
  //   }
  //   return totalMaxWidth;
  // }

  // @override
  // double computeMinIntrinsicHeight(double width) {
  //   return width;
  // }

  // @override
  // double computeMaxIntrinsicHeight(double width) {
  //   return computeMinIntrinsicHeight(width);
  // }

  late double _tableWidth;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (_columnWidths.isEmpty) {
      return constraints.constrain(Size.zero);
    }
    final List<double> widths = _columnWidths;
    final double tableWidth = widths.fold(0.0, (double a, double b) => a + b);
    return constraints.constrain(Size(tableWidth, _itemExtend));
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    RenderBox? child = firstChild;

    if (_columnWidths.isEmpty) {
      _tableWidth = 0.0;
      size = constraints.constrain(Size.zero);
      return;
    }

    final List<double> widths = _columnWidths;
    final List<double> positions =
        List<double>.filled(_columnWidths.length, 0.0);

    positions[0] = 0.0;
    for (int x = 1; x < _columnWidths.length; x += 1) {
      positions[x] = positions[x - 1] + widths[x - 1];
    }

    _tableWidth = positions.last + widths.last;

    int x = 0;

    while (child != null) {
      final ListRowParentData childParentData =
          child.parentData! as ListRowParentData;

      child.layout(
          BoxConstraints.tightFor(width: widths[x], height: itemExtend));
      childParentData.offset = Offset(positions[x], 0.0);

      child = childParentData.nextSibling;
      x += 1;
    }

    size = constraints.constrain(Size(_tableWidth, itemExtend));
  }

  // @override
  // bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
  //   assert(_children.length == _columns);
  //   for (int index = _children.length - 1; index >= 0; index -= 1) {
  //     final RenderBox? child = _children[index];
  //     if (child != null) {
  //       final BoxParentData childParentData =
  //           child.parentData! as BoxParentData;
  //       final bool isHit = result.addWithPaintOffset(
  //         offset: childParentData.offset,
  //         position: position,
  //         hitTest: (BoxHitTestResult result, Offset transformed) {
  //           assert(transformed == position - childParentData.offset);
  //           return child.hitTest(result, position: transformed);
  //         },
  //       );
  //       if (isHit) {
  //         return true;
  //       }
  //     }
  //   }
  //   return false;
  // }

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
    return itemExtend;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return itemExtend;
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
    if (_rowDecoration != null) {
      final Canvas canvas = context.canvas;

      _rowDecorationPainter ??=
          _rowDecoration!.createBoxPainter(markNeedsPaint);
      _rowDecorationPainter!.paint(
        canvas,
        Offset(offset.dx, offset.dy),
        configuration.copyWith(size: Size(size.width, itemExtend)),
      );
    }

    RenderBox? child = firstChild;
    while (child != null) {
      final ListRowParentData childParentData =
          child.parentData! as ListRowParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childParentData.nextSibling;
    }
  }
}
