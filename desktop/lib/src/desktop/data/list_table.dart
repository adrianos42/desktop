import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../theme/theme.dart';

const _kHeaderHeight = 40.0;
const _kMinColumnWidth = 48.0;
const _kHandlerWidth = 12.0;

/// The builder for the table header.
typedef TableHeaderBuilder = Widget Function(
  BuildContext context,
  int col,
  BoxConstraints colConstraints,
);

/// The builder for the table row.
typedef TableRowBuilder = Widget Function(
  BuildContext context,
  int row,
  int col,
  BoxConstraints colConstraints,
);

///
typedef RowPressedCallback = void Function(int index, RelativeRect position);

/// Called when a column is dragged.
/// May be used to save the columns positions.
typedef ColumnIndexMappingCallback = void Function(List<int> indexMapping);

abstract class _TableDragUpdate {
  void dragStart(int col);
  void dragUpdate(int col, double value);
  void dragEnd();
  void dragCancel();
}

class _TableColHandler extends StatefulWidget {
  const _TableColHandler({
    required this.tableDragUpdate,
    required this.col,
    required this.hasIndicator,
    required this.draggingColumn,
    this.border,
    Key? key,
  }) : super(key: key);

  final bool hasIndicator;
  final _TableDragUpdate tableDragUpdate;
  final int col;
  final BorderSide? border;
  final bool draggingColumn;

  @override
  _TableColHandlerState createState() => _TableColHandlerState();
}

class _TableColHandlerState extends State<_TableColHandler>
    with ComponentStateMixin {
  Map<Type, GestureRecognizerFactory> get _gestures {
    final gestures = <Type, GestureRecognizerFactory>{};

    gestures[HorizontalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
      () => HorizontalDragGestureRecognizer(
        debugOwner: this,
      ),
      (HorizontalDragGestureRecognizer instance) {
        instance
          ..dragStartBehavior = DragStartBehavior.down
          ..onStart = _handleDragStart
          ..onDown = _handleDragDown
          ..onUpdate = _handleDragUpdate
          ..onCancel = _handleDragCancel
          ..onEnd = _handleDragEnd;
      },
    );

    return gestures;
  }

  double? currentPosition;
  _TableDragUpdate get tableUpdateColFactor => widget.tableDragUpdate;
  int get col => widget.col;

  void _handleDragStart(DragStartDetails details) {
    tableUpdateColFactor.dragStart(col);
    currentPosition = details.globalPosition.dx;
  }

  void _handleDragDown(DragDownDetails details) =>
      setState(() => dragged = true);

  void _handleDragUpdate(DragUpdateDetails details) {
    tableUpdateColFactor.dragUpdate(
        col, details.globalPosition.dx - currentPosition!);
  }

  void _handleDragEnd(DragEndDetails details) {
    setState(() => dragged = false);
    tableUpdateColFactor.dragEnd();
  }

  void _handleDragCancel() {
    setState(() => dragged = false);
    tableUpdateColFactor.dragCancel();
  }

  void _handleMouseEnter(PointerEnterEvent event) =>
      setState(() => hovered = true);

  void _handleMouseExit(PointerExitEvent event) =>
      setState(() => hovered = false);

  @override
  Widget build(BuildContext context) {
    final ListTableThemeData listTableTheme = ListTableTheme.of(context);

    BorderSide? border = widget.border;
    final bool expanded = hovered || dragged || widget.hasIndicator;

    if (border != null && border != BorderSide.none) {
      final Color borderColor = widget.draggingColumn
          ? const Color(0x00000000)
          : dragged
              ? listTableTheme.borderHighlightColor!
              : widget.draggingColumn
                  ? listTableTheme.borderColor!
                  : hovered
                      ? listTableTheme.borderHoverColor!
                      : widget.hasIndicator
                          ? listTableTheme.borderIndicatorColor!
                          : border.color;

      border = border.copyWith(
          color: borderColor,
          width: expanded
              ? border.width + (border.width / 2.0).roundToDouble()
              : border.width);
    } else {
      final width = expanded ? 2.0 : 1.0;
      final borderColor = dragged
          ? listTableTheme.borderHighlightColor!
          : widget.draggingColumn
              ? listTableTheme.borderColor!
              : hovered
                  ? listTableTheme.borderHoverColor!
                  : widget.hasIndicator
                      ? listTableTheme.borderIndicatorColor!
                      : listTableTheme.borderColor!;
      border = BorderSide(width: width, color: borderColor);
    }

    final Widget result = Container(
      margin: const EdgeInsets.only(left: _kHandlerWidth),
      decoration: BoxDecoration(border: Border(right: border)),
    );

    if (widget.draggingColumn) {
      return result;
    }

    return RawGestureDetector(
      gestures: _gestures,
      behavior: HitTestBehavior.translucent,
      child: MouseRegion(
        opaque: false,
        cursor: SystemMouseCursors.click,
        onEnter: _handleMouseEnter,
        onExit: _handleMouseExit,
        child: result,
      ),
    );
  }
}

/// A table with columns that can be resized.
class ListTable extends StatefulWidget {
  /// Creates a [ListTable].
  const ListTable({
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
    Key? key,
  })  : assert(colCount > 0),
        assert(itemExtent >= 0.0),
        assert(
          !allowColumnDragging ||
              columnIndexMapping == null ||
              columnIndexMapping.length == colCount,
        ),
        super(key: key);

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

class _ListTableState extends State<ListTable> implements _TableDragUpdate {
  var columnWidths = {};
  bool hasHiddenColumns = false;
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
        clipBehavior:
            Clip.antiAlias, // TODO(as): See if `hardEdge` can be used instead.
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
                    constraints,
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
                  BoxConstraints.tightFor(
                    width: colSizes[col],
                    height: _kHeaderHeight,
                  ),
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
    final bool hasBorder =
        tableBorder != null && tableBorder.top != BorderSide.none;

    final int lastNonZero = colSizes.lastIndexWhere((elem) => elem > 0.0);

    return Container(
      decoration: hasBorder
          ? BoxDecoration(
              border: Border(
                bottom: tableBorder.top,
              ),
            ) // TODO(as): ???
          : null,
      child: Row(
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

          if (colCount > 1 && col < colCount - 1) {
            result = Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return widget.tableHeaderBuilder(
                        context,
                        mappedIndex,
                        constraints,
                      );
                    },
                  ),
                ),
                _TableColHandler(
                  tableDragUpdate: this,
                  col: col,
                  hasIndicator: hasHiddenColumns && lastNonZero == col,
                  border:
                      widget.headerColumnBorder ?? tableBorder?.verticalInside,
                  draggingColumn: isDraggingColumn,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
            );
          } else {
            result = widget.tableHeaderBuilder(
              context,
              mappedIndex,
              BoxConstraints.tightFor(
                width: colSizes[col],
                height: _kHeaderHeight,
              ),
            );
          }

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
      ),
    );
  }

  Widget createList(int index) {
    final List<int> colElemIndexes = List.empty(growable: true);

    for (int i = 0; i < colSizes.length; i += 1) {
      if (colSizes[i] > 0.0) {
        colElemIndexes.add(i);
      }
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
                constraints,
              ),
            );

            result = Align(alignment: Alignment.bottomLeft, child: result);

            final ListTableThemeData listTableThemeData =
                ListTableTheme.of(context);

            final Color? backgroundColor =
                pressedIndex == index || waitingIndex == index
                    ? listTableThemeData.highlightColor
                    : hoveredIndex == index
                        ? listTableThemeData.hoverColor
                        : null;

            BoxDecoration decoration = BoxDecoration(color: backgroundColor);

            // TODO(as): ???
            if (widget.tableBorder != null &&
                (widget.tableBorder!.horizontalInside != BorderSide.none ||
                    widget.tableBorder!.verticalInside != BorderSide.none)) {
              final isBottom = index < widget.itemCount - 1 || hasExtent;
              final isRight = col < colElemIndexes.length - 1;

              final horizontalInside = widget.tableBorder!.horizontalInside;
              final verticalInside = widget.tableBorder!.verticalInside;

              final bottom = isBottom ? horizontalInside : BorderSide.none;

              // TODO(as): ???
              final headerColumnBorder = widget.headerColumnBorder ??
                  widget.tableBorder?.verticalInside;
              final dragBorderWidth = headerColumnBorder != null &&
                      headerColumnBorder != BorderSide.none
                  ? headerColumnBorder.width +
                      (headerColumnBorder.width / 2.0).roundToDouble()
                  : 2.0;

              final right = // FIXME HERE
                  dragging && colDragging == col
                      ? BorderSide(
                          color: listTableThemeData.borderHighlightColor!,
                          width: dragBorderWidth,
                        )
                      : isRight
                          ? verticalInside
                          : BorderSide.none;

              final border = Border(bottom: bottom, right: right);
              decoration = decoration.copyWith(border: border);
            } else if (dragging && colDragging == col) {
              final right = BorderSide(
                color: dragging
                    ? listTableThemeData.borderHighlightColor!
                    : listTableThemeData.borderColor!,
                width: 2.0,
              );

              final border = Border(right: right);
              decoration = decoration.copyWith(border: border);
            }
            return Container(
              constraints: BoxConstraints.tightFor(
                width: colSizes[col],
              ),
              decoration: decoration,
              child: result,
            );
          }).toList(),
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
        decoration: BoxDecoration(
          border: Border(
            left: border.left.copyWith(
                color: firstBorderColor,
                width: draggingColumnTargetIndex == 0 ? 2.0 : 1.0),
            right: border.right.copyWith(
                color: lastBorderColor,
                width: draggingColumnTargetIndex == widget.colCount - 1
                    ? 2.0
                    : 1.0),
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
                colIndexes ??= List.generate(widget.colCount, (index) => index);

                final int mappedIndex = colIndexes![columnIndex];

                colIndexes![columnIndex] = -1;

                if (draggingColumnTargetIndex == widget.colCount - 1) {
                  colIndexes!.add(mappedIndex);
                } else {
                  colIndexes!
                      .insert(indexes[draggingColumnTargetIndex], mappedIndex);
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

  @override
  void dragStart(int col) {
    previousColFraction = Map<int, double>.from(colFraction!);
    previousColSizes = List<double>.from(colSizes);

    previousWidth = colSizes.sublist(col).reduce((v, e) => v + e);
    dragging = true;
    colDragging = col;
  }

  @override
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

  @override
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

  @override
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      final position = controller.position;
      position.didUpdateScrollPositionBy(0.0);
      //hasExtent = position.maxScrollExtent > position.minScrollExtent;
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;

    if (notification.depth == 0) {
      // final y = metrics.maxScrollExtent <= metrics.minScrollExtent;
      // if (hasExtent != y) {
      // TODO(as): Necessary to show bottom border?
      //   setState(() => hasExtent = y);
      // }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    Widget result = LayoutBuilder(
      builder: (context, constraints) {
        totalWidth = constraints.maxWidth;
        totalHeight = constraints.maxHeight;

        calculateColFractions();
        calculateColSizes();

        hasHiddenColumns = !colSizes.every((elem) => elem > 0.0);

        return Column(
          children: [
            createHeader(),
            Expanded(
              child: ListView.custom(
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) => createList(index),
                  childCount: widget.itemCount,
                ),
                controller: controller,
                itemExtent: widget.itemExtent,
              ),
            ),
          ],
        );
      },
    );

    final TableBorder? tableBorder = widget.tableBorder;

    if (tableBorder != null &&
        (tableBorder.left != BorderSide.none ||
            tableBorder.right != BorderSide.none ||
            tableBorder.top != BorderSide.none ||
            tableBorder.bottom != BorderSide.none)) {
      result = Container(
        decoration: BoxDecoration(
          border: Border(
            left: isDraggingColumn
                ? BorderSide(width: tableBorder.left.width)
                : tableBorder.left,
            right: isDraggingColumn
                ? BorderSide(width: tableBorder.right.width)
                : tableBorder.right,
            top: tableBorder.top,
            bottom: tableBorder.bottom,
          ),
        ),
        child: result,
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: widget.allowColumnDragging
          ? Stack(
              children: [
                result,
                Visibility(
                  visible: isDraggingColumn,
                  child: createDraggingTarget(),
                )
              ],
            )
          : result,
    );
  }
}
