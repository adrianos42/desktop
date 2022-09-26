import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

///
class DaysMonth extends MultiChildRenderObjectWidget {
  /// Creates a [DaysMonth].
  DaysMonth({
    super.key,
    super.children,
    required this.daysOffset,
    required this.dayBoxSize,
  });

  ///
  final int daysOffset;

  ///
  final double dayBoxSize;

  @override
  _DayPickerRender createRenderObject(BuildContext context) {
    return _DayPickerRender(daysOffset: daysOffset, dayBoxSize: dayBoxSize);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _DayPickerRender renderObject) {
    renderObject
      ..daysOffset = daysOffset
      ..dayBoxSize = dayBoxSize;
  }
}

class _DayPickerParentData extends ContainerBoxParentData<RenderBox> {}

///
class _DayPickerRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _DayPickerParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _DayPickerParentData> {
  ///
  _DayPickerRender({
    List<RenderBox>? children,
    required int daysOffset,
    required double dayBoxSize,
  })  : _daysOffset = daysOffset,
        _dayBoxSize = dayBoxSize {
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

  double _dayBoxSize;
  double get dayBoxSize => _dayBoxSize;
  set dayBoxSize(double value) {
    if (_dayBoxSize != value) {
      _dayBoxSize = value;
      markNeedsLayout();
    }
  }

  int get rows =>
      ((childCount + daysOffset) + DateTime.daysPerWeek - 1) ~/
      DateTime.daysPerWeek;

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
    return constraints.constrain(Size(dayBoxSize, dayBoxSize * rows));
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final double positionOffset = daysOffset * dayBoxSize;

    int x = 0;
    int row = 0;
    int y = 0;
    RenderBox? child = firstChild;

    while (child != null) {
      final _DayPickerParentData childParentData =
          child.parentData! as _DayPickerParentData;

      final Offset position = Offset(
          (row == 0 ? positionOffset : 0.0) + y * dayBoxSize, row * dayBoxSize);

      child.layout(
        BoxConstraints.tightFor(
          width: dayBoxSize,
          height: dayBoxSize,
        ),
      );

      childParentData.offset = position;
      child = childParentData.nextSibling;

      x += 1;
      y += 1;

      if ((x + daysOffset) % DateTime.daysPerWeek == 0) {
        row += 1;
        y = 0;
      }
    }

    size = constraints.constrain(Size(
      dayBoxSize * DateTime.daysPerWeek,
      dayBoxSize * rows,
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
