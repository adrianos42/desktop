import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../theme/theme.dart';

const _kHeaderHeight = 40.0;
const _kMinColumnWidth = 40.0;
const _kHandlerWidth = 8.0;
//const _kDefaultItemExtent = 40.0;

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
typedef RowPressedCallback = void Function(int index);

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
    Key? key,
  })  : assert(colCount > 0),
        assert(itemExtent >= 0.0),
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

  /// If the last column should collapse if it does not fit the minimum width anymore.
  // TODO(as): final bool collapseOnDrag;

  @override
  _ListTableState createState() => _ListTableState();
}

class _ListTableState extends State<ListTable> implements _TableDragUpdate {
  var columnWidths = {};
  bool hasHiddenColumns = false;

  int hoveredIndex = -1;
  int pressedIndex = -1;
  int waitingIndex = -1;

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

          if (colSizes[col] == 0.0) {
            return Container();
          }

          Widget result;

          if (colCount > 1 && col < colCount - 1) {
            result = Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return widget.tableHeaderBuilder(
                        context,
                        col,
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
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
            );
          } else {
            result = widget.tableHeaderBuilder(
              context,
              col,
              BoxConstraints.tightFor(
                width: colSizes[col],
                height: _kHeaderHeight,
              ),
            );
          }

          return ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: _kHeaderHeight,
              width: colSizes[col],
            ),
            child: result,
          );
        }).toList(),
      ),
    );
  }

  Widget createList(int index) {
    final int lastNonZero = colSizes.lastIndexWhere((elem) => elem > 0.0);
    final List<double> colElems = colSizes.where((e) => e > 0.0).toList();

    return MouseRegion(
      onEnter: (_) => dragging ? null : setState(() => hoveredIndex = index),
      onExit: (_) => dragging ? null : setState(() => hoveredIndex = -1),
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTapDown: dragging
            ? null
            : widget.onPressed != null
                ? (_) => setState(() => pressedIndex = index)
                : null,
        onTapUp: dragging
            ? null
            : widget.onPressed != null
                ? (_) => setState(() => pressedIndex = -1)
                : null,
        onTapCancel: dragging ? null : () => setState(() => pressedIndex = -1),
        onTap: dragging
            ? null
            : widget.onPressed != null
                ? () {
                    if (waitingIndex == index) {
                      return;
                    }
                    waitingIndex = index;
                    final dynamic result = widget.onPressed!(index)
                        as dynamic; // TODO(as): fix dynamic

                    if (result is Future) {
                      setState(() => waitingIndex = index);
                      result.then((_) => setState(() => waitingIndex = -1));
                    } else {
                      waitingIndex = -1;
                    }
                  }
                : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(colElems.length, (col) {
            assert(col < colSizes.length);

            Widget result = LayoutBuilder(
              builder: (context, constraints) => widget.tableRowBuilder(
                context,
                index,
                col,
                constraints,
              ),
            );

            result = Align(alignment: Alignment.bottomLeft, child: result);

            final ListTableThemeData listTableThemeData =
                ListTableTheme.of(context);

            final HSLColor? backgroundColor =
                pressedIndex == index || waitingIndex == index
                    ? listTableThemeData.highlightColor
                    : hoveredIndex == index
                        ? listTableThemeData.hoverColor
                        : null;

            BoxDecoration decoration =
                BoxDecoration(color: backgroundColor?.toColor());

            // TODO(as): ???
            if (widget.tableBorder != null &&
                (widget.tableBorder!.horizontalInside != BorderSide.none ||
                    widget.tableBorder!.verticalInside != BorderSide.none)) {
              final isBottom = index < widget.itemCount - 1 || hasExtent;
              final isRight = col < widget.colCount - 1 && col < lastNonZero;

              final horizontalInside = widget.tableBorder!.horizontalInside;
              final verticalInside = widget.tableBorder!.verticalInside;

              final bottom = isBottom ? horizontalInside : BorderSide.none;

              // TODO(as): Put this shit somewhere else.
              final headerColumnBorder = widget.headerColumnBorder ??
                  widget.tableBorder?.verticalInside;
              final dragBorderWidth = headerColumnBorder != null &&
                      headerColumnBorder != BorderSide.none
                  ? headerColumnBorder.width +
                      (headerColumnBorder.width / 2.0).roundToDouble()
                  : 2.0;

              final right = dragging && colDragging == col
                  ? BorderSide(
                      color: listTableThemeData.borderHighlightColor!.toColor(),
                      width: dragBorderWidth,
                    )
                  : isRight
                      ? verticalInside
                      : BorderSide.none;

              final border = Border(bottom: bottom, right: right);
              decoration = decoration.copyWith(border: border);
            } else if (dragging && colDragging == col) {
              final right = BorderSide(
                color: listTableThemeData.borderHighlightColor!.toColor(),
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

  List<double> colSizes = List.empty(growable: true);
  Map<int, double>? colFraction;

  bool dragging = false;
  int? colDragging;
  double? previousWidth;
  double? totalWidth;
  List<double>? previousColSizes;
  Map<int, double>? previousColFraction;

  int get colCount => colSizes.length;

  ScrollController? currentController;
  ScrollController get controller =>
      widget.controller ?? (currentController ??= ScrollController());

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
      colFraction![col] = newWidth / totalWidth!;

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
          if (remWidth >= _kMinColumnWidth) {
            final double newWidth = (previousColSizes![i] - valueEach)
                .clamp(_kMinColumnWidth, remWidth);
            colFraction![i] = newWidth / totalWidth!;

            remWidth -= newWidth;
          } else {
            colFraction![i] = 0.0;
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
  }

  bool hasExtent = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance!.addPostFrameCallback((Duration duration) {
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

    for (var i = 0; i < colCount; i++) {
      if (remWidth <= 0.0) {
        remWidth = 0.0;
        break;
      }

      if (colFraction!.containsKey(i)) {
        if (remWidth >= _kMinColumnWidth) {
          // The last item.
          if (i == colCount - 1) {
            colSizes[i] = remWidth;
            remWidth = 0.0;
            break;
          }

          double width = (colFraction![i]! * totalWidth!)
              .clamp(_kMinColumnWidth, remWidth);

          if (dragging && false) {
            colSizes[i] = width;
          } else {
            width = width.floorToDouble();
            colSizes[i] = width;
          }

          remWidth -= width;

          if (remWidth < 0.0) {
            throw Exception(
                'Wrong fraction value at $i value ${colFraction![i]}.');
          }
        } else {
          break;
        }
      } else {
        throw Exception('Could not find fraction for index $i.');
      }
    }

    if (remWidth > 0.0) {
      final int key =
          colSizes.lastIndexWhere((value) => value > 0.0);
      colSizes[key] = colSizes[key] + remWidth;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget result = LayoutBuilder(
      builder: (context, constraints) {
        totalWidth = constraints.maxWidth;
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

    final tableBorder = widget.tableBorder;

    if (tableBorder != null &&
        (tableBorder.left != BorderSide.none ||
            tableBorder.right != BorderSide.none ||
            tableBorder.top != BorderSide.none ||
            tableBorder.bottom != BorderSide.none)) {
      result = Container(
        decoration: BoxDecoration(
          border: Border(
            left: tableBorder.left,
            right: tableBorder.right,
            top: tableBorder.top,
            bottom: tableBorder.bottom,
          ),
        ),
        child: result,
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: result,
    );
  }
}

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
    this.border,
    Key? key,
  }) : super(key: key);

  final bool hasIndicator;
  final _TableDragUpdate tableDragUpdate;
  final int col;
  final BorderSide? border;

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
      final HSLColor borderColor = dragged
          ? listTableTheme.borderHighlightColor!
          : hovered
              ? listTableTheme.borderHoverColor!
              : widget.hasIndicator
                  ? listTableTheme.borderIndicatorColor!
                  : HSLColor.fromColor(border.color);

      border = border.copyWith(
          color: borderColor.toColor(),
          width: expanded
              ? border.width + (border.width / 2.0).roundToDouble()
              : border.width);
    } else {
      final width = expanded ? 2.0 : 1.0;
      final borderColor = dragged
          ? listTableTheme.borderHighlightColor!
          : hovered
              ? listTableTheme.borderHoverColor!
              : widget.hasIndicator
                  ? listTableTheme.borderIndicatorColor!
                  : listTableTheme.borderColor!;
      border = BorderSide(width: width, color: borderColor.toColor());
    }

    return RawGestureDetector(
      gestures: _gestures,
      behavior: HitTestBehavior.translucent,
      child: MouseRegion(
        opaque: false,
        cursor: SystemMouseCursors.click,
        onEnter: _handleMouseEnter,
        onExit: _handleMouseExit,
        child: Container(
          margin: const EdgeInsets.only(left: _kHandlerWidth),
          decoration: BoxDecoration(border: Border(right: border)),
        ),
      ),
    );
  }
}
