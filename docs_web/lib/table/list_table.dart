import 'desktop_table.dart';

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:desktop/desktop.dart';

const _kHeaderHeight = 40.0;
const _kMinColumnWidth = 48.0;
const _kHandlerWidth = 12.0;

class _TableElementRow {
  const _TableElementRow({this.key, required this.children});
  final LocalKey? key;
  final List<Element> children;
}

class WTable extends RenderObjectWidget {
  WTable({
    super.key,
    this.tableBorder,
    required this.colCount,
    required this.itemCount,
    required this.tableHeaderBuilder,
    required this.tableRowBuilder,
    required this.children,
    this.headerColumnBorder,
    this.colFraction,
    this.controller,
    this.itemExtent = _kHeaderHeight,
    this.onPressed,
    this.onSecondaryPress,
    this.allowColumnDragging = false,
    this.columnIndexMapping,
    this.onColumnIndexMappingChanged,
  })  : assert(colCount > 0),
        assert(itemExtent >= 0.0),
        assert(
          !allowColumnDragging ||
              columnIndexMapping == null ||
              columnIndexMapping.length == colCount,
        ),
        _rowDecorations = children.any((TableRow row) => row.decoration != null)
            ? children
                .map<Decoration?>((TableRow row) => row.decoration)
                .toList(growable: false)
            : null;

  final BorderSide? headerColumnBorder;

  final int colCount;

  final int itemCount;

  final Map<int, double>? colFraction;

  final TableRowBuilder tableRowBuilder;

  final TableHeaderBuilder tableHeaderBuilder;

  final TableBorder? tableBorder;

  final ScrollController? controller;

  /// The height of item row.
  final double itemExtent;

  final RowPressedCallback? onPressed;

  final RowPressedCallback? onSecondaryPress;

  final ColumnIndexMappingCallback? onColumnIndexMappingChanged;

  /// The mapping for column positions. Must be the same size as `colCount`.
  final List<int>? columnIndexMapping;

  final bool allowColumnDragging;

  /// The rows of the table.
  ///
  /// Every row in a table must have the same number of children, and all the
  /// children must be non-null.
  final List<TableRow> children;

  final List<Decoration?>? _rowDecorations;

  @override
  RenderObjectElement createElement() => _TableElement(this);

  @override
  DesktopRenderTable createRenderObject(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    return DesktopRenderTable(
      columns: colCount,
      rows: children.length,
      // columnWidths: columnWidths,
      // defaultColumnWidth: defaultColumnWidth,
      textDirection: Directionality.of(context),
      border: tableBorder,
      // rowDecorations: _rowDecorations,
      configuration: createLocalImageConfiguration(context),
      // defaultVerticalAlignment: defaultVerticalAlignment,
      // textBaseline: textBaseline,
    );
  }

  @override
  void updateRenderObject(BuildContext context, DesktopRenderTable renderObject) {
    assert(debugCheckHasDirectionality(context));
    //assert(renderObject.columns == (children.isNotEmpty ? children[0].children!.length : 0));
    // assert(renderObject.rows == children.length);
    renderObject
          //..columnWidths = columnWidths
          //..defaultColumnWidth = defaultColumnWidth
          ..textDirection = Directionality.of(context)
          ..border = tableBorder
          ..rowDecorations = _rowDecorations
          ..configuration = createLocalImageConfiguration(context)
        //..defaultVerticalAlignment = defaultVerticalAlignment
        //..textBaseline = textBaseline;
        ;
  }
}

class _TableElement extends RenderObjectElement {
  _TableElement(WTable super.widget);

  @override
  DesktopRenderTable get renderObject => super.renderObject as DesktopRenderTable;

  List<_TableElementRow> _children = const <_TableElementRow>[];

  bool _doingMountOrUpdate = false;

  @override
  void mount(Element? parent, Object? newSlot) {
    assert(!_doingMountOrUpdate);
    _doingMountOrUpdate = true;
    super.mount(parent, newSlot);
    int rowIndex = -1;
    _children =
        (widget as WTable).children.map<_TableElementRow>((TableRow row) {
      int columnIndex = 0;
      rowIndex += 1;
      return _TableElementRow(
        key: row.key,
        children: row.children!.map<Element>((Widget child) {
          return inflateWidget(child, _TableSlot(columnIndex++, rowIndex));
        }).toList(growable: false),
      );
    }).toList(growable: false);

    _updateRenderObjectChildren();
    assert(_doingMountOrUpdate);
    _doingMountOrUpdate = false;
  }

  @override
  void insertRenderObjectChild(RenderBox child, _TableSlot slot) {
    renderObject.setupParentData(child);
    // Once [mount]/[update] are done, the children are getting set all at once
    // in [_updateRenderObjectChildren].
    if (!_doingMountOrUpdate) {
      renderObject.setChild(slot.column, slot.row, child);
    }
  }

  @override
  void moveRenderObjectChild(
      RenderBox child, _TableSlot oldSlot, _TableSlot newSlot) {
    assert(_doingMountOrUpdate);
    // Child gets moved at the end of [update] in [_updateRenderObjectChildren].
  }

  @override
  void removeRenderObjectChild(RenderBox child, _TableSlot slot) {
    renderObject.setChild(slot.column, slot.row, null);
  }

  final Set<Element> _forgottenChildren = HashSet<Element>();

  @override
  void update(WTable newWidget) {
    assert(!_doingMountOrUpdate);
    _doingMountOrUpdate = true;
    final Map<LocalKey, List<Element>> oldKeyedRows =
        <LocalKey, List<Element>>{};
    for (final _TableElementRow row in _children) {
      if (row.key != null) {
        oldKeyedRows[row.key!] = row.children;
      }
    }
    final Iterator<_TableElementRow> oldUnkeyedRows =
        _children.where((_TableElementRow row) => row.key == null).iterator;
    final List<_TableElementRow> newChildren = <_TableElementRow>[];
    final Set<List<Element>> taken = <List<Element>>{};
    for (int rowIndex = 0; rowIndex < newWidget.children.length; rowIndex++) {
      final TableRow row = newWidget.children[rowIndex];
      List<Element> oldChildren;
      if (row.key != null && oldKeyedRows.containsKey(row.key)) {
        oldChildren = oldKeyedRows[row.key]!;
        taken.add(oldChildren);
      } else if (row.key == null && oldUnkeyedRows.moveNext()) {
        oldChildren = oldUnkeyedRows.current.children;
      } else {
        oldChildren = const <Element>[];
      }
      final List<_TableSlot> slots = List<_TableSlot>.generate(
        row.children!.length,
        (int columnIndex) => _TableSlot(columnIndex, rowIndex),
      );
      newChildren.add(_TableElementRow(
        key: row.key,
        children: updateChildren(oldChildren, row.children!,
            forgottenChildren: _forgottenChildren, slots: slots),
      ));
    }
    while (oldUnkeyedRows.moveNext()) {
      updateChildren(oldUnkeyedRows.current.children, const <Widget>[],
          forgottenChildren: _forgottenChildren);
    }
    for (final List<Element> oldChildren in oldKeyedRows.values
        .where((List<Element> list) => !taken.contains(list))) {
      updateChildren(oldChildren, const <Widget>[],
          forgottenChildren: _forgottenChildren);
    }

    _children = newChildren;
    _updateRenderObjectChildren();
    _forgottenChildren.clear();
    super.update(newWidget);
    assert(widget == newWidget);
    assert(_doingMountOrUpdate);
    _doingMountOrUpdate = false;
  }

  void _updateRenderObjectChildren() {
    renderObject.setFlatChildren(
      _children.isNotEmpty ? _children[0].children.length : 0,
      _children.expand<RenderBox>((_TableElementRow row) {
        return row.children.map<RenderBox>((Element child) {
          final RenderBox box = child.renderObject! as RenderBox;
          return box;
        });
      }).toList(),
    );
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    for (final Element child
        in _children.expand<Element>((_TableElementRow row) => row.children)) {
      if (!_forgottenChildren.contains(child)) {
        visitor(child);
      }
    }
  }

  @override
  bool forgetChild(Element child) {
    _forgottenChildren.add(child);
    super.forgetChild(child);
    return true;
  }
}

/// A widget that controls how a child of a [WTable] is aligned.
///
/// A [_TableCell] widget must be a descendant of a [WTable], and the path from
/// the [_TableCell] widget to its enclosing [WTable] must contain only
/// [WTableRow]s, [StatelessWidget]s, or [StatefulWidget]s (not
/// other kinds of widgets, like [RenderObjectWidget]s).
class _TableCell extends ParentDataWidget<TableCellParentData> {
  /// Creates a widget that controls how a child of a [WTable] is aligned.
  const _TableCell({
    super.key,
    this.verticalAlignment,
    required super.child,
  });

  /// How this cell is aligned vertically.
  final TableCellVerticalAlignment? verticalAlignment;

  @override
  void applyParentData(RenderObject renderObject) {
    final TableCellParentData parentData =
        renderObject.parentData! as TableCellParentData;
    if (parentData.verticalAlignment != verticalAlignment) {
      parentData.verticalAlignment = verticalAlignment;
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => WTable;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<TableCellVerticalAlignment>(
        'verticalAlignment', verticalAlignment));
  }
}

@immutable
class _TableSlot with Diagnosticable {
  const _TableSlot(this.column, this.row);

  final int column;
  final int row;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _TableSlot && column == other.column && row == other.row;
  }

  @override
  int get hashCode => Object.hash(column, row);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('x', column));
    properties.add(IntProperty('y', row));
  }
}
