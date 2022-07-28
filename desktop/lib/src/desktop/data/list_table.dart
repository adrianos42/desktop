import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../theme/theme.dart';
import 'list_table_render.dart';

const _kHeaderHeight = 40.0;
const _kMinColumnWidth = 48.0;
const _kHandlerWidth = 12.0;

/// The builder for the table header.
typedef TableHeaderBuilder = Widget Function(
  BuildContext context,
  int col,
);

/// The builder for the table row.
typedef TableRowBuilder = Widget Function(
  BuildContext context,
  int row,
  int col,
);

///
typedef RowPressedCallback = void Function(int index, RelativeRect position);

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
    required this.itemCount,
    required this.tableHeaderBuilder,
    required this.tableRowBuilder,
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
        );

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

  /// If the last column should collapse if it does not fit the minimum width anymore.
  // TODO(as): final bool collapseOnDrag;

  @override
  _ListTableState createState() => _ListTableState();
}

class _ListTableState extends State<ListTable> {
  bool shouldReactToPrimaryPress = false;
  bool shouldReactToSecondaryPress = false;

  int hoveredIndex = -1;
  int pressedIndex = -1;
  int waitingIndex = -1;
  int draggingColumnIndex = -1;
  int draggingColumnTargetIndex = -1;

  bool get isDraggingColumn =>
      widget.allowColumnDragging && draggingColumnIndex >= 0;

  List<double> colSizes = List.empty(growable: true);
  Map<int, double>? colFraction;

  List<int>? colIndexes;

  bool dragging = false;
  int? colDragging;
  double? previousWidth;
  double? totalWidth;
  double? totalHeight;
  List<double>? previousColSizes;
  Map<int, double>? previousColFraction;

  int get colCount => colSizes.length;

  ScrollController? currentController;
  ScrollController get controller =>
      widget.controller ?? (currentController ??= ScrollController());

  Widget createHeaderFeedback(int col, int lastNonZero) {
    final int mappedIndex = colIndexes?[col] ?? col;

    final TableBorder? tableBorder = widget.tableBorder;
    final bool hasBorder = tableBorder != null &&
        (tableBorder.left != BorderSide.none ||
            tableBorder.right != BorderSide.none ||
            tableBorder.top != BorderSide.none ||
            tableBorder.bottom != BorderSide.none);
    final bool hasHeaderBorder =
        tableBorder != null && tableBorder.top != BorderSide.none;

    final BoxDecoration decoration = BoxDecoration(
      color: Theme.of(context).colorScheme.background[0].withOpacity(0.85),
      border: hasBorder
          ? Border(
              left: tableBorder.left,
              right: tableBorder.right,
              top: tableBorder.top,
              bottom: tableBorder.bottom,
            )
          : null,
    );

    return Container(
      width: colSizes[col],
      height: totalHeight!,
      decoration: decoration,
      child: UnconstrainedBox(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.topLeft,
        constrainedAxis: Axis.horizontal,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints.tightFor(
                width: colSizes[col],
                height: _kHeaderHeight,
              ),
              decoration: hasHeaderBorder
                  ? BoxDecoration(border: Border(bottom: tableBorder.top))
                  : null,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return widget.tableHeaderBuilder(
                    context,
                    mappedIndex,
                  );
                },
              ),
            ),
            ...List.generate(widget.itemCount, (index) {
              BoxDecoration decoration = const BoxDecoration();

              if (widget.tableBorder != null &&
                  (widget.tableBorder!.horizontalInside != BorderSide.none ||
                      widget.tableBorder!.verticalInside != BorderSide.none)) {
                final isBottom = index < widget.itemCount - 1 || hasExtent;
                final isRight = col < widget.colCount - 1 && col < lastNonZero;

                final horizontalInside = widget.tableBorder!.horizontalInside;
                final verticalInside = widget.tableBorder!.verticalInside;

                final bottom = isBottom ? horizontalInside : BorderSide.none;

                final right = isRight ? verticalInside : BorderSide.none;

                final border = Border(bottom: bottom, right: right);
                decoration = decoration.copyWith(border: border);
              }

              return DecoratedBox(
                decoration: decoration,
                child: widget.tableRowBuilder(
                  context,
                  index,
                  mappedIndex,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget createHeader() {
    final TableBorder? tableBorder = widget.tableBorder;
    final int lastNonZero = colSizes.lastIndexWhere((elem) => elem > 0.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: List<Widget>.generate(colCount, (col) {
        assert(col < colSizes.length);

        final int mappedIndex = colIndexes?[col] ?? col;

        Widget result;

        if (colSizes[col] == 0.0 && draggingColumnIndex != col) {
          return Container(); // TODO
        }

        result = widget.tableHeaderBuilder(
          context,
          mappedIndex,
        );

        result = Container(
          color: Theme.of(context).colorScheme.background[0],
          constraints: BoxConstraints.tightFor(
            height: _kHeaderHeight,
            width: colSizes[col],
          ),
          child: result,
        );

        if (!widget.allowColumnDragging || widget.colCount <= 1) {
          return result;
        }

        return MouseRegion(
          hitTestBehavior: HitTestBehavior.deferToChild,
          cursor:
              isDraggingColumn ? MouseCursor.defer : SystemMouseCursors.click,
          child: LongPressDraggable<int>(
            data: col,
            child: result,
            childWhenDragging: const SizedBox(),
            onDragStarted: () {
              setState(() {
                draggingColumnIndex = col;
                draggingColumnTargetIndex = -1;
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
            feedback: createHeaderFeedback(col, lastNonZero),
          ),
        );
      }).toList(),
    );
  }

  Widget createList(int index) {
    final List<int> colElemIndexes = List.empty(growable: true);

    for (int i = 0; i < colSizes.length; i += 1) {
      if (colSizes[i] > 0.0) {
        colElemIndexes.add(i);
      }
    }

    final ListTableThemeData listTableThemeData = ListTableTheme.of(context);

    final Color? backgroundColor =
        pressedIndex == index || waitingIndex == index
            ? listTableThemeData.highlightColor
            : hoveredIndex == index
                ? listTableThemeData.hoverColor
                : (index.isEven
                    ? Theme.of(context).colorScheme.background[0]
                    : Theme.of(context).colorScheme.background[4]);

    BoxDecoration decoration = BoxDecoration(color: backgroundColor);

    if (widget.tableBorder != null &&
        (widget.tableBorder!.horizontalInside != BorderSide.none)) {
      final isBottom = index < widget.itemCount - 1 || hasExtent;

      final horizontalInside = widget.tableBorder!.horizontalInside;

      final bottom = isBottom ? horizontalInside : BorderSide.none;

      final border = Border(bottom: bottom);
      //decoration = decoration.copyWith(border: border);
    }

    return MouseRegion(
      onEnter: (_) => dragging || isDraggingColumn
          ? null
          : setState(() => hoveredIndex = index),
      onExit: (_) => dragging || isDraggingColumn
          ? null
          : setState(() => hoveredIndex = -1),
      hitTestBehavior: HitTestBehavior.deferToChild,
      cursor: widget.onPressed != null && !isDraggingColumn
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapUp: widget.onPressed != null
            ? (event) {
                final overlay = Overlay.of(context)!.context.findRenderObject();
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
                    widget.onPressed?.call(index, position) as dynamic;
                if (result is Future) {
                  setState(() => waitingIndex = index);
                  result.then((_) => setState(() => waitingIndex = -1));
                } else {
                  waitingIndex = -1;
                }
                setState(() => pressedIndex = -1);
              }
            : null,
        onTapDown: widget.onPressed != null
            ? (_) => setState(() => pressedIndex = index)
            : null,
        onTapCancel: () => setState(() => pressedIndex = -1),
        onSecondaryTapUp: widget.onSecondaryPress != null
            ? (event) {
                final overlay = Overlay.of(context)!.context.findRenderObject();
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
                    widget.onSecondaryPress?.call(index, position) as dynamic;
                if (result is Future) {
                  setState(() => waitingIndex = index);
                  result.then((_) => setState(() => waitingIndex = -1));
                } else {
                  waitingIndex = -1;
                }
                setState(() => pressedIndex = -1);
              }
            : null,
        onSecondaryTapDown: widget.onSecondaryPress != null
            ? (_) => setState(() => pressedIndex = index)
            : null,
        onSecondaryTapCancel: () => setState(() => pressedIndex = -1),
        behavior: HitTestBehavior.deferToChild,
        child: DecoratedBox(
          decoration: decoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(colElemIndexes.length, (colIndex) {
              final int col = colElemIndexes[colIndex];
              final int mappedIndex = colIndexes?[col] ?? col;

              assert(col < colSizes.length);

              Widget result = LayoutBuilder(
                builder: (context, constraints) => widget.tableRowBuilder(
                  context,
                  index,
                  mappedIndex,
                ),
              );

              result = Align(alignment: Alignment.bottomLeft, child: result);

              // TODO(as): ???
              // if (widget.tableBorder != null &&
              //     (widget.tableBorder!.horizontalInside != BorderSide.none ||
              //         widget.tableBorder!.verticalInside != BorderSide.none)) {
              //   final isBottom = index < widget.itemCount - 1 || hasExtent;
              //   final isRight = col < colElemIndexes.length - 1;

              //   final horizontalInside = widget.tableBorder!.horizontalInside;
              //   final verticalInside = widget.tableBorder!.verticalInside;

              //   final bottom = isBottom ? horizontalInside : BorderSide.none;

              //   // TODO(as): ???
              //   final headerColumnBorder = widget.headerColumnBorder ??
              //       widget.tableBorder?.verticalInside;
              //   final dragBorderWidth = headerColumnBorder != null &&
              //           headerColumnBorder != BorderSide.none
              //       ? headerColumnBorder.width +
              //           (headerColumnBorder.width / 2.0).roundToDouble()
              //       : 2.0;

              //   final right = // FIXME HERE
              //       dragging && colDragging == col
              //           ? BorderSide(
              //               color: listTableThemeData.borderHighlightColor!,
              //               width: dragBorderWidth,
              //             )
              //           : isRight
              //               ? verticalInside
              //               : BorderSide.none;

              //   final border = Border(bottom: bottom, right: right);
              //   decoration = decoration.copyWith(border: border);
              // } else if (dragging && colDragging == col) {
              //   final right = BorderSide(
              //     color: dragging
              //         ? listTableThemeData.borderHighlightColor!
              //         : listTableThemeData.borderColor!,
              //     width: 2.0,
              //   );

              //   final border = Border(right: right);
              //   decoration = decoration.copyWith(border: border);
              // }
              return ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: colSizes[col],
                ),
                child: result,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget createDraggingTarget() {
    return LayoutBuilder(builder: (context, constraints) {
      final List<int> indexes = List.empty(growable: true);

      for (int i = 0; i < colSizes.length; i += 1) {
        if (colSizes[i] > 0.0) {
          indexes.add(i);
        }
      }

      final TableBorder tableBorder = widget.tableBorder ?? const TableBorder();

      final TableBorder border = TableBorder(
        left: tableBorder.left != BorderSide.none
            ? tableBorder.left
            : const BorderSide(),
        right: tableBorder.right != BorderSide.none
            ? tableBorder.right
            : const BorderSide(),
        verticalInside: tableBorder.verticalInside != BorderSide.none
            ? tableBorder.verticalInside
            : const BorderSide(),
        top: tableBorder.top,
        bottom: tableBorder.bottom,
      );

      final ListTableThemeData listTableThemeData = ListTableTheme.of(context);

      final Color firstBorderColor = draggingColumnTargetIndex == 0
          ? listTableThemeData.borderHoverColor!
          : listTableThemeData.borderColor!;

      final Color lastBorderColor =
          draggingColumnTargetIndex == widget.colCount - 1
              ? listTableThemeData.borderHoverColor!
              : listTableThemeData.borderColor!;

      return DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: Border(
            top: border.top,
            bottom: border.bottom,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              left: border.left.copyWith(
                  color: firstBorderColor,
                  width: draggingColumnTargetIndex == 0 ? 2.0 : 1.0),
              right: border.right.copyWith(
                color: lastBorderColor,
                width: draggingColumnTargetIndex == widget.colCount - 1
                    ? 2.0
                    : 1.0,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(widget.colCount, (index) {
              final bool isLast = index == widget.colCount - 1;
              final int col = isLast ? indexes[index - 1] : indexes[index];

              return DragTarget<int>(
                onMove: (details) {
                  setState(() => draggingColumnTargetIndex = index);
                },
                onAccept: (columnIndex) {
                  colIndexes ??=
                      List.generate(widget.colCount, (index) => index);

                  final int mappedIndex = colIndexes![columnIndex];

                  colIndexes![columnIndex] = -1;

                  if (draggingColumnTargetIndex == widget.colCount - 1) {
                    colIndexes!.add(mappedIndex);
                  } else {
                    colIndexes!.insert(
                        indexes[draggingColumnTargetIndex], mappedIndex);
                  }

                  colIndexes!.removeWhere((element) => element == -1);

                  widget.onColumnIndexMappingChanged
                      ?.call(List.from(colIndexes!));
                },
                builder: (context, candidateData, rejectedData) {
                  final Color color = draggingColumnTargetIndex == index
                      ? listTableThemeData.borderHoverColor!
                      : listTableThemeData.borderColor!;

                  final double width = isLast || index == colSizes.length - 2
                      ? (colSizes[col] / 2.0).floorToDouble()
                      : colSizes[col];

                  final double borderWidth =
                      draggingColumnTargetIndex == index ? 2.0 : 1.0;

                  return Container(
                    width: width,
                    decoration: BoxDecoration(
                      border: Border(
                        left: index > 0 && !isLast
                            ? border.verticalInside.copyWith(
                                color: color,
                                width: borderWidth,
                              )
                            : BorderSide.none,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      );
    });
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
        final double fraction = colFraction![value]!.clamp(0.0, 1.0);
        colFraction![value] = fraction;
        remWidth -= (totalWidth! * fraction).truncateToDouble();
      }
    }

    // If there's no key for every index.
    if (nfactors < colCount) {
      int remNFactors = colCount - nfactors;
      // The width for each remaining item.
      final double nonFactorWidth =
          remWidth > 0.0 ? (remWidth / remNFactors).truncateToDouble() : 0.0;

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
              (nonFactorWidth / totalWidth!).clamp(0.0, 1.0);
          colFraction![i] = fraction;
          remWidth -= (totalWidth! * fraction).truncateToDouble();
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
        if (remWidth >= _kMinColumnWidth) {
          // The last item.
          if (i == colCount - 1 ||
              (draggingColumnIndex == colCount - 1 && i == colCount - 2)) {
            colSizes[i] = remWidth;

            remWidth = 0.0;
            break;
          }

          double width = (colFraction![mappedIndex]! * totalWidth!)
              .clamp(_kMinColumnWidth, remWidth);

          width = draggingColumnIndex == i ? 0 : width.floorToDouble();
          colSizes[i] = width;

          remWidth -= width;

          if (remWidth < 0.0) {
            throw Exception(
                'Wrong fraction value at index $i, value ${colFraction![mappedIndex]}.');
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

    previousWidth = colSizes.sublist(col).reduce((v, e) => v + e);
    dragging = true;
    colDragging = col;
  }

  void dragUpdate(int col, double delta) {
    setState(() {
      final int totalRemain = colCount - (col + 1);

      final int mappedIndex = colIndexes?[col] ?? col;

      if (delta < 0) {
        delta = delta.clamp(-previousColSizes![col] + _kMinColumnWidth, 0.0);
      } else {
        // Calculates the maximum value for delta.
        // final maxDeltaWidth = true
        //     ? previousWidth! - previousColSizes![col]
        //     : previousWidth! -
        //         (totalRemain * _kMinColumnWidth) -
        //         previousColSizes![col];

        // if (maxDeltaWidth < 0.0) {
        //   throw Exception('Invalid delta value in list table.');
        // }

        delta = delta.clamp(0.0, delta);
      }

      final double newWidth = previousColSizes![col] + delta;
      colFraction![mappedIndex] = newWidth / totalWidth!;

      if (totalRemain > 0) {
        final double valueEach = (delta / totalRemain).truncateToDouble();
        double remWidth = previousWidth! - newWidth;

        // final double firstNewWidth =
        //     (previousColSizes![col + 1] - (delta / totalRemain))
        //         .clamp(_kMinColumnWidth, remWidth)
        //         .truncateToDouble();

        // colFraction![col + 1] = firstNewWidth / totalWidth!;
        // remWidth -= firstNewWidth;

        for (var i = col + 1; i < colCount; i++) {
          final int mappedIndex = colIndexes?[i] ?? i;

          if (remWidth >= _kMinColumnWidth) {
            final double newWidth = (previousColSizes![i] - valueEach)
                .clamp(_kMinColumnWidth, remWidth);
            colFraction![mappedIndex] = newWidth / totalWidth!;

            remWidth -= newWidth;
          } else {
            colFraction![mappedIndex] = 0.0;
          }
        }

        // if (!widget.collapseOnDrag &&
        //     colFraction!.values.any((e) => e == 0.0)) {
        // TODO(as): Proper calculation.
        //   for (var i = colCount - 1; i >= col + 1; i--) {
        //     if (colFraction![i] == 0.0) {
        //       colFraction![i] = _kMinColumnWidth / totalWidth!;
        //       colFraction![i - 1] =
        //           colFraction![i - 1]! - _kMinColumnWidth / totalWidth!;
        //     }
        //   }
        // }
      }
    });
  }

  void dragEnd() {
    setState(() {
      dragging = false;
      totalWidth = null;
      previousWidth = null;
      previousColSizes = null;
      previousColFraction = null;
      colDragging = null;
    });
  }

  void dragCancel() => dragEnd();

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

  bool hasExtent = false;

  bool get showScrollbar => !dragging;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      final position = controller.position;
      position.didUpdateScrollPositionBy(0.0);
      //hasExtent = position.maxScrollExtent > position.minScrollExtent;
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

        return Stack(
          children: [
            Column(
              children: [
                createHeader(),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: showScrollbar),
                    child: ListView.custom(
                      childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) => createList(index),
                        childCount: widget.itemCount,
                      ),
                      controller: controller,
                      itemExtent: widget.itemExtent,
                    ),
                  ),
                ),
              ],
            ),
            _ListTableBorder(
              headerColumnBorder: widget.headerColumnBorder ??
                  widget.tableBorder?.verticalInside ??
                  BorderSide.none,
              tableBorder: widget.tableBorder ?? const TableBorder(),
              colSizes: colSizes,
              headerExtent: _kHeaderHeight,
              dragCancel: dragCancel,
              dragEnd: dragEnd,
              dragStart: dragStart,
              dragUpdate: dragUpdate,
              highlightColor: listTableTheme.borderHighlightColor!,
              hoverColor: listTableTheme.borderHoverColor!,
            ),
          ],
        );
      },
    );

    return result;
  }
}

class _ListTableBorder extends LeafRenderObjectWidget {
  const _ListTableBorder({
    Key? key,
    required this.headerColumnBorder,
    required this.tableBorder,
    required this.colSizes,
    required this.headerExtent,
    required this.dragCancel,
    required this.dragEnd,
    required this.dragStart,
    required this.dragUpdate,
    required this.highlightColor,
    required this.hoverColor,
  }) : super(key: key);

  final TableBorder tableBorder;
  final BorderSide headerColumnBorder;
  final List<double> colSizes;
  final double headerExtent;
  final Color highlightColor;
  final Color hoverColor;
  final void Function(int col) dragStart;
  final void Function(int col, double value) dragUpdate;
  final void Function() dragEnd;
  final void Function() dragCancel;

  @override
  ListTableRender createRenderObject(BuildContext context) => ListTableRender(
        tableBorder: tableBorder,
        headerColumnBorder: headerColumnBorder,
        colSizes: colSizes,
        headerExtent: headerExtent,
        dragCancel: dragCancel,
        dragEnd: dragEnd,
        dragStart: dragStart,
        dragUpdate: dragUpdate,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
      );

  @override
  void updateRenderObject(BuildContext context, ListTableRender renderObject) {
    renderObject
      ..headerColumnBorder = headerColumnBorder
      ..tableBorder = tableBorder
      ..colSizes = colSizes
      ..headerExtent = headerExtent
      ..highlightColor = highlightColor
      ..hoverColor = hoverColor;
  }
}
