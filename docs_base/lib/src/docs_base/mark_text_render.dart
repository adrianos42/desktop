import 'dart:ui' as ui;

import 'package:desktop/desktop.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

///
typedef MarkTextBuilder = ui.Paragraph Function(double width);

///
class MarkTextDoc extends MultiChildRenderObjectWidget {
  ///
  MarkTextDoc({
    super.key,
    required super.children,
    required this.markTextBuilder,
  });

  ///
  final MarkTextBuilder markTextBuilder;

  @override
  MarkTextRender createRenderObject(BuildContext context) =>
      MarkTextRender(markTextBuilder: markTextBuilder);

  @override
  void updateRenderObject(BuildContext context, MarkTextRender renderObject) {
    renderObject.markTextBuilder = markTextBuilder;
  }
}

class _MarkTextParentData extends ContainerBoxParentData<RenderBox> {}

///
class MarkTextRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _MarkTextParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _MarkTextParentData>
    implements MouseTrackerAnnotation {
  ///
  MarkTextRender({
    List<RenderBox>? children,
    required MarkTextBuilder markTextBuilder,
  }) : _markTextBuilder = markTextBuilder {
    addAll(children);
  }

  late HorizontalDragGestureRecognizer _dragGesture;

  bool get _isInteractive => false;

  ui.Paragraph? _paragraph;

  MarkTextBuilder _markTextBuilder;
  set markTextBuilder(MarkTextBuilder value) {
    _markTextBuilder = value;
    markNeedsLayout();
  }

  void _handleMouseEnter(PointerEnterEvent event) {
    markNeedsPaint();
  }

  void _handleMouseExit(PointerExitEvent event) {
    markNeedsPaint();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _MarkTextParentData) {
      child.parentData = _MarkTextParentData();
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
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
    _paragraph = _markTextBuilder(constraints.maxWidth);

    _paragraph!.layout(ui.ParagraphConstraints(width: constraints.maxWidth));

    return constraints.copyWith(maxHeight: _paragraph!.height).biggest;
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    RenderBox? child = firstChild;

    int x = 0;

    final List<double> positions = List<double>.filled(childCount, 0.0);

    while (child != null) {
      final _MarkTextParentData childParentData =
          child.parentData! as _MarkTextParentData;

      child.layout(BoxConstraints.tightFor(
        width: 10.0,
        height: constraints.maxHeight,
      ));
      childParentData.offset = Offset(positions[x], 0.0);

      child = childParentData.nextSibling;
      x += 1;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return !_isInteractive &&
        defaultHitTestChildren(result, position: position);
  }

  @override
  bool hitTestSelf(Offset position) {
    return _isInteractive;
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

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    canvas.drawParagraph(_paragraph!, offset);

    RenderBox? child = firstChild;
    while (child != null) {
      final _MarkTextParentData childParentData =
          child.parentData! as _MarkTextParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childParentData.nextSibling;
    }
  }
}
