import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

///
class DaysMonth extends MultiChildRenderObjectWidget {
  /// Creates a [DaysMonth].
  const DaysMonth({
    super.key,
    super.children,
    required this.daysOffset,
    required this.boxSize,
    required this.columns,
  });

  ///
  final int daysOffset;

  ///
  final Size boxSize;

  ///
  final int columns;

  @override
  DayPickerRender createRenderObject(BuildContext context) {
    return DayPickerRender(
        daysOffset: daysOffset, boxSize: boxSize, columns: columns);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant DayPickerRender renderObject) {
    renderObject
      ..daysOffset = daysOffset
      ..boxSize = boxSize
      ..columns = columns;
  }
}

class _DayPickerParentData extends ContainerBoxParentData<RenderBox> {}

///
class DayPickerRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _DayPickerParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _DayPickerParentData> {
  ///
  DayPickerRender({
    List<RenderBox>? children,
    required int daysOffset,
    required Size boxSize,
    required int columns,
  })  : _daysOffset = daysOffset,
        _boxSize = boxSize,
        _columns = columns {
    addAll(children);
  }

  int _daysOffset;
  int get daysOffset => _daysOffset;
  set daysOffset(int value) {
    if (_daysOffset != value) {
      _daysOffset = value;
      markNeedsLayout();
    }
  }

  int _columns;
  int get columns => _columns;
  set columns(int value) {
    if (_columns != value) {
      _columns = value;
      markNeedsLayout();
    }
  }

  Size _boxSize;
  Size get boxSize => _boxSize;
  set boxSize(Size value) {
    if (_boxSize != value) {
      _boxSize = value;
      markNeedsLayout();
    }
  }

  int get _rows => ((childCount + daysOffset) + _columns - 1) ~/ _columns;

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _DayPickerParentData) {
      child.parentData = _DayPickerParentData();
    }
  }

  @override
  bool hitTestSelf(Offset position) => false;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.constrain(Size(_boxSize.width, _boxSize.height * _rows));
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final double positionOffset = _daysOffset * _boxSize.width;

    int x = 0;
    int row = 0;
    int xPosition = 0;
    RenderBox? child = firstChild;

    while (child != null) {
      final _DayPickerParentData childParentData =
          child.parentData! as _DayPickerParentData;

      final Offset position = Offset(
        (row == 0 ? positionOffset : 0.0) + xPosition * _boxSize.width,
        row * _boxSize.height,
      );

      child.layout(
        BoxConstraints.tightFor(
          width: _boxSize.width,
          height: _boxSize.height,
        ),
      );

      childParentData.offset = position;
      child = childParentData.nextSibling;

      x += 1;
      xPosition += 1;

      if ((x + _daysOffset) % _columns == 0) {
        row += 1;
        xPosition = 0;
      }
    }

    size = constraints.constrain(Size(
      _boxSize.width * columns,
      _boxSize.height * _rows,
    ));
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
    RenderBox? child = firstChild;
    while (child != null) {
      final _DayPickerParentData childParentData =
          child.parentData! as _DayPickerParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childParentData.nextSibling;
    }
  }
}
