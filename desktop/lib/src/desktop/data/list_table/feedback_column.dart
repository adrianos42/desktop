import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'list_table_render.dart';

///
@immutable
class FeedbackHeaderItem {
  ///
  const FeedbackHeaderItem({
    this.decoration,
    required this.columnBorder,
    required this.builder,
    required this.itemExtent,
  });

  ///
  final Decoration? decoration;

  ///
  final IndexedWidgetBuilder builder;

  ///
  final BorderSide columnBorder;

  ///
  final double itemExtent;
}

///
@immutable
class FeedbackRowItem {
  ///
  const FeedbackRowItem({
    this.decoration,
    required this.builder,
    required this.itemExtent,
  });

  ///
  final Decoration? decoration;

  ///
  final IndexedWidgetBuilder builder;

  ///
  final double itemExtent;
}

///
class FeedbackColumn extends StatelessWidget {
  ///
  const FeedbackColumn({
    super.key,
    required this.header,
    required this.rows,
    required this.tableBorder,
    required this.itemSize,
    required this.col,
    required this.backgroundColor,
  });

  ///
  final int col;

  ///
  final FeedbackHeaderItem header;

  ///
  final List<FeedbackRowItem> rows;

  ///
  final TableBorder tableBorder;

  ///
  final Size itemSize;

  ///
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowItems = [];
    double totalHeight = 0.0;

    for (int y = 0; y < rows.length; y += 1) {
      rowItems.add(rows[y].builder(context, col));
      totalHeight += rows[y].itemExtent;

      if (totalHeight >= itemSize.height) {
        break;
      }
    }

    return SizedBox(
      width: itemSize.width,
      height: itemSize.height,
      child: Stack(
        children: [
          _FeedbackColumnItems(
            children: [header.builder(context, col), ...rowItems],
            heights: [
              header.itemExtent,
              ...List.generate(
                  rowItems.length, (index) => rows[index].itemExtent)
            ],
            tableBorder: tableBorder,
            backgroundColor: backgroundColor,
            headerBorder: header.columnBorder,
            headerDecoration: header.decoration,
            headerExtent: header.itemExtent,
          )
        ],
      ),
    );
  }
}

@immutable
class _FeedbackColumnItems extends MultiChildRenderObjectWidget {
  _FeedbackColumnItems({
    required super.children,
    required this.headerExtent,
    required this.headerDecoration,
    required this.headerBorder,
    required this.tableBorder,
    required this.backgroundColor,
    required this.heights,
  });

  final double headerExtent;

  final Decoration? headerDecoration;

  final BorderSide headerBorder;

  final TableBorder tableBorder;

  final Color backgroundColor;

  final List<double> heights;

  @override
  _FeedbackColumnRender createRenderObject(BuildContext context) {
    return _FeedbackColumnRender(
      headerBorder: headerBorder,
      headerExtent: headerExtent,
      headerDecoration: headerDecoration,
      tableBorder: tableBorder,
      configuration: createLocalImageConfiguration(context),
      backgroundColor: backgroundColor,
      heights: heights,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _FeedbackColumnRender renderObject) {
    renderObject
      ..headerBorder = headerBorder
      ..headerExtent = headerExtent
      ..headerDecoration = headerDecoration
      ..tableBorder = tableBorder
      ..configuration = createLocalImageConfiguration(context)
      ..backgroundColor = backgroundColor
      ..heights = heights;
  }
}

class _FeedbackColumnParentData extends ContainerBoxParentData<RenderBox> {}

///
class _FeedbackColumnRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _FeedbackColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _FeedbackColumnParentData> {
  ///
  _FeedbackColumnRender({
    required BorderSide headerBorder,
    required TableBorder tableBorder,
    required Color backgroundColor,
    Decoration? headerDecoration,
    ImageConfiguration configuration = ImageConfiguration.empty,
    List<RenderBox>? children,
    required double headerExtent,
    required List<double> heights,
  })  : _headerExtent = headerExtent,
        _configuration = configuration,
        _backgroundColor = backgroundColor,
        _headerBorder = headerBorder,
        _tableBorder = tableBorder,
        _headerDecoration = headerDecoration,
        _heights = heights {
    addAll(children);
  }

  TableBorder get tableBorder => _tableBorder;
  TableBorder _tableBorder;
  set tableBorder(TableBorder value) {
    if (_tableBorder != value) {
      _tableBorder = value;
      markNeedsLayout();
    }
  }

  BorderSide get headerBorder => _headerBorder;
  BorderSide _headerBorder;
  set headerBorder(BorderSide value) {
    if (_headerBorder != value) {
      _headerBorder = value;
      markNeedsLayout();
    }
  }

  ///
  Color get backgroundColor => _backgroundColor;
  Color _backgroundColor;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      _backgroundColor = value;
      markNeedsPaint();
    }
  }

  ///
  double get headerExtent => _headerExtent;
  double _headerExtent;
  set headerExtent(double value) {
    if (_headerExtent != value) {
      _headerExtent = value;
      markNeedsLayout();
    }
  }

  Decoration? get headerDecoration => _headerDecoration;
  Decoration? _headerDecoration;
  BoxPainter? _headerDecorationPainter;
  set headerDecoration(Decoration? value) {
    if (_headerDecoration != value) {
      _headerDecoration = value;
      _headerDecorationPainter?.dispose();
      _headerDecorationPainter = null;
      markNeedsPaint();
    }
  }

  List<double> get heights => _heights;
  List<double> _heights;
  set heights(List<double> value) {
    if (_heights != value) {
      _heights = value;
      markNeedsLayout();
    }
  }

  ImageConfiguration get configuration => _configuration;
  ImageConfiguration _configuration;
  set configuration(ImageConfiguration value) {
    if (value != _configuration) {
      _configuration = value;
      markNeedsPaint();
    }
  }

  @override
  void dispose() {
    _clipLayer.layer = null;
    super.dispose();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _FeedbackColumnParentData) {
      child.parentData = _FeedbackColumnParentData();
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    final List<double> positions = List<double>.filled(_heights.length, 0.0);

    positions[0] = 0.0;
    for (int y = 1; y < _heights.length; y += 1) {
      positions[y] = positions[y - 1] + _heights[y - 1];
    }

    int y = 0;
    RenderBox? child = firstChild;

    while (child != null) {
      final _FeedbackColumnParentData childParentData =
          child.parentData! as _FeedbackColumnParentData;

      child.layout(BoxConstraints.tightFor(
        width: constraints.maxWidth,
        height: _heights[y],
      ));
      childParentData.offset = Offset(0.0, positions[y]);

      child = childParentData.nextSibling;
      y += 1;
    }

    size = constraints.constrain(Size(
      constraints.maxWidth,
      constraints.maxHeight,
    ));
  }

  void _paintInsideBorders(Canvas canvas, Offset offset) {
    final Paint paint = Paint();
    final Path path = Path();

    double y = 0.0;

    for (int i = 0; i < childCount; i += 1) {
      y += _heights[i];

      final BorderSide borderSide =
          i == 0 ? _headerBorder : _tableBorder.horizontalInside;

      if (borderSide.style != BorderStyle.solid) {
        continue;
      }

      final double lineWidth = borderSide.width;

      paint.color = borderSide.color;
      paint.isAntiAlias = lineWidth == 0;

      path.reset();

      path.moveTo(
        offset.dx,
        offset.dy + y,
      );
      path.lineTo(
        offset.dx + size.width,
        offset.dy + y,
      );

      if (borderSide.width == 0.0) {
        paint.style = PaintingStyle.stroke;
      } else {
        paint.style = PaintingStyle.fill;

        path.lineTo(
          offset.dx + size.width,
          offset.dy + y - lineWidth,
        );
        path.lineTo(
          offset.dx,
          offset.dy + y - lineWidth,
        );
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    canvas.drawRect(
      Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    _clipLayer.layer = context.pushClipRect(
      needsCompositing,
      offset,
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      (context, offset) {
        RenderBox? child = firstChild;
        while (child != null) {
          final _FeedbackColumnParentData childParentData =
              child.parentData! as _FeedbackColumnParentData;
          context.paintChild(child, childParentData.offset + offset);
          child = childParentData.nextSibling;
        }

        _paintInsideBorders(canvas, offset);
      },
      clipBehavior: Clip.hardEdge,
      oldLayer: _clipLayer.layer,
    );

    ListTableRender.paintStaticTableBorder(canvas, offset, size, tableBorder);
  }

  final LayerHandle<ClipRectLayer> _clipLayer = LayerHandle<ClipRectLayer>();
}
