import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const _kHeaderHeight = 40.0;
const _kMinColumnWidth = 48.0;
const _kHandlerWidth = 12.0;

///
class ListTableRender extends RenderBox implements MouseTrackerAnnotation {
  ///
  ListTableRender({
    required BorderSide headerColumnBorder,
    required TableBorder tableBorder,
    required List<double> colSizes,
    required double headerExtent,
    required Color highlightColor,
    required Color hoverColor,
    required this.dragStart,
    required this.dragUpdate,
    required this.dragEnd,
    required this.dragCancel,
  })  : _headerColumnBorder = headerColumnBorder,
        _tableBorder = tableBorder,
        _colSizes = colSizes,
        _headerExtent = headerExtent,
        _columns = _generateColumns(colSizes),
        _highlightColor = highlightColor,
        _hoverColor = hoverColor;

  static List<double> _generateColumns(List<double> values) {
    final List<double> nonZeroColumns = [];

    for (final x in values) {
      if (x == 0.0 && nonZeroColumns.any((e) => e == 0.0)) {
        break;
      }

      nonZeroColumns.add(x);
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

  Color _hoverColor;
  Color get hoverColor => _hoverColor;
  set hoverColor(Color value) {
    if (value == _hoverColor) {
      return;
    }
    _hoverColor = value;
    markNeedsPaint();
  }

  Color _highlightColor;
  Color get highlightColor => _highlightColor;
  set highlightColor(Color value) {
    if (value == _highlightColor) {
      return;
    }
    _highlightColor = value;
    markNeedsPaint();
  }

  BorderSide _headerColumnBorder;
  BorderSide get headerColumnBorder => _headerColumnBorder;
  set headerColumnBorder(BorderSide value) {
    if (value == _headerColumnBorder) {
      return;
    }
    _headerColumnBorder = value;
    markNeedsLayout();
  }

  TableBorder _tableBorder;
  TableBorder get tableBorder => _tableBorder;
  set tableBorder(TableBorder value) {
    if (value == _tableBorder) {
      return;
    }

    _tableBorder = value;
    markNeedsLayout();
  }

  List<double> _colSizes;
  List<double> get colSizes => _colSizes;
  set colSizes(List<double> value) {
    if (value == colSizes) {
      return;
    }
    _colSizes = value;
    _lastNonZero = _colSizes.lastIndexWhere((elem) => elem > 0.0);

    _columns = ListTableRender._generateColumns(_colSizes);
    _hasHiddenColumns = _colSizes.any((elem) => elem == 0.0);

    markNeedsLayout();
  }

  double _headerExtent;
  double get headerExtent => _headerExtent;
  set headerExtent(double value) {
    if (value == headerExtent) {
      return;
    }
    _headerExtent = value;
    markNeedsLayout();
  }

  bool get _isInteractive => true;

  List<double> _columns;

  late HorizontalDragGestureRecognizer _dragGesture;

  bool _hasHiddenColumns = false;
  int _lastNonZero = -1;
  int _columnHoverIndex = -1;
  int _columnDraggingIndex = -1;
  double _currentPosition = 0.0;

  int _indexOfColumn(Offset localPosition) {
    return _columns
        .map((column) => Rect.fromLTWH(
            column - _kHandlerWidth, 0.0, _kHandlerWidth * 2, headerExtent))
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
    dragStart(_columnDraggingIndex);
    _currentPosition = details.globalPosition.dx;
  }

  void _handleDragDown(DragDownDetails details) {
    _columnDraggingIndex = _indexOfColumn(details.localPosition);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_columnDraggingIndex >= 0) {
      dragUpdate(
          _columnDraggingIndex, details.globalPosition.dx - _currentPosition);
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_columnDraggingIndex >= 0) {
      _columnDraggingIndex = -1;
      dragEnd();
    }
  }

  void _handleDragCancel() {
    _columnDraggingIndex = -1;
    dragCancel();
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
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  bool hitTestSelf(Offset position) {
    return _columns
        .map((column) => Rect.fromLTWH(
            column - _kHandlerWidth, 0.0, _kHandlerWidth * 2, headerExtent))
        .any((element) => element.contains(position));
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && _isInteractive) {
      _dragGesture.addPointer(event);
    }
  }

  @override
  MouseCursor get cursor => SystemMouseCursors.resizeColumn;

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

  void _paintStaticTableBorder(Canvas canvas, Offset offset) {
    final Paint paint = Paint()
      ..strokeWidth = 0.0
      ..isAntiAlias = false;
    final Path path = Path();

    final BorderSide headerBorder =
        tableBorder.top; // TODO(as): See if it should use the top border side.

    final rect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);

    if (tableBorder.top.style == BorderStyle.solid) {
      paint.color = tableBorder.top.color;
      path.reset();
      path.moveTo(rect.left, rect.top);
      path.lineTo(rect.right, rect.top);
      if (tableBorder.top.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;
        path.lineTo(rect.right - tableBorder.right.width,
            rect.top + tableBorder.top.width);
        path.lineTo(rect.left + tableBorder.left.width,
            rect.top + tableBorder.top.width);
      }
      canvas.drawPath(path, paint);
    }

    if (tableBorder.right.style == BorderStyle.solid) {
      paint.color = tableBorder.right.color;
      path.reset();
      path.moveTo(rect.right, rect.top);
      path.lineTo(rect.right, rect.bottom);
      if (tableBorder.right.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;
        path.lineTo(rect.right - tableBorder.right.width,
            rect.bottom - tableBorder.bottom.width);
        path.lineTo(rect.right - tableBorder.right.width,
            rect.top + tableBorder.top.width);
      }
      canvas.drawPath(path, paint);
    }

    if (tableBorder.bottom.style == BorderStyle.solid) {
      paint.color = tableBorder.bottom.color;
      path.reset();
      path.moveTo(rect.right, rect.bottom);
      path.lineTo(rect.left, rect.bottom);
      if (tableBorder.bottom.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;
        path.lineTo(rect.left + tableBorder.left.width,
            rect.bottom - tableBorder.bottom.width);
        path.lineTo(rect.right - tableBorder.right.width,
            rect.bottom - tableBorder.bottom.width);
      }
      canvas.drawPath(path, paint);
    }

    if (tableBorder.left.style == BorderStyle.solid) {
      paint.color = tableBorder.left.color;
      path.reset();
      path.moveTo(rect.left, rect.bottom);
      path.lineTo(rect.left, rect.top);
      if (tableBorder.left.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;
        path.lineTo(rect.left + tableBorder.left.width,
            rect.top + tableBorder.top.width);
        path.lineTo(rect.left + tableBorder.left.width,
            rect.bottom - tableBorder.bottom.width);
      }
      canvas.drawPath(path, paint);
    }

    // Border used to separate header and items.
    if (headerBorder.style == BorderStyle.solid) {
      paint.color = headerBorder.color;
      path.reset();
      path.moveTo(rect.right, rect.top + headerExtent);
      path.lineTo(rect.left, rect.top + headerExtent);
      if (headerBorder.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;
        path.lineTo(rect.left, rect.top + headerExtent + headerBorder.width);
        path.lineTo(rect.right, rect.top + headerExtent + headerBorder.width);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint();
    final Path path = Path();

    _paintStaticTableBorder(canvas, offset);

    if (tableBorder.verticalInside.style == BorderStyle.solid ||
        _columnDraggingIndex >= 0) {
      for (int i = 0; i < _columns.length; i += 1) {
        final double x = _columns[i];

        final bool hasIndicator = i == _lastNonZero && _hasHiddenColumns;

        double lineWidth;

        if (_columnDraggingIndex == i) {
          paint.color = highlightColor;
          lineWidth = headerColumnBorder.width + 1.0;
        } else {
          if (tableBorder.verticalInside.style != BorderStyle.solid) {
            continue;
          }
          paint.color = tableBorder.verticalInside.color;
          lineWidth = tableBorder.verticalInside.width;
        }

        final double indicatorOffset = hasIndicator &&
                tableBorder.right.style == BorderStyle.solid
            ? lineWidth
            : 0.0;

        path.reset();

        path.moveTo(offset.dx + x - indicatorOffset, offset.dy + _headerExtent);
        path.lineTo(offset.dx + x - indicatorOffset, offset.dy + size.height);

        if (tableBorder.verticalInside.width == 0.0 &&
            _columnDraggingIndex != i) {
          paint.style = PaintingStyle.stroke;
        } else {
          paint.style = PaintingStyle.fill;
          path.lineTo(offset.dx + x + lineWidth - indicatorOffset,
              offset.dy + size.height);
          path.lineTo(offset.dx + x + lineWidth - indicatorOffset,
              offset.dy + _headerExtent);
        }

        canvas.drawPath(path, paint);
      }
    }

    if (headerColumnBorder.style == BorderStyle.solid) {
      for (int i = 0; i < _columns.length; i += 1) {
        final double x = _columns[i];
        final bool hasIndicator = i == _lastNonZero && _hasHiddenColumns;

        double lineWidth;

        if (_columnHoverIndex == i ||
            _columnDraggingIndex == i ||
            hasIndicator) {
          lineWidth = headerColumnBorder.width + 1.0;

          paint.color = _columnDraggingIndex == i
              ? highlightColor
              : _columnHoverIndex == i
                  ? hoverColor
                  : highlightColor;
        } else {
          paint.color = headerColumnBorder.color;
          lineWidth = headerColumnBorder.width;
        }

        final double indicatorOffset =
            hasIndicator && tableBorder.right.style == BorderStyle.solid
                ? lineWidth
                : 0.0;

        path.reset();

        path.moveTo(offset.dx + x - indicatorOffset, offset.dy);
        path.lineTo(offset.dx + x - indicatorOffset, offset.dy + _headerExtent);

        if (headerColumnBorder.width == 0.0) {
          paint.style = PaintingStyle.stroke;
        } else {
          paint.style = PaintingStyle.fill;
          path.lineTo(offset.dx + x + lineWidth - indicatorOffset,
              offset.dy + _headerExtent);
          path.lineTo(offset.dx + x + lineWidth - indicatorOffset, offset.dy);
        }

        canvas.drawPath(path, paint);
      }
    }
  }
}
