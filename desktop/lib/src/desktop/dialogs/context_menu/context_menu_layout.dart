import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Layout delegate for [ContextMenu].
class ContextMenuLayoutDelegate extends SingleChildLayoutDelegate {
  /// Creates a [ContextMenuLayoutDelegate].
  ContextMenuLayoutDelegate(this.position);

  /// The target position of the child.
  final Rect position;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxHeight = constraints.maxHeight;
    final double maxWidth = constraints.maxWidth;
    return BoxConstraints.loose(Size(maxWidth, maxHeight));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double y;
    if (size.height - position.bottom >= childSize.height) {
      y = position.bottom;
    } else if (childSize.height <= position.top) {
      y = position.top - childSize.height;
    } else {
      y = 0;
    }

    double x;
    if (size.width - position.left >= childSize.width) {
      x = position.left;
    } else if (childSize.width <= position.right) {
      x = position.right - childSize.width;
    } else {
      x = 0;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(ContextMenuLayoutDelegate oldDelegate) {
    return position != oldDelegate.position;
  }
}