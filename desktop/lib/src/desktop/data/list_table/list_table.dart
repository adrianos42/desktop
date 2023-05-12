import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import 'feedback_column.dart';
import 'list_row.dart';
import 'list_table_render.dart';

const _kHeaderHeight = 40.0;
const _kMinColumnWidth = 48.0;

/// The header in a [ListTable].
@immutable
class ListTableHeader {
  /// Creates a header in a [ListTable].
  const ListTableHeader({
    this.decoration,
    this.builder,
    this.children,
    this.columnBorder,
    this.itemExtent = _kHeaderHeight,
  });

  /// A decoration to be painted behind the header.
  final Decoration? decoration;

  /// The builder for the header cells.
  final IndexedWidgetBuilder? builder;

  /// The children for the header cells.
  final List<Widget>? children;

  /// THe column [BorderSize].
  final BorderSide? columnBorder;

  /// The height of the header.
  final double? itemExtent;
}

///
typedef RowPressedCallback = void Function(RelativeRect position);

/// The row in a [ListTable].
@immutable
class ListTableRow {
  /// Creates a header in a [ListTable].
  const ListTableRow({
    this.decoration,
    this.builder,
    this.itemExtent = _kHeaderHeight,
    this.onPressed,
    this.onSecondaryPress,
    this.children,
  }) : assert(children == null || builder == null);

  /// A decoration to be painted behind the header.
  final Decoration? decoration;

  /// The builder for the row cells.
  final IndexedWidgetBuilder? builder;

  /// The children for the row cells.
  final List<Widget>? children;

  /// The height of the row.
  /// If [itemExtent] is set to null, then the height will be calculated by
  /// the intrinsic height of each cell in the row.
  /// Default to 40.0.
  final double? itemExtent;

  /// Callback for when the row is pressed.
  final RowPressedCallback? onPressed;

  /// Callback for when the row receives a secondary press.
  final RowPressedCallback? onSecondaryPress;
}

/// Called when a column is dragged.
/// May be used to save the columns positions.
typedef ColumnIndexMappingCallback = void Function(List<int> indexMapping);

/// A table with columns that can be resized.
class ListTable extends StatefulWidget {
  /// Creates a [ListTable].
  const ListTable({
    super.key,
    this.tableBorder,
    required this.colCount,
    this.colFraction,
    this.controller,
    this.allowColumnDragging = false,
    this.columnIndexMapping,
    this.onColumnIndexMappingChanged,
    required this.header,
    required this.rows,
  })  : assert(colCount > 0),
        assert(
          !allowColumnDragging ||
              columnIndexMapping == null ||
              columnIndexMapping.length == colCount,
        );

  /// Header item.
  final ListTableHeader header;

  /// Rows items.
  final List<ListTableRow> rows;

  /// The amount of columns in the table.
  final int colCount;

  /// The default columns fractions.
  final Map<int, double>? colFraction;

  /// See [TableBorder].
  final TableBorder? tableBorder;

  /// The scroll [ScrollController].
  final ScrollController? controller;

  /// Called when a column placement is changed in the table.
  final ColumnIndexMappingCallback? onColumnIndexMappingChanged;

  /// The mapping for column positions. Must be the same size as `colCount`.
  final List<int>? columnIndexMapping;

  /// If it's allowed to rearrange the columns by dragging them.
  final bool allowColumnDragging;

  // If the last column should collapse if it does not fit the minimum width anymore.
  // TODO(as): final bool collapseOnDrag;

  @override
  State<ListTable> createState() => _ListTableState();
}

class _ListTableState extends State<ListTable> {
  bool shouldReactToPrimaryPress = false;
  bool shouldReactToSecondaryPress = false;

  int hoveredIndex = -1;
  int pressedIndex = -1;
  int waitingIndex = -1;
  int draggingColumnIndex = -1;
  int draggingColumnTargetIndex = -1;
  int draggingColumnTargetItemIndex = -1;

  bool get isDraggingColumn =>
      widget.allowColumnDragging && draggingColumnIndex >= 0;

  List<double> colSizes = List.empty(growable: true);
  Map<int, double>? colFraction;

  List<int>? colIndexes;

  bool dragging = false;
  int? colDragging;
  double? totalWidth;
  double? totalHeight;
  List<double>? previousColSizes;
  Map<int, double>? previousColFraction;

  int get colCount => colSizes.length;

  BorderSide get _defaultHeaderBorder => BorderSide(
        color: ListTableTheme.of(context).borderColor!,
        width: 1.0,
      );

  ScrollController? currentController;
  ScrollController get controller =>
      widget.controller ?? (currentController ??= ScrollController());

  Widget createHeaderFeedback(int col, double colWidth) {
    return FeedbackColumn(
      backgroundColor:
          Theme.of(context).colorScheme.background[0].withOpacity(0.85),
      col: col,
      itemSize: Size(colWidth, totalHeight!),
      header: FeedbackHeaderItem(
        builder: widget.header.builder ??
            (context, index) => widget.header.children![index],
        columnBorder: widget.tableBorder?.top ?? BorderSide.none,
        itemExtent: widget.header.itemExtent ?? _kHeaderHeight,
        decoration: widget.header.decoration,
      ),
      rows: widget.rows
          .map((rowItem) => FeedbackRowItem(
                builder: rowItem.builder ??
                    (context, index) => rowItem.children![index],
                // Ignores the [ListTable.itemExtent] null value for now.
                itemExtent: rowItem.itemExtent ?? _kHeaderHeight,
              ))
          .toList(),
      tableBorder: widget.tableBorder ?? const TableBorder(),
    );
  }

  Widget createHeader() {
    final List<int> colElemIndexes = [];

    for (int i = 0; i < colSizes.length; i += 1) {
      if (colSizes[i] > 0.0 || i == draggingColumnIndex) {
        colElemIndexes.add(i);
      }
    }

    return ListRow(
      bottomBorder: widget.tableBorder?.top ?? BorderSide.none,
      colSizes: colElemIndexes.map((e) => colSizes[e]).toList(),
      itemExtent: widget.header.itemExtent,
      backgroundColor: Theme.of(context).colorScheme.background[0],
      decoration: widget.header.decoration,
      children: List<Widget>.generate(colElemIndexes.length, (index) {
        final int col = colElemIndexes[index];

        assert(col < colSizes.length);

        final int mappedIndex = colIndexes?[col] ?? col;

        final Widget result = widget.header.builder != null
            ? widget.header.builder!(
                context,
                mappedIndex,
              )
            : widget.header.children![mappedIndex];

        if (!widget.allowColumnDragging || widget.colCount <= 1) {
          return result;
        }

        return MouseRegion(
          hitTestBehavior: HitTestBehavior.deferToChild,
          cursor:
              isDraggingColumn ? MouseCursor.defer : SystemMouseCursors.click,
          child: LongPressDraggable<int>(
            data: col,
            childWhenDragging: const SizedBox(),
            onDragStarted: () {
              setState(() {
                draggingColumnIndex = col;
                draggingColumnTargetIndex = -1;
                draggingColumnTargetItemIndex = -1;
              });
            },
            onDraggableCanceled: (_, __) {
              setState(() => draggingColumnIndex = -1);
            },
            onDragEnd: (details) {
              setState(() => draggingColumnIndex = -1);
            },
            onDragCompleted: () {
              setState(() => draggingColumnIndex = -1);
            },
            maxSimultaneousDrags: 1,
            feedback: createHeaderFeedback(mappedIndex, colSizes[col]),
            child: Container(
              color: Theme.of(context).colorScheme.background[0],
              height: widget.header.itemExtent,
              width: colSizes[col],
              child: result,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget createListItem(int index) {
    final List<int> colElemIndexes = [];

    for (int i = 0; i < colSizes.length; i += 1) {
      if (colSizes[i] > 0.0) {
        colElemIndexes.add(i);
      }
    }

    final ListTableRow tableRow = widget.rows[index];

    final ListTableThemeData listTableThemeData = ListTableTheme.of(context);

    final Color? backgroundColor =
        pressedIndex == index || waitingIndex == index
            ? listTableThemeData.highlightColor
            : hoveredIndex == index
                ? listTableThemeData.hoverColor
                : null;

    final BorderSide bottomBorder = widget.tableBorder != null &&
            (widget.tableBorder!.horizontalInside != BorderSide.none) &&
            (index < widget.rows.length - 1)
        ? widget.tableBorder!.horizontalInside
        : BorderSide.none;

    final bool isHoveredEnabled =
        tableRow.onPressed != null && !dragging && !isDraggingColumn;

    return MouseRegion(
      onEnter: (_) =>
          isHoveredEnabled ? setState(() => hoveredIndex = index) : null,
      onExit: (_) =>
          isHoveredEnabled ? setState(() => hoveredIndex = -1) : null,
      hitTestBehavior: HitTestBehavior.deferToChild,
      cursor: tableRow.onPressed != null && !isDraggingColumn
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapUp: tableRow.onPressed != null
            ? (event) {
                final overlay = Overlay.of(context).context.findRenderObject();
                final position = RelativeRect.fromRect(
                  Offset(event.globalPosition.dx, event.globalPosition.dy) &
                      Size.zero,
                  overlay!.semanticBounds,
                );

                if (waitingIndex == index) {
                  return;
                }
                waitingIndex = index;
                final dynamic result =
                    tableRow.onPressed?.call(position) as dynamic;
                if (result is Future) {
                  setState(() => waitingIndex = index);
                  result.then((_) => setState(() => waitingIndex = -1));
                } else {
                  waitingIndex = -1;
                }
                setState(() => pressedIndex = -1);
              }
            : null,
        onTapDown: tableRow.onPressed != null
            ? (_) => setState(() => pressedIndex = index)
            : null,
        onTapCancel: tableRow.onPressed == null
            ? () => setState(() => pressedIndex = -1)
            : null,
        onSecondaryTapUp: tableRow.onSecondaryPress != null
            ? (event) {
                final overlay = Overlay.of(context).context.findRenderObject();
                final position = RelativeRect.fromRect(
                  Offset(event.globalPosition.dx, event.globalPosition.dy) &
                      Size.zero,
                  overlay!.semanticBounds,
                );

                if (waitingIndex == index) {
                  return;
                }
                waitingIndex = index;
                final dynamic result =
                    tableRow.onSecondaryPress?.call(position) as dynamic;
                if (result is Future) {
                  setState(() => waitingIndex = index);
                  result.then((_) => setState(() => waitingIndex = -1));
                } else {
                  waitingIndex = -1;
                }
                setState(() => pressedIndex = -1);
              }
            : null,
        onSecondaryTapDown: tableRow.onSecondaryPress != null
            ? (_) => setState(() => pressedIndex = index)
            : null,
        onSecondaryTapCancel: tableRow.onSecondaryPress != null
            ? () => setState(() => pressedIndex = -1)
            : null,
        behavior: HitTestBehavior.deferToChild,
        child: ListRow(
          decoration: tableRow.decoration,
          backgroundColor: backgroundColor,
          bottomBorder: bottomBorder,
          colSizes: colSizes.where((e) => e > 0.0).toList(),
          itemExtent: tableRow.itemExtent,
          children: List.generate(colElemIndexes.length, (index) {
            final int col = colElemIndexes[index];
            final int mappedIndex = colIndexes?[col] ?? col;

            assert(col < colSizes.length);

            return tableRow.builder != null
                ? tableRow.builder!(
                    context,
                    mappedIndex,
                  )
                : tableRow.children![mappedIndex];
          }).toList(),
        ),
      ),
    );
  }

  Widget createDraggingTarget(int index, int targetIndex) {
    final List<int> indexes = [];

    for (int i = 0; i < colSizes.length; i += 1) {
      if (colSizes[i] > 0.0) {
        indexes.add(i);
      }
    }

    return DragTarget<int>(
      onMove: (details) {
        setState(() {
          draggingColumnTargetItemIndex = targetIndex;
          draggingColumnTargetIndex = index;
        });
      },
      onAccept: (columnIndex) {
        colIndexes ??= List.generate(widget.colCount, (x) => x);

        final int mappedIndex = colIndexes![columnIndex];

        colIndexes![columnIndex] = -1;

        if (draggingColumnTargetIndex == widget.colCount - 1) {
          colIndexes!.add(mappedIndex);
        } else {
          colIndexes!.insert(indexes[draggingColumnTargetIndex], mappedIndex);
        }

        colIndexes!.removeWhere((element) => element == -1);

        widget.onColumnIndexMappingChanged?.call(List.from(colIndexes!));
      },
      builder: (context, candidateData, rejectedData) => const SizedBox(),
    );
  }

  void calculateColFractions() {
    final int colCount = widget.colCount;

    colFraction ??= Map<int, double>.from(widget.colFraction ?? {});

    if (totalWidth! < _kMinColumnWidth) {
      return;
    }

    if (colCount == 0) {
      throw Exception('The number of columns must not be zero.');
    } else if (colCount == 1) {
      return;
    }

    double remWidth = totalWidth!;

    int nfactors = 0;
    for (final value in colFraction!.keys) {
      if (value < colCount) {
        nfactors += 1;
        final double fraction = clampDouble(colFraction![value]!, 0.0, 1.0);
        colFraction![value] = fraction;
        remWidth -= totalWidth! * fraction;
      }
    }

    // If there's no key for every index.
    if (nfactors < colCount) {
      int remNFactors = colCount - nfactors;
      // The width for each remaining item.
      final double nonFactorWidth =
          remWidth > 0.0 ? remWidth / remNFactors : 0.0;

      for (var i = 0; i < colCount; i++) {
        if (!colFraction!.containsKey(i)) {
          remNFactors -= 1;

          if (remWidth < _kMinColumnWidth) {
            colFraction![i] = 0.0;
            continue;
          }

          // last item
          if (i == colCount - 1 || remNFactors == 0) {
            colFraction![i] = remWidth / totalWidth!;
            remWidth = 0;
            break;
          }

          final double fraction =
              clampDouble(nonFactorWidth / totalWidth!, 0.0, 1.0);
          colFraction![i] = fraction;
          remWidth -= totalWidth! * fraction;
        }
      }
    }
  }

  void calculateColSizes() {
    final int colCount = widget.colCount;
    colSizes = List<double>.filled(colCount, 0.0);

    if (colCount == 1) {
      colSizes[0] = totalWidth!;
      return;
    }

    double remWidth = totalWidth!;

    for (int i = 0; i < colCount; i++) {
      if (remWidth <= 0.0) {
        remWidth = 0.0;
        break;
      }

      final int mappedIndex = colIndexes?[i] ?? i;

      if (colFraction!.containsKey(mappedIndex)) {
        if (draggingColumnIndex == i) {
          colSizes[i] = 0.0;
        } else if (remWidth >= _kMinColumnWidth) {
          double width = colFraction![mappedIndex]! * totalWidth!;

          if (!dragging || colDragging! > i) {
            width = width.roundToDouble();
          }

          width = clampDouble(width, _kMinColumnWidth, remWidth);

          colSizes[i] = width;
          remWidth -= width;

          if (remWidth < 0.0) {
            throw Exception(
                'Wrong fraction value at index $i, value ${colFraction![mappedIndex]} with $remWidth width.');
          }
        } else {
          break;
        }
      } else {
        throw Exception('Could not find fraction for index $i.');
      }
    }

    if (remWidth > 0.0) {
      final int key = colSizes.lastIndexWhere((value) => value > 0.0);
      colSizes[key] = colSizes[key] + remWidth;
    }
  }

  void dragStart(int col) {
    previousColFraction = Map<int, double>.from(colFraction!);
    previousColSizes = List<double>.from(colSizes);

    dragging = true;
    colDragging = col;
  }

  void dragUpdate(int col, double delta) {
    setState(() {
      final int totalRemaining = colCount - (col + 1);

      final int mappedIndex = colIndexes?[col] ?? col;

      if (delta < 0) {
        delta =
            clampDouble(delta, -previousColSizes![col] + _kMinColumnWidth, 0.0);
      } else {
        delta = clampDouble(delta, 0.0, delta);
      }

      final double newWidth = previousColSizes![col] + delta;
      colFraction![mappedIndex] = newWidth / totalWidth!;

      if (totalRemaining > 0) {
        final double valueEachDelta = -delta / totalRemaining;

        for (var i = col + 1; i < colCount; i++) {
          final int mappedIndex = colIndexes?[i] ?? i;
          final double newWidth = previousColSizes![i] + valueEachDelta;

          colFraction![mappedIndex] = newWidth / totalWidth!;
        }
      }
    });
  }

  void dragEnd() {
    setState(() {
      dragging = false;
      totalWidth = null;
      previousColSizes = null;
      previousColFraction = null;
      colDragging = null;
    });
  }

  void dragCancel() => dragEnd();

  bool get showScrollbar => !dragging && !isDraggingColumn;

  @override
  void initState() {
    super.initState();

    if (widget.allowColumnDragging && widget.columnIndexMapping != null) {
      colIndexes = widget.columnIndexMapping;

      for (int i = 0; i < widget.colCount; i += 1) {
        if (!colIndexes!.contains(i)) {
          throw Exception('Must have valid index in `columnIndexMapping`.');
        }
      }
    }
  }

  @override
  void didUpdateWidget(ListTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.colFraction != colFraction) {
      setState(() {
        colFraction = null;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      if (controller.hasClients) {
        final position = controller.position;
        position.didUpdateScrollPositionBy(0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ListTableThemeData listTableTheme = ListTableTheme.of(context);

    final Widget result = LayoutBuilder(
      builder: (context, constraints) {
        totalWidth = constraints.maxWidth;
        totalHeight = constraints.maxHeight;

        calculateColFractions();
        calculateColSizes();

        final List<Widget> targetChildren = [];

        if (isDraggingColumn) {
          assert(colCount == colSizes.length);

          int y = 0;

          for (int i = 0; i < colSizes.length; i += 1) {
            if (colSizes[i] > 0.0 || i == draggingColumnIndex) {
              targetChildren.add(createDraggingTarget(i, y));
              y += 1;
            }
          }
        }

        if (constraints.maxHeight.isFinite) {
          return Stack(
            children: [
              Column(
                children: [
                  createHeader(),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        scrollbars: showScrollbar,
                      ),
                      child: ListView.custom(
                        childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) => createListItem(index),
                          childCount: widget.rows.length,
                        ),
                        controller: controller,
                      ),
                    ),
                  ),
                ],
              ),
              _ListTableBorder(
                headerColumnBorder:
                    widget.header.columnBorder ?? _defaultHeaderBorder,
                tableBorder: widget.tableBorder ?? const TableBorder(),
                columnWidths: colSizes,
                headerExtent: _kHeaderHeight,
                dragCancel: dragCancel,
                dragEnd: dragEnd,
                dragStart: dragStart,
                dragUpdate: dragUpdate,
                highlightColor: listTableTheme.borderHighlightColor!,
                hoverColor: listTableTheme.borderHoverColor!,
                draggingColumnTargetItemIndex: draggingColumnTargetItemIndex,
                isDraggingColumn: isDraggingColumn,
                children: targetChildren,
              ),
            ],
          );
        } else {
          return _ListTableRows(
            headerColumnBorder:
                widget.header.columnBorder ?? _defaultHeaderBorder,
            tableBorder: widget.tableBorder ?? const TableBorder(),
            columnWidths: colSizes,
            headerExtent: _kHeaderHeight,
            dragCancel: dragCancel,
            dragEnd: dragEnd,
            dragStart: dragStart,
            dragUpdate: dragUpdate,
            highlightColor: listTableTheme.borderHighlightColor!,
            hoverColor: listTableTheme.borderHoverColor!,
            draggingColumnTargetItemIndex: draggingColumnTargetItemIndex,
            isDraggingColumn: isDraggingColumn,
            rowCount: widget.rows.length + 1,
            targetCount: targetChildren.length,
            children: [
              createHeader(),
              ...List.generate(
                widget.rows.length,
                (index) => Builder(
                  builder: (context) => createListItem(index),
                ),
              ),
              ...targetChildren
            ],
          );
        }
      },
    );

    return result;
  }
}

class _ListTableBorder extends MultiChildRenderObjectWidget {
  const _ListTableBorder({
    required super.children,
    required this.headerColumnBorder,
    required this.tableBorder,
    required this.columnWidths,
    required this.headerExtent,
    required this.dragCancel,
    required this.dragEnd,
    required this.dragStart,
    required this.dragUpdate,
    required this.highlightColor,
    required this.hoverColor,
    required this.draggingColumnTargetItemIndex,
    required this.isDraggingColumn,
  });

  final TableBorder tableBorder;
  final BorderSide headerColumnBorder;
  final List<double> columnWidths;
  final double headerExtent;
  final Color highlightColor;
  final Color hoverColor;
  final void Function(int col) dragStart;
  final void Function(int col, double value) dragUpdate;
  final void Function() dragEnd;
  final void Function() dragCancel;
  final int draggingColumnTargetItemIndex;
  final bool isDraggingColumn;

  @override
  ListTableRender createRenderObject(BuildContext context) => ListTableRender(
        tableBorder: tableBorder,
        headerColumnBorder: headerColumnBorder,
        columnWidths: columnWidths,
        headerExtent: headerExtent,
        dragCancel: dragCancel,
        dragEnd: dragEnd,
        dragStart: dragStart,
        dragUpdate: dragUpdate,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
        draggingColumnTargetItemIndex: draggingColumnTargetItemIndex,
        isDraggingColumn: isDraggingColumn,
      );

  @override
  void updateRenderObject(BuildContext context, ListTableRender renderObject) {
    renderObject
      ..headerColumnBorder = headerColumnBorder
      ..tableBorder = tableBorder
      ..columnWidths = columnWidths
      ..headerExtent = headerExtent
      ..highlightColor = highlightColor
      ..hoverColor = hoverColor
      ..isDraggingColumn = isDraggingColumn
      ..draggingColumnTargetItemIndex = draggingColumnTargetItemIndex;
  }
}

class _ListTableRows extends MultiChildRenderObjectWidget {
  const _ListTableRows({
    required super.children,
    required this.headerColumnBorder,
    required this.tableBorder,
    required this.columnWidths,
    required this.headerExtent,
    required this.dragCancel,
    required this.dragEnd,
    required this.dragStart,
    required this.dragUpdate,
    required this.highlightColor,
    required this.hoverColor,
    required this.draggingColumnTargetItemIndex,
    required this.isDraggingColumn,
    required this.rowCount,
    required this.targetCount,
  }) : assert(children.length == rowCount + targetCount,
            'Invalid number of children');

  final TableBorder tableBorder;
  final BorderSide headerColumnBorder;
  final List<double> columnWidths;
  final double headerExtent;
  final Color highlightColor;
  final Color hoverColor;
  final void Function(int col) dragStart;
  final void Function(int col, double value) dragUpdate;
  final void Function() dragEnd;
  final void Function() dragCancel;
  final int draggingColumnTargetItemIndex;
  final bool isDraggingColumn;
  final int rowCount;
  final int targetCount;

  @override
  ListTableRender createRenderObject(BuildContext context) => ListTableRender(
        tableBorder: tableBorder,
        headerColumnBorder: headerColumnBorder,
        columnWidths: columnWidths,
        headerExtent: headerExtent,
        dragCancel: dragCancel,
        dragEnd: dragEnd,
        dragStart: dragStart,
        dragUpdate: dragUpdate,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
        draggingColumnTargetItemIndex: draggingColumnTargetItemIndex,
        isDraggingColumn: isDraggingColumn,
        rowCount: rowCount,
        targetCount: targetCount,
      );

  @override
  void updateRenderObject(BuildContext context, ListTableRender renderObject) {
    renderObject
      ..headerColumnBorder = headerColumnBorder
      ..tableBorder = tableBorder
      ..columnWidths = columnWidths
      ..headerExtent = headerExtent
      ..highlightColor = highlightColor
      ..hoverColor = hoverColor
      ..isDraggingColumn = isDraggingColumn
      ..draggingColumnTargetItemIndex = draggingColumnTargetItemIndex
      ..rowCount = rowCount
      ..targetCount = targetCount;
  }
}
