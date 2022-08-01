import 'list_row_render.dart';

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:desktop/desktop.dart';

const _kHeaderHeight = 40.0;
const _kMinColumnWidth = 48.0;
const _kHandlerWidth = 12.0;

///
class ListRow extends MultiChildRenderObjectWidget {
  ///
  ListRow({
    super.key,
    super.children,
    this.rowDecoration,
    this.bottomBorder,
    required this.itemExtent,
    required this.colSizes,
  });

  ///
  final BorderSide? bottomBorder;

  ///
  final List<double> colSizes;

  ///
  final double itemExtent;

  ///
  final Decoration? rowDecoration;

  @override
  ListRowRender createRenderObject(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    return ListRowRender(
      columnWidths: colSizes,
      columns: children.length,
      itemExtend: itemExtent,
      border: const TableBorder(),
      rowDecoration: rowDecoration,
      configuration: createLocalImageConfiguration(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, ListRowRender renderObject) {
    assert(debugCheckHasDirectionality(context));
    //assert(renderObject.columns == (children.isNotEmpty ? children[0].children!.length : 0));
    // assert(renderObject.rows == children.length);
    renderObject
      ..columnWidths = colSizes
      ..itemExtend = itemExtent
      ..border = const TableBorder()
      ..rowDecoration = rowDecoration
      ..configuration = createLocalImageConfiguration(context);
  }
}

// class _TableElement extends RenderObjectElement {
//   _TableElement(ListRow super.widget);

//   @override
//   ListRowRender get renderObject => super.renderObject as ListRowRender;

//   List<Element> _children = const <Element>[];

//   bool _doingMountOrUpdate = false;

//   @override
//   void mount(Element? parent, Object? newSlot) {
//     assert(!_doingMountOrUpdate);
//     _doingMountOrUpdate = true;
//     super.mount(parent, newSlot);

//     int columnIndex = 0;
//     _children = (widget as ListRow).children.map<Element>((Widget child) {
//       return inflateWidget(child, _TableSlot(columnIndex++));
//     }).toList(growable: false);

//     _updateRenderObjectChildren();
//     assert(_doingMountOrUpdate);
//     _doingMountOrUpdate = false;
//   }

//   @override
//   void insertRenderObjectChild(RenderBox child, _TableSlot slot) {
//     renderObject.setupParentData(child);
//     // Once [mount]/[update] are done, the children are getting set all at once
//     // in [_updateRenderObjectChildren].
//     if (!_doingMountOrUpdate) {
//       renderObject.setChild(slot.column, child);
//     }
//   }

//   @override
//   void moveRenderObjectChild(
//       RenderBox child, _TableSlot oldSlot, _TableSlot newSlot) {
//     assert(_doingMountOrUpdate);
//     // Child gets moved at the end of [update] in [_updateRenderObjectChildren].
//   }

//   @override
//   void removeRenderObjectChild(RenderBox child, _TableSlot slot) {
//     renderObject.setChild(slot.column, null);
//   }

//   final Set<Element> _forgottenChildren = HashSet<Element>();

//   @override
//   void update(ListRow newWidget) {
//     assert(!_doingMountOrUpdate);
//     _doingMountOrUpdate = true;
//     // final Map<LocalKey, List<Element>> oldKeyedRows =
//     //     <LocalKey, List<Element>>{};

//     final List<Element> newChildren = <Element>[];
//     final Set<List<Element>> taken = <List<Element>>{};

//     List<Element> oldChildren = const <Element>[];

//     final List<_TableSlot> slots = List<_TableSlot>.generate(
//       newWidget.children.length,
//       (int columnIndex) => _TableSlot(columnIndex),
//     );

//     newChildren.addAll(
//       updateChildren(oldChildren, newWidget.children,
//           forgottenChildren: _forgottenChildren, slots: slots),
//     );

//     _children = newChildren;
//     _updateRenderObjectChildren();
//     _forgottenChildren.clear();
//     super.update(newWidget);
//     assert(widget == newWidget);
//     assert(_doingMountOrUpdate);
//     _doingMountOrUpdate = false;
//   }

//   void _updateRenderObjectChildren() {
//     renderObject.setFlatChildren(
//       _children.map<RenderBox>((Element child) {
//         final RenderBox box = child.renderObject! as RenderBox;
//         return box;
//       }).toList(),
//     );
//   }

//   @override
//   void visitChildren(ElementVisitor visitor) {
//     for (final Element child in _children) {
//       if (!_forgottenChildren.contains(child)) {
//         visitor(child);
//       }
//     }
//   }

//   @override
//   bool forgetChild(Element child) {
//     _forgottenChildren.add(child);
//     super.forgetChild(child);
//     return true;
//   }
// }

// /// A widget that controls how a child of a [ListRow] is aligned.
// ///
// /// A [_TableCell] widget must be a descendant of a [ListRow], and the path from
// /// the [_TableCell] widget to its enclosing [ListRow] must contain only
// /// [WTableRow]s, [StatelessWidget]s, or [StatefulWidget]s (not
// /// other kinds of widgets, like [RenderObjectWidget]s).
// class _TableCell extends ParentDataWidget<TableCellParentData> {
//   /// Creates a widget that controls how a child of a [ListRow] is aligned.
//   const _TableCell({
//     super.key,
//     this.verticalAlignment,
//     required super.child,
//   });

//   /// How this cell is aligned vertically.
//   final TableCellVerticalAlignment? verticalAlignment;

//   @override
//   void applyParentData(RenderObject renderObject) {
//     final TableCellParentData parentData =
//         renderObject.parentData! as TableCellParentData;
//     if (parentData.verticalAlignment != verticalAlignment) {
//       parentData.verticalAlignment = verticalAlignment;
//       final AbstractNode? targetParent = renderObject.parent;
//       if (targetParent is RenderObject) {
//         targetParent.markNeedsLayout();
//       }
//     }
//   }

//   @override
//   Type get debugTypicalAncestorWidgetClass => ListRow;

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(EnumProperty<TableCellVerticalAlignment>(
//         'verticalAlignment', verticalAlignment));
//   }
// }

// @immutable
// class _TableSlot with Diagnosticable {
//   const _TableSlot(this.column);

//   final int column;

//   @override
//   bool operator ==(Object other) {
//     if (other.runtimeType != runtimeType) {
//       return false;
//     }
//     return other is _TableSlot && column == other.column;
//   }

//   @override
//   int get hashCode => column.hashCode;

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(IntProperty('y', column));
//   }
// }
