import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const _kHandlerWidth = 12.0;
const _defaultIncrementHighlightWidth = 1.0;
const _defaultIncrementDraggingWidth = 1.0;

class _ListTableParentData extends ContainerBoxParentData<RenderBox> {}

///
class ListTableRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ListTableParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ListTableParentData>
    implements MouseTrackerAnnotation {
  ///
  ListTableRender({
    required BorderSide headerColumnBorder,
    required TableBorder tableBorder,
    required List<double> columnWidths,
    required double headerExtent,
    required Color highlightColor,
    required Color hoverColor,
    required this.dragStart,
    required this.dragUpdate,
    required this.dragEnd,
    required this.dragCancel,
    required int draggingColumnTargetItemIndex,
    required bool isDraggingColumn,
    int? rowCount,
    int? targetCount,
    List<RenderBox>? children,
  })  : _headerColumnBorder = headerColumnBorder,
        _tableBorder = tableBorder,
        _columnWidths = columnWidths,
        _headerExtent = headerExtent,
        _columns = _generateColumns(columnWidths),
        _highlightColor = highlightColor,
        _hoverColor = hoverColor,
        _hasHiddenColumns = columnWidths.any((elem) => elem == 0.0),
        _draggingColumnTargetItemIndex = draggingColumnTargetItemIndex,
        _isDraggingColumn = isDraggingColumn,
        _rowCount = rowCount,
        _targetCount = targetCount {
    addAll(children);
  }

  static List<double> _generateColumns(List<double> values) {
    final List<double> nonZeroColumns =
        values.where((elem) => elem > 0.0).toList();

    if (values.any((elem) => elem == 0.0)) {
      nonZeroColumns.add(0.0);
    }

    return nonZeroColumns.length > 1
        ? List.generate(nonZeroColumns.length - 1, (index) {
            return nonZeroColumns
                .sublist(0, index + 1)
                .fold(0.0, (p, e) => p + e);
          })
        : [];
  }

  ///
  final void Function(int col) dragStart;

  ///
  final void Function(int col, double value) dragUpdate;

  ///
  final void Function() dragEnd;

  ///
  final void Function() dragCancel;

  int _draggingColumnTargetItemIndex;
  int get draggingColumnTargetItemIndex => _draggingColumnTargetItemIndex;
  set draggingColumnTargetItemIndex(int value) {
    if (value != _draggingColumnTargetItemIndex) {
      _draggingColumnTargetItemIndex = value;
      markNeedsPaint();
    }
  }

  bool _isDraggingColumn;
  bool get isDraggingColumn => _isDraggingColumn;
  set isDraggingColumn(bool value) {
    if (value != _isDraggingColumn) {
      _isDraggingColumn = value;
      markNeedsPaint();
    }
  }

  Color _hoverColor;
  Color get hoverColor => _hoverColor;
  set hoverColor(Color value) {
    if (value != _hoverColor) {
      _hoverColor = value;
      markNeedsPaint();
    }
  }

  Color _highlightColor;
  Color get highlightColor => _highlightColor;
  set highlightColor(Color value) {
    if (value != _highlightColor) {
      _highlightColor = value;
      markNeedsPaint();
    }
  }

  BorderSide _headerColumnBorder;
  BorderSide get headerColumnBorder => _headerColumnBorder;
  set headerColumnBorder(BorderSide value) {
    if (value != _headerColumnBorder) {
      _headerColumnBorder = value;
      markNeedsPaint();
    }
  }

  TableBorder _tableBorder;
  TableBorder get tableBorder => _tableBorder;
  set tableBorder(TableBorder value) {
    if (value != _tableBorder) {
      _tableBorder = value;
      markNeedsPaint();
    }
  }

  double _headerExtent;
  double get headerExtent => _headerExtent;
  set headerExtent(double value) {
    if (value != _headerExtent) {
      _headerExtent = value;
      markNeedsPaint();
    }
  }

  List<double> _columnWidths;
  List<double> get columnWidths => _columnWidths;
  set columnWidths(List<double> value) {
    if (value != _columnWidths) {
      _columnWidths = value;

      _columns = ListTableRender._generateColumns(_columnWidths);
      _hasHiddenColumns = _columnWidths.any((elem) => elem == 0.0);

      markNeedsLayout();
    }
  }

  int? _rowCount;
  int? get rowCount => _rowCount;
  set rowCount(int? value) {
    if (value != _rowCount) {
      _rowCount = value;

      markNeedsLayout();
    }
  }

  int? _targetCount;
  int? get targetCount => _rowCount;
  set targetCount(int? value) {
    if (value != _targetCount) {
      _targetCount = value;

      markNeedsLayout();
    }
  }

  double _headerHeight = 0.0;
  double get _effectiveHeaderExtent {
    return _rowCount != null && _targetCount != null
        ? _headerHeight
        : _headerExtent;
  }

  bool get _isInteractive => !_isDraggingColumn;

  List<double> _columns;

  late HorizontalDragGestureRecognizer _dragGesture;

  bool _hasHiddenColumns = false;

  int _columnHoverIndex = -1;
  int _draggingIndex = -1;
  double _currentPosition = 0.0;

  int _indexOfColumn(Offset localPosition) {
    return _columns
        .map((column) => Rect.fromLTWH(
              column - _kHandlerWidth,
              0.0,
              _kHandlerWidth * 2,
              _effectiveHeaderExtent,
            ))
        .toList()
        .indexWhere((e) => e.contains(localPosition));
  }

  void _handleMouseEnter(PointerEnterEvent event) {
    _columnHoverIndex = _indexOfColumn(event.localPosition);
    markNeedsPaint();
  }

  void _handleMouseExit(PointerExitEvent event) {
    _columnHoverIndex = -1;
    markNeedsPaint();
  }

  void _handleDragStart(DragStartDetails details) {
    dragStart(_draggingIndex);
    _currentPosition = details.globalPosition.dx;
  }

  void _handleDragDown(DragDownDetails details) {
    _draggingIndex = _indexOfColumn(details.localPosition);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_draggingIndex >= 0) {
      dragUpdate(_draggingIndex, details.globalPosition.dx - _currentPosition);
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_draggingIndex >= 0) {
      _draggingIndex = -1;
      dragEnd();
    }
  }

  void _handleDragCancel() {
    _draggingIndex = -1;
    dragCancel();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _ListTableParentData) {
      child.parentData = _ListTableParentData();
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _dragGesture = HorizontalDragGestureRecognizer(debugOwner: this)
      ..dragStartBehavior = DragStartBehavior.down
      ..onStart = _handleDragStart
      ..onDown = _handleDragDown
      ..onUpdate = _handleDragUpdate
      ..onCancel = _handleDragCancel
      ..onEnd = _handleDragEnd;
  }

  @override
  void detach() {
    _dragGesture.dispose();
    super.detach();
  }

  @override
  bool get sizedByParent => false;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    double height;

    if (constraints.maxHeight.isFinite) {
      height = constraints.maxHeight;
    } else if (_rowCount != null && _targetCount != null) {
      height = 0.0;
      int y = 0;

      RenderBox? child = firstChild;

      while (child != null && y < _rowCount!) {
        height += child
            .getDryLayout(
              BoxConstraints.tightFor(
                width: constraints.maxWidth,
              ),
            )
            .height;

        child = childAfter(child);
      }

      y += 1;
    } else {
      height = constraints.minHeight;
    }

    return constraints.constrain(Size(constraints.maxWidth, height));
  }

  @override
  void performLayout() {
    final List<double> nonZeroColumns =
        _columnWidths.where((elem) => elem > 0.0).toList();

    RenderBox? child = firstChild;
    double height;

    if (constraints.maxHeight.isFinite) {
      height = constraints.maxHeight;
    } else if (_rowCount != null && _targetCount != null) {
      int y = 0;
      height = 0.0;

      while (child != null && y < _rowCount!) {
        child.layout(
          BoxConstraints.tightFor(width: constraints.maxWidth),
          parentUsesSize: true,
        );

        (child.parentData! as _ListTableParentData).offset =
            Offset(0.0, height);

        if (y == 0) {
          _headerHeight = child.size.height;
        }

        height += child.size.height;

        child = childAfter(child);
        y += 1;
      }
    } else {
      height = constraints.minHeight;
    }

    final effectiveChildCount = _targetCount ?? childCount;

    if (nonZeroColumns.isNotEmpty && effectiveChildCount > 0) {
      final List<double> targetWidths =
          List<double>.filled(effectiveChildCount, 0.0);

      targetWidths[0] = nonZeroColumns[0] / 2.0;

      for (int i = 1; i < nonZeroColumns.length; i += 1) {
        targetWidths[i] = nonZeroColumns[i - 1] / 2.0 + nonZeroColumns[i] / 2.0;
      }

      targetWidths[targetWidths.length - 1] =
          nonZeroColumns[nonZeroColumns.length - 1] / 2.0;

      final List<double> positions =
          List<double>.filled(targetWidths.length, 0.0);

      for (int x = 1; x < targetWidths.length; x += 1) {
        positions[x] = positions[x - 1] + targetWidths[x - 1];
      }

      int x = 0;

      while (child != null) {
        child.layout(BoxConstraints.tightFor(
          width: targetWidths[x],
          height: height,
        ));

        (child.parentData! as _ListTableParentData).offset =
            Offset(positions[x], 0.0);

        child = childAfter(child);
        x += 1;
      }
    }

    size = Size(constraints.maxWidth, height);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    RenderBox? child = firstChild;

    final List<RenderBox> rows = [];

    if (_rowCount != null && _targetCount != null) {
      int y = 0;

      while (child != null && y < _rowCount!) {
        rows.add(child);
        child = childAfter(child);
        y += 1;
      }
    }

    if (_isInteractive && rows.isNotEmpty && _indexOfColumn(position) == -1) {
      for (final child in rows) {
        final childParentData = child.parentData! as _ListTableParentData;

        final bool isHit = result.addWithPaintOffset(
          offset: childParentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset transformed) {
            assert(transformed == position - childParentData.offset);
            return child.hitTest(result, position: transformed);
          },
        );

        if (isHit) {
          break;
        }
      }
    } else if (!_isInteractive) {
      while (child != null) {
        final childParentData = child.parentData! as _ListTableParentData;

        final bool isHit = result.addWithPaintOffset(
          offset: childParentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset transformed) {
            assert(transformed == position - childParentData.offset);
            return child!.hitTest(result, position: transformed);
          },
        );
        if (isHit) {
          return true;
        }

        child = childAfter(child);
      }
    }

    return false;
  }

  @override
  bool hitTestSelf(Offset position) {
    return _isInteractive && _indexOfColumn(position) != -1;
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && _isInteractive) {
      _dragGesture.addPointer(event);
    }
  }

  @override
  MouseCursor get cursor =>
      _isInteractive ? SystemMouseCursors.resizeColumn : MouseCursor.defer;

  @override
  PointerEnterEventListener? get onEnter => _handleMouseEnter;

  @override
  PointerExitEventListener? get onExit => _handleMouseExit;

  @override
  bool get validForMouseTracker => true;

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isEnabled = _isInteractive;
  }

  ///
  static void paintStaticTableBorder(
    Canvas canvas,
    Offset offset,
    Size size,
    TableBorder tableBorder,
  ) {
    final Paint paint = Paint()..strokeWidth = 0.0;
    final Path path = Path();

    final rect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);

    if (tableBorder.top.style == BorderStyle.solid) {
      paint.color = tableBorder.top.color;
      paint.isAntiAlias = tableBorder.top.width == 0;
      path.reset();
      path.moveTo(rect.left, rect.top);
      path.lineTo(rect.right, rect.top);
      if (tableBorder.top.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;

        path.lineTo(
          rect.right - tableBorder.right.width,
          rect.top + tableBorder.top.width,
        );
        path.lineTo(
          rect.left + tableBorder.left.width,
          rect.top + tableBorder.top.width,
        );
      }
      canvas.drawPath(path, paint);
    }

    if (tableBorder.right.style == BorderStyle.solid) {
      paint.color = tableBorder.right.color;
      paint.isAntiAlias = tableBorder.right.width == 0;
      path.reset();
      path.moveTo(rect.right, rect.top);
      path.lineTo(rect.right, rect.bottom);
      if (tableBorder.right.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;

        path.lineTo(
          rect.right - tableBorder.right.width,
          rect.bottom - tableBorder.bottom.width,
        );
        path.lineTo(
          rect.right - tableBorder.right.width,
          rect.top + tableBorder.top.width,
        );
      }
      canvas.drawPath(path, paint);
    }

    if (tableBorder.bottom.style == BorderStyle.solid) {
      paint.color = tableBorder.bottom.color;
      paint.isAntiAlias = tableBorder.bottom.width == 0;
      path.reset();
      path.moveTo(rect.right, rect.bottom);
      path.lineTo(rect.left, rect.bottom);
      if (tableBorder.bottom.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;

        path.lineTo(
          rect.left + tableBorder.left.width,
          rect.bottom - tableBorder.bottom.width,
        );
        path.lineTo(
          rect.right - tableBorder.right.width,
          rect.bottom - tableBorder.bottom.width,
        );
      }
      canvas.drawPath(path, paint);
    }

    if (tableBorder.left.style == BorderStyle.solid) {
      paint.color = tableBorder.left.color;
      paint.isAntiAlias = tableBorder.left.width == 0;
      path.reset();
      path.moveTo(rect.left, rect.bottom);
      path.lineTo(rect.left, rect.top);
      if (tableBorder.left.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;

        path.lineTo(
          rect.left + tableBorder.left.width,
          rect.top + tableBorder.top.width,
        );
        path.lineTo(
          rect.left + tableBorder.left.width,
          rect.bottom - tableBorder.bottom.width,
        );
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint();
    final Path path = Path();

    RenderBox? child = firstChild;

    if (_rowCount != null && _targetCount != null) {
      int y = 0;

      while (child != null && y < _rowCount!) {
        final childParentData = child.parentData! as _ListTableParentData;
        context.paintChild(child, childParentData.offset + offset);

        child = childAfter(child);

        y += 1;
      }
    }

    if (!_isInteractive) {
      while (child != null) {
        final childParentData = child.parentData! as _ListTableParentData;
        context.paintChild(child, childParentData.offset + offset);
        child = childAfter(child);
      }
    }

    paintStaticTableBorder(canvas, offset, size, tableBorder);

    final double topBorderWidth = tableBorder.top.style == BorderStyle.solid
        ? tableBorder.top.width
        : 0.0;
    final double bottomBorderWidth =
        tableBorder.bottom.style == BorderStyle.solid
            ? tableBorder.bottom.width
            : 0.0;

    if (_isDraggingColumn && _draggingColumnTargetItemIndex == 0) {
      final double lineWidth =
          headerColumnBorder.width + _defaultIncrementHighlightWidth;

      paint.color = hoverColor;

      path.reset();

      path.moveTo(
        offset.dx,
        offset.dy + topBorderWidth,
      );
      path.lineTo(
        offset.dx,
        offset.dy + size.height - bottomBorderWidth,
      );

      if (lineWidth == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;

        path.lineTo(
          offset.dx + lineWidth,
          offset.dy + size.height - bottomBorderWidth,
        );
        path.lineTo(
          offset.dx + lineWidth,
          offset.dy + topBorderWidth,
        );
      }

      canvas.drawPath(path, paint);
    }

    if (tableBorder.verticalInside.style == BorderStyle.solid ||
        _draggingIndex >= 0 ||
        _draggingColumnTargetItemIndex >= 0) {
      for (int i = 0; i < _columns.length; i += 1) {
        final double x = _columns[i];

        double lineWidth;

        if (_draggingIndex == i) {
          paint.color = highlightColor;
          lineWidth = headerColumnBorder.width + _defaultIncrementDraggingWidth;
        } else if (_isDraggingColumn &&
            _draggingColumnTargetItemIndex - 1 == i) {
          paint.color = hoverColor;
          lineWidth =
              headerColumnBorder.width + _defaultIncrementHighlightWidth;
        } else {
          if (tableBorder.verticalInside.style != BorderStyle.solid) {
            continue;
          }
          paint.color = tableBorder.verticalInside.color;
          lineWidth = tableBorder.verticalInside.width;
        }

        paint.isAntiAlias =
            lineWidth == 0.0 || (_draggingIndex != -1 && _draggingIndex != i);

        path.reset();

        path.moveTo(
          offset.dx + x,
          offset.dy + _effectiveHeaderExtent,
        );
        path.lineTo(
          offset.dx + x,
          offset.dy + size.height - bottomBorderWidth,
        );

        if (lineWidth == 0.0) {
          paint.style = PaintingStyle.stroke;
        } else {
          paint.style = PaintingStyle.fill;

          path.lineTo(
            offset.dx + x - lineWidth,
            offset.dy + size.height - bottomBorderWidth,
          );
          path.lineTo(
            offset.dx + x - lineWidth,
            offset.dy + _effectiveHeaderExtent,
          );
        }

        canvas.drawPath(path, paint);
      }
    }

    if (headerColumnBorder.style == BorderStyle.solid) {
      for (int i = 0; i < _columns.length; i += 1) {
        final double x = _columns[i];
        final bool hasIndicator =
            i == _columns.length - 1 && _hasHiddenColumns && _isInteractive;

        double lineWidth;

        if (_columnHoverIndex == i || _draggingIndex == i || hasIndicator) {
          lineWidth = headerColumnBorder.width + _defaultIncrementDraggingWidth;

          paint.color = _draggingIndex == i
              ? highlightColor
              : _columnHoverIndex == i
                  ? hoverColor
                  : highlightColor;
        } else if (_isDraggingColumn &&
            _draggingColumnTargetItemIndex - 1 == i) {
          paint.color = hoverColor;
          lineWidth =
              headerColumnBorder.width + _defaultIncrementHighlightWidth;
        } else {
          paint.color = headerColumnBorder.color;
          lineWidth = headerColumnBorder.width;
        }

        paint.isAntiAlias =
            lineWidth == 0.0 || (_draggingIndex != -1 && _draggingIndex != i);

        path.reset();

        path.moveTo(
          offset.dx + x,
          offset.dy + topBorderWidth,
        );
        path.lineTo(
          offset.dx + x,
          offset.dy + _effectiveHeaderExtent,
        );

        if (lineWidth == 0.0) {
          paint.style = PaintingStyle.stroke;
        } else {
          paint.style = PaintingStyle.fill;

          path.lineTo(
            offset.dx + x - lineWidth,
            offset.dy + _effectiveHeaderExtent,
          );
          path.lineTo(
            offset.dx + x - lineWidth,
            offset.dy + topBorderWidth,
          );
        }

        canvas.drawPath(path, paint);
      }
    }
  }
}
