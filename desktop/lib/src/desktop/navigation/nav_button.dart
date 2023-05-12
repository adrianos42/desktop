import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../input/button.dart';
import '../theme/theme.dart';
import 'nav.dart';

/// Nav Group
class NavGroup extends StatefulWidget {
  ///
  const NavGroup({
    super.key,
    required this.navItems,
    required this.enabled,
    required this.index,
    required this.axis,
    required this.onChanged,
    required this.navWidgets,
  });

  final Axis axis;

  final int index;

  final List<NavItem> navItems;

  final IndexedWidgetBuilder navWidgets;

  final bool enabled;

  final ValueChanged<int> onChanged;

  @override
  State<NavGroup> createState() => _NavGroupState();
}

class _NavGroupState extends State<NavGroup> with TickerProviderStateMixin {
  late List<double> itemLengths;

  @override
  void initState() {
    super.initState();
    itemLengths =
        List<double>.filled(widget.navItems.length, 0.0, growable: true);
  }

  @override
  Widget build(BuildContext context) {
    final axis = widget.axis;

    final titleItems = List<Widget>.empty(growable: true);

    final NavThemeData navThemeData = NavTheme.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    final bool enabled = widget.enabled;
    final highlightColor = colorScheme.shade[100];

    for (int index = 0; index < widget.navItems.length; index++) {
      final bool active = widget.index == index;

      BoxConstraints constraints;
      final EdgeInsets buttonBodyPadding;
      final double buttonHeight;
      double? buttonWidth;
      final Function(Size) onLayout;

      if (axis == Axis.horizontal) {
        constraints = BoxConstraints.tightFor(height: navThemeData.height);
        onLayout = (Size value) => itemLengths[index] = value.width;
        buttonBodyPadding =
            EdgeInsets.symmetric(horizontal: navThemeData.itemsSpacing!);
        buttonHeight = navThemeData.height!;
      } else {
        constraints = BoxConstraints.tightFor(
          width: navThemeData.width,
          height: navThemeData.width,
        );
        onLayout = (Size value) => itemLengths[index] = value.height;
        buttonBodyPadding = EdgeInsets.zero;
        buttonHeight = navThemeData.width!;
        buttonWidth = navThemeData.width;
      }

      final TextStyle textStyle = textTheme.body2.copyWith(fontSize: 14.0);
      final IconThemeData iconThemeData = navThemeData.iconThemeData!;
      final color = textTheme.textLow;
      final hoverColor = textTheme.textHigh;

      titleItems.add(
        _NavButtonItem(
          onLayout: onLayout,
          child: Container(
            constraints: constraints,
            alignment: Alignment.center,
            child: Button(
              body: widget.navWidgets(context, index),
              padding: EdgeInsets.zero,
              bodyPadding: buttonBodyPadding,
              onPressed: enabled ? () => widget.onChanged(index) : null,
              theme: ButtonThemeData(
                color: active ? highlightColor : color,
                highlightColor: highlightColor,
                hoverColor: active ? highlightColor : hoverColor,
                textStyle: textStyle,
                iconThemeData: iconThemeData,
                height: buttonHeight,
                minWidth: buttonWidth,
                axis: axis,
              ),
              // TODO(as): tooltip: navItem.title,
            ),
          ),
        ),
      );
    }

    final double renderIndicatorLength = navThemeData.indicatorWidth!;
    final double renderMainLength =
        itemLengths.reduce((value, elem) => value + elem);

    double renderHeight;
    double renderWidth;
    double crossLenth;
    BoxConstraints constraints;

    if (axis == Axis.horizontal) {
      final double height = navThemeData.height!;
      crossLenth = height;
      renderHeight = renderIndicatorLength;
      renderWidth = renderMainLength;
      constraints = BoxConstraints.tightFor(height: height);
    } else {
      final double width = navThemeData.width!;
      crossLenth = width;
      renderWidth = renderIndicatorLength;
      renderHeight = renderMainLength;
      constraints = BoxConstraints.tightFor(width: width);
    }

    return Container(
      constraints: constraints,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Flex(
            direction: axis,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: titleItems,
          ),
          _SideIconRenderObjectWidget(
            vsync: this,
            duration: navThemeData.animationDuration!,
            lengths: itemLengths,
            axis: axis,
            crossLength: crossLenth,
            sideLength: navThemeData.indicatorWidth!,
            additionalConstraints: BoxConstraints.tightFor(
              height: renderHeight,
              width: renderWidth,
            ),
            index: widget.index,
            foreground: enabled ? highlightColor : colorScheme.disabled,
          ),
        ],
      ),
    );
  }
}

class _NavButtonItem extends SingleChildRenderObjectWidget {
  const _NavButtonItem({
    required this.onLayout,
    required super.child,
  });

  final ValueChanged<Size> onLayout;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _NavButtonRenderItem(onLayout);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _NavButtonRenderItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _NavButtonRenderItem extends RenderProxyBox {
  _NavButtonRenderItem(this.onLayout);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    super.performLayout();
    onLayout(size);
  }
}

class _SideIconRenderObjectWidget extends LeafRenderObjectWidget {
  const _SideIconRenderObjectWidget({
    required this.index,
    required this.vsync,
    required this.additionalConstraints,
    required this.foreground,
    required this.duration,
    required this.axis,
    required this.sideLength,
    required this.lengths,
    required this.crossLength,
  });

  final int index;
  final TickerProvider vsync;
  final BoxConstraints additionalConstraints;
  final Color foreground;
  final Duration duration;
  final Axis axis;
  final double sideLength;
  final double crossLength;
  final List<double> lengths;

  @override
  _RenderIconSide createRenderObject(BuildContext context) => _RenderIconSide(
        index: index,
        vsync: vsync,
        additionalConstraints: additionalConstraints,
        axis: axis,
        lengths: lengths,
        sideLength: sideLength,
        crossLength: crossLength,
        duration: duration,
        foreground: foreground,
      );

  @override
  void updateRenderObject(BuildContext context, _RenderIconSide renderObject) {
    renderObject
      ..index = index
      ..additionalConstraints = additionalConstraints
      ..foreground = foreground
      ..sideLength = sideLength
      ..axis = axis
      ..crossLength = crossLength
      ..lengths = lengths
      ..vsync = vsync;
  }
}

class _RenderIconSide extends RenderConstrainedBox {
  _RenderIconSide({
    required int index,
    required TickerProvider vsync,
    required Duration duration,
    required this.foreground,
    required this.sideLength,
    required this.axis,
    required this.crossLength,
    required this.lengths,
    required super.additionalConstraints,
  })  : _oldIndex = index,
        _index = index,
        _vsync = vsync {
    _positionController = AnimationController(
      duration: duration,
      value: 0.0,
      vsync: vsync,
    );

    _position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.easeOutQuad,
    )..addListener(markNeedsPaint);
    //..addStatusListener(_handlePositionStateChanged);
  }

  int get index => _index;
  int _index;
  set index(int value) {
    if (value == _index) {
      return;
    }
    _oldIndex = _index;
    _index = value;

    markNeedsSemanticsUpdate();

    _positionController.value = 0.0;

    _position.curve = Curves.easeOut;

    _positionController.forward();
  }

  int _oldIndex;
  int get oldIndex => _oldIndex;

  Color foreground;

  List<double> lengths;

  Axis axis;

  double sideLength;

  double crossLength;

  TickerProvider get vsync => _vsync;
  TickerProvider _vsync;
  set vsync(TickerProvider value) {
    if (value == _vsync) {
      return;
    }
    _vsync = value;
    positionController.resync(vsync);
  }

  AnimationController get positionController => _positionController;
  late AnimationController _positionController;

  CurvedAnimation get position => _position;
  late CurvedAnimation _position;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);

    _positionController.forward();
  }

  @override
  void detach() {
    _positionController.stop();
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(index < lengths.length);
    assert(oldIndex < lengths.length);

    final Canvas canvas = context.canvas;
    final Paint paint = Paint()..color = foreground;

    Rect rectLast;
    Rect rectNew;

    final double lOldOffset =
        lengths.sublist(0, oldIndex).fold(0.0, (value, elem) => value + elem);
    final double oldLength = lengths[oldIndex];

    final double lOffset =
        lengths.sublist(0, index).fold(0.0, (value, elem) => value + elem);
    final double length = lengths[index];

    if (axis == Axis.horizontal) {
      final double dy = offset.dy + crossLength - sideLength;
      final double dx = offset.dx + lOffset;
      final double oldDx = offset.dx + lOldOffset;

      rectLast = Rect.fromLTWH(oldDx, dy, oldLength, sideLength);
      rectNew = Rect.fromLTWH(dx, dy, length, sideLength);
    } else {
      final double dx = offset.dx;
      final double dy = offset.dy + lOffset;
      final double oldDy = offset.dy + lOldOffset;

      rectLast = Rect.fromLTWH(dx, oldDy, sideLength, oldLength);
      rectNew = Rect.fromLTWH(dx, dy, sideLength, length);
    }

    final RectTween rectTween = RectTween(begin: rectLast, end: rectNew);

    canvas.drawRect(rectTween.lerp(position.value)!, paint);
  }
}

///
class NavMenuButton extends StatelessWidget {
  ///
  const NavMenuButton(
    this.child, {
    super.key,
    this.tooltip,
    this.onPressed,
    required this.axis,
    required this.active,
  });

  final String? tooltip;

  final Widget child;

  final VoidCallback? onPressed;

  final bool active;

  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final NavThemeData navThemeData = NavTheme.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    final highlightColor = colorScheme.shade[100];

    final TextStyle textStyle = textTheme.body2.copyWith(fontSize: 14.0);
    final IconThemeData iconThemeData = navThemeData.iconThemeData!;
    final color = textTheme.textLow;
    final hoverColor = colorScheme.shade[100];

    final EdgeInsets buttonBodyPadding;
    final double buttonHeight;
    double? buttonWidth;

    if (axis == Axis.horizontal) {
      buttonBodyPadding = EdgeInsets.symmetric(
        horizontal: navThemeData.itemsSpacing!,
      );
      buttonHeight = navThemeData.height!;
    } else {
      buttonBodyPadding = EdgeInsets.zero;
      buttonHeight = navThemeData.width!;
      buttonWidth = navThemeData.width;
    }

    return Button(
      padding: EdgeInsets.zero,
      bodyPadding: buttonBodyPadding,
      onPressed: onPressed,
      tooltip: tooltip,
      body: child,
      theme: ButtonThemeData(
        color: active ? highlightColor : color,
        highlightColor: highlightColor,
        hoverColor: active ? highlightColor : hoverColor,
        textStyle: textStyle,
        height: buttonHeight,
        minWidth: buttonWidth,
        iconThemeData: iconThemeData,
        axis: axis,
      ),
    );
  }
}
